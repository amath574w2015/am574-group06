% Function to generate examples at the end of the Aw Rascle paper
% for the PW model.

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
for example = 1:3
    figure
    % Setting up data for the two points ql and qr
    if (example == 1)
        v_star = [0.2 .3];
        rho_star = [0.3 .4];
    elseif (example == 2)
        v_star = [0.05 .3];
        rho_star = [0.05 .4];
    else
        v_star = [0 .3];
        rho_star = [0 .4];
    end
    
    % Setting up equations
    for h = 1:length(v_star)
        for k = 1:length(rho)
            num = (rho(k) - rho_star(h))*(p(rho(k)) - p(rho_star(h)));
            denom = (rho(k)*rho_star(h));
            var = rho(k)*sqrt(num/denom);
            
            rv1_loci(h,k) = rho(k)*v_star(h) + var;
            rv2_loci(h,k) = rho(k)*v_star(h) - var;
            
            rv1_int(h,k) = rho(k)*(v_star(h) ...
                + (2/(gamma-1))*(sqrt(pprime(rho_star(h)))...
                - sqrt(pprime(rho(k)))));
            rv2_int(h,k) = rho(k)*(v_star(h) ...
                + (2/(gamma-1))*(-sqrt(pprime(rho_star(h)))...
                + sqrt(pprime(rho(k)))));
        end
    end
    
    % Loop plots each of the two points ql and qr
    for k = 1:length(rho_star)
        state = k;
        
        % Finding index for given point
        switch_index = find(rho==rho_star(state));
        
        if (k == 1)
            % lamdba1 curves
            plot(rho(switch_index:end),...
                rv2_loci(state,switch_index:end),'m')
            hold on
            plot(rho(1:switch_index),...
                rv1_int(state,1:switch_index),'Color',[0,1,0])
            
            % lambda2 curves
            plot(rho(1:switch_index),...
                rv2_loci(state,1:switch_index),'r')
            plot(rho(switch_index:end),...
                rv2_int(state,switch_index:end),'Color',[0,0.3,0])
            
            if (example == 1)
                x = rho_star(state) + 0.001;
                y = rho_star(state)*v_star(state)-0.007;
            else
                x = rho_star(state) + 0.01;
                y = rho_star(state)*v_star(state)-0.007;
            end
            text(x,y,'$q_l$','Interpreter',...
                'latex','FontSize',size_font)
        else
            % lamdba1 curves
            plot(rho(1:switch_index),...
                rv1_loci(state,1:switch_index),'m')
            hold on
            plot(rho(switch_index:end),...
                rv1_int(state,switch_index:end),'Color',[0,1,0])
            
            % lambda2 curves
            plot(rho(switch_index:end),...
                rv1_loci(state,switch_index:end),'r')
            plot(rho(1:switch_index),...
                rv2_int(state,1:switch_index),'Color',[0,0.3,0])
            
            if (example == 1)
                x = rho_star(state) + 0.001;
                y = rho_star(state)*v_star(state)-0.007;
            else
                x = rho_star(state) + 0.001;
                y = rho_star(state)*v_star(state)-0.05;
            end
            text(x,y,'$q_r$','Interpreter', 'latex','FontSize',size_font)
        end
        
        plot(rho_star(state),...
            rho_star(state)*v_star(state),'ro', 'LineWidth', 2)
    end
    
    % Adding middle state
    if (example == 1)
        % Values for middle state taken from Clawpack code
        rho_m = 0.321;
        rhov_m = 0.04868;
        plot(rho_m, rhov_m,'ro', 'LineWidth', 2)
        
        x = double(rho_m) + 0.001;
        y = double(rhov_m)-0.007;
        str = '$ q_m $';
        text(x, y, str,'Interpreter', 'latex','FontSize',size_font)
    end
    
    % Formating plot
    if (example == 1)
        axis([0.25 0.45 0 .15])
        set(gca,'XTick',[0.25 .45])
        set(gca,'XTickLabel',{'.25' '.45'})
        set(gca,'YTick',[0 .15])
        set(gca,'YTickLabel',{'0' '.15'})
    else
        axis([0 0.5 -0.5 0.5])
        set(gca,'XTick',[0 .5])
        set(gca,'XTickLabel',{'0' '.5'})
        set(gca,'YTick',[-0.5 .5])
        set(gca,'YTickLabel',{'-.5' '.5'})
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
            '../Images/PW_example1',... % name of output file
            '-painters', ...      % renderer
            '-jpg', ...           % file format
            '-r72' );             % resolution in dpi
        cd ..
    elseif (example == 2)
        cd export_fig_code
        export_fig( gcf, ...      % figure handle
            '../Images/PW_example2_smallql',... % name of output file
            '-painters', ...      % renderer
            '-jpg', ...           % file format
            '-r72' );             % resolution in dpi
        cd ..
    else
        cd export_fig_code
        export_fig( gcf, ...      % figure handle
            '../Images/PW_example2',... % name of output file
            '-painters', ...      % renderer
            '-jpg', ...           % file format
            '-r72' );             % resolution in dpi
        cd ..
    end
end