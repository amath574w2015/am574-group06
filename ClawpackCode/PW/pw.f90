! =========================================================
subroutine rp1(maxmx,meqn,mwaves,maux,mbc,mx,ql,qr,auxl,auxr,wave,s,amdq,apdq)
! =========================================================

! Solve Riemann problems for the 1D PW equations
!   (rho)_t + (rho*v)_x = 0
!   (rho*v)_t + (rho*v^2 + rho^gamma)_x = 0
! using an approximate Riemann solver

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
    gamma = 0.2d0

!     # Main loop of the Riemann solver.
    do 30 i=2-mbc,mx+mbc

    !     # compute  averaged quantities:
        rbar = 0.5d0*(qr(1,i-1) + ql(1,i))
        cbar = dsqrt(gamma*rbar**(gamma-1.0d0))
        ubar = 0.5d0*(qr(2,i-1)/qr(1,i-1) + ql(2,i)/ql(1,i))

    !     # delta(1)=rho(i)-rho(i-1) and  delta(2)=rho*v(i)-rho*v(i-1)
        delta(1) = ql(1,i) - qr(1,i-1)
        delta(2) = ql(2,i) - qr(2,i-1)

    !     # Compute coeffs in the evector expansion of delta(1),delta(2)
        a1 = 0.5d0*(-delta(2) + (ubar + cbar) * delta(1))/cbar
        a2 = 0.5d0*( delta(2) - (ubar - cbar) * delta(1))/cbar

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

    return
    end subroutine rp1
