! =========================================================
subroutine rp1(maxmx,meqn,mwaves,maux,mbc,mx,ql,qr,auxl,auxr,wave,s,amdq,apdq)
! =========================================================

! Solve Riemann problems for the 1D PW equations
!   (rho)_t + (rho*v)_x = 0
!   (rho*v)_t + (rho*v^2 + rho^gamma)_x = 0
! using Roe's approximate Riemann solver with entropy fix for
! transonic rarefactions.

! waves: 2
! equations: 2

! Conserved quantities:
!       1 density
!       2 momentum

! This function solves the Riemann problem at all interfaces in one call

! On input, ql contains the state vector at the left edge of each cell
!           qr contains the state vector at the right edge of each cell
! On output, wave contains the waves,
!            s the speeds,
!            amdq the  left-going flux difference  A^- \Delta q
!            apdq the right-going flux difference  A^+ \Delta q

! Note that the i'th Riemann problem has left state qr(:,i-1)
!                                    and right state ql(:,i)
! From the basic clawpack routine step1, rp is called with ql = qr = q.


    implicit double precision (a-h,o-z)

    dimension   ql(meqn,1-mbc:maxmx+mbc)
    dimension   qr(meqn,1-mbc:maxmx+mbc)
    dimension    s(mwaves,1-mbc:maxmx+mbc)
    dimension wave(meqn, mwaves,1-mbc:maxmx+mbc)
    dimension amdq(meqn,1-mbc:maxmx+mbc)
    dimension apdq(meqn,1-mbc:maxmx+mbc)

!     # Local storage
!     ---------------
    dimension delta(2)
    logical :: efix

    data efix /.true./    !# use entropy fix for transonic rarefactions

    gamma = 0.2d0

!     # Main loop of the Riemann solver.
    do 30 i=2-mbc,mx+mbc


    !     # compute  Roe-averaged quantities:
        rbar = 0.5d0*(qr(1,i-1) + ql(1,i))
        cbar = dsqrt(gamma*rbar**(gamma-1.0d0))
        if (rbar == 0) then
            ubar = 0
        else
            ubar = (qr(2,i-1)*dsqrt(qr(1,i-1)) + ql(2,i)*dsqrt(ql(1,i)))/ &
            ( dsqrt(qr(1,i-1)) + dsqrt(ql(1,i)) )
        endif


    !     # delta(1)=rho(i)-rho(i-1) and  delta(2)=rho*v(i)-rho*v(i-1)
        delta(1) = ql(1,i) - qr(1,i-1)
        delta(2) = ql(2,i) - qr(2,i-1)

    !     # Compute coeffs in the evector expansion of delta(1),delta(2)
        if (cbar == 0) then
            a1 = 0
            a2 = 0
        else
            a1 = 0.5d0*(-delta(2) + (ubar + cbar) * delta(1))/cbar
            a2 = 0.5d0*( delta(2) - (ubar - cbar) * delta(1))/cbar
        endif

    !     # Finally, compute the waves.
        wave(1,1,i) = a1
        wave(2,1,i) = a1*(ubar - cbar)
        s(1,i) = ubar - cbar

        wave(1,2,i) = a2
        wave(2,2,i) = a2*(ubar + cbar)
        s(2,i) = ubar + cbar

    30 END DO

!     # compute Godunov flux f0:
!     --------------------------

    if (efix) go to 110

!     # No entropy fix
!     ----------------
!     # amdq = SUM s*wave   over left-going waves
!     # apdq = SUM s*wave   over right-going waves

    do 100 m=1,2
        do 100 i=2-mbc, mx+mbc
            amdq(m,i) = 0.d0
            apdq(m,i) = 0.d0
            do 90 mw=1,mwaves
                if (s(mw,i) < 0.d0) then
                    amdq(m,i) = amdq(m,i) + s(mw,i)*wave(m,mw,i)
                else
                    apdq(m,i) = apdq(m,i) + s(mw,i)*wave(m,mw,i)
                endif
            90 END DO
    100 END DO
    go to 900

!-----------------------------------------------------


    110 continue

!     # With entropy fix
!     ------------------

!    # compute flux differences amdq and apdq.
!    # First compute amdq as sum of s*wave for left going waves.
!    # Incorporate entropy fix by adding a modified fraction of wave
!    # if s should change sign.

do 200 i=2-mbc,mx+mbc

    ! ------------------------------------------------------
    !        # check 1-wave:
    !        ---------------

    !        # u-c in left state (cell i-1)
        s0 = qr(2,i-1)/qr(1,i-1) - dsqrt(gamma*qr(1,i-1)**(gamma-1))

    !        # check for fully supersonic case:
        if (s0 >= 0.d0 .AND. s(1,i) > 0.d0)  then
        !            # everything is right-going
            do 60 m=1,2
                amdq(m,i) = 0.d0
            60 END DO
            go to 200
        endif

    !        # u-c to right of 1-wave
        rho_r1  = qr(1,i-1) + wave(1,1,i)
        rhov_r1 = qr(2,i-1) + wave(2,1,i)
        s1 =  rho_vr1/rho_r1 - dsqrt(gamma*rho_1**(gamma-1))

        if (s0 < 0.d0 .AND. s1 > 0.d0) then
        !            # transonic rarefaction in the 1-wave
            sfract = s0 * (s1-s(1,i)) / (s1-s0)
        else if (s(1,i) < 0.d0) then
        !	     # 1-wave is leftgoing
            sfract = s(1,i)
        else
        !	     # 1-wave is rightgoing
            sfract = 0.d0   !# this shouldn't happen since s0 < 0
        endif

        do 120 m=1,2
            amdq(m,i) = sfract*wave(m,1,i)
        120 END DO

    ! -------------------------------------------------------
    !        # check 2-wave:
    !        ---------------
    !        # u+c in right state  (cell i)
        s3 = ql(2,i)/ql(1,i) + dsqrt(gamma*ql(1,i)**(gamma-1))

    !        # u+c to left of 2-wave
        rho_l2  = ql(1,i) - wave(1,2,i)
        rho_vl2 = ql(2,i) - wave(2,2,i)
        s2 = rho_vl2/rho_l2 + dsqrt(gamma*rho_l2**(gamma-1))

        if (s2 < 0.d0 .AND. s3 > 0.d0) then
        !            # transonic rarefaction in the 2-wave
            sfract = s2 * (s3-s(2,i)) / (s3-s2)
        else if (s(2,i) < 0.d0) then
        !            # 2-wave is leftgoing
            sfract = s(2,i)
        else
        !            # 2-wave is rightgoing
            go to 200
        endif

        do 160 m=1,2
            amdq(m,i) = amdq(m,i) + sfract*wave(m,2,i)
        160 END DO
    200 END DO

!     # compute the rightgoing flux differences:
!     # df = SUM s*wave   is the total flux difference and apdq = df - amdq

    do 220 m=1,2
        do 220 i = 2-mbc, mx+mbc
            df = 0.d0
            do 210 mw=1,mwaves
                df = df + s(mw,i)*wave(m,mw,i)
            210 END DO
            apdq(m,i) = df - amdq(m,i)
    220 END DO



    900 continue
    return
    end subroutine rp1
