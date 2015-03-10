% Function to generate examples at the end of the Aw Rascle paper.

clear all
close all
clc

% Declaring various starting values
gamma = 0.2;
p = @(x) x^gamma;
pprime = @(x) gamma*x^(gamma-1);
rho = 0:0.001:5;
size_font = 20;

% Loop plots both examples
for example = 1:2
    figure
    % Setting up data for the two points ql and qr
    if (example == 1)
        v_star = [0.2 .3];
        rho_star = [0.3 .4];
    else
        v_star = [0 .3];
        rho_star = [0 .4];
    end
    
    % Setting up equations
    for h = 1:length(v_star)
        for k = 1:length(rho)
            rv1(h,k) = rho(k)*(v_star(h) + p(rho_star(h)) - p(rho(k)));
            rv2(h,k) = v_star(h)*rho(k);
        end
    end
    
    % Loop plots each of the two points ql and qr
    for k = 1:length(rho_star)
        state = k;
        
        % Finding index for given point
        switch_index = find(rho==rho_star(state));
        
        x = rho_star(state) + 0.008;
        y = rho_star(state)*v_star(state)-0.005;
        if (k == 1)
            plot(rho(1:switch_index),rv1(state,1:switch_index),'g')
            hold on
            plot(rho(switch_index:end),rv1(state,switch_index:end),'r')
            text(x,y,'$q_l$','Interpreter', 'latex','FontSize',size_font)
        else
            plot(rho(1:switch_index),rv1(state,1:switch_index),'r')
            hold on
            plot(rho(switch_index:end),rv1(state,switch_index:end),'g')
            text(x,y,'$q_r$','Interpreter', 'latex','FontSize',size_font)
        end
        
        plot(rho,rv2(state,:),'b')
        plot(rho_star(state),...
            rho_star(state)*v_star(state),'ro', 'LineWidth', 2)
    end
    
    % Adding middle state
    if (example == 1)
        syms x
        eqn = x*(v_star(1) + p(rho_star(1)) - p(x)) ...
            == (v_star(2)*x);

        rho_m = vpasolve(eqn,[0.1;0.2]);
        rhov_m = rho_m*v_star(2);
        plot(rho_m, rhov_m,'ro', 'LineWidth', 2)
        
        x = double(rho_m) - 0.02;
        y = double(rhov_m) + 0.007;
        str = '$ q_m $';
        text(x, y, str,'Interpreter', 'latex','FontSize',size_font)
    end
    
    % Formating plot
    if (example == 1)
        axis([0 0.5 0 0.14])
        set(gca,'XTick',[0 .5])
        set(gca,'XTickLabel',{'0' '.5'})
        set(gca,'YTick',[0 .14])
    else
        axis([-0.05 0.5 0 0.14])
        set(gca,'XTick',[-.05 .5])
        set(gca,'XTickLabel',{'-.05' '.5'})
        set(gca,'YTick',[0 .14])
    end
    
    hXLabel = xlabel('$\rho$','Interpreter', 'latex');
    hYLabel = ylabel('$m = \rho v$','Interpreter', 'latex');
    set([hXLabel, hYLabel], 'FontSize', size_font);
    set(gca,'FontSize',size_font)
    set(gcf, 'Color', 'w');
    
    % Exporting figures
    if (example == 1)
        cd export_fig_code
        export_fig( gcf, ...      % figure handle
            '../Images/AR_example1',... % name of output file
            '-painters', ...      % renderer
            '-jpg', ...           % file format
            '-r72' );             % resolution in dpi
        cd ..
    else
        cd export_fig_code
        export_fig( gcf, ...      % figure handle
            '../Images/AR_example2',... % name of output file
            '-painters', ...      % renderer
            '-jpg', ...           % file format
            '-r72' );             % resolution in dpi
        cd ..
    end
end