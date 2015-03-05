% Function to generate plots in the U plane for the AR and PW model. 
% Inputs: model - 1 means AR model, 2 means PW model.
%         validity - boolean indicating whether or not validity is being
%                    considered
% Generates 3 plots: curves for lambda1, curves for lambda2, and both
% curves for a given point if validity = false. curves for lambda1 with
% contour lines overlayed, and valid shocks and rarefactions for ql and qr
% if validity = true.
% Note: expects that the function "variableSetup" has been run.

function Ufigs = UPlot(model,validity)

global v_star rho_star p pprime rho size_font 

if (model == 1)
    
    % Setting up equations
    for h = 1:length(v_star)
        for k = 1:length(rho)
            v1(h,k) = v_star(h) + p(rho_star(h)) - p(rho(k));
            v2(h,k) = v_star(h);
        end
    end
    
    % Plotting 1-curves
    Ufigs(1) = figure;
    plot(rho,v1,'k')
    
    axis([0 1 0 1])
    set(gca,'XTick',[0 1])
    set(gca,'YTick',[0 1])
    state = 1;

    if (~validity)
        % Plotting 2-curves
        Ufigs(2) = figure;
        plot(rho,v2,'b')
        
        axis([0 1 0 1])
        set(gca,'XTick',[0 1])
        set(gca,'YTick',[0 1])
        
        % Plotting both curves for a given initial state
        Ufigs(3) = figure;
        plot(rho,v1(state,:),'k')
        hold on
        plot(rho,v2(state,:),'b')
        plot(rho_star(state),v_star(state),'ro', 'LineWidth', 2)
    
        axis([0 1 0 1])
        set(gca,'XTick',[0 1])
        set(gca,'YTick',[0 1])
    else
        % Creating contours for lambda1 = v - p'(rho)*rho
        % Solving for v gives v = lambda1 + p'(rho)*rho
        lambda = [0 0.3 0.6];
        for h = 1:length(lambda)
            for k = 1:length(rho)
                contourU(h,k) = lambda(h) + pprime(rho(k))*rho(k);
            end
        end
        
        hold on
        plot(rho,contourU,'m')
        text(0.75,0.23,'\lambda_1 = 0','FontSize',size_font)
        text(0.75,0.53,'\lambda_1 = 0.3','FontSize',size_font)
        text(0.75,0.83,'\lambda_1 = 0.6','FontSize',size_font)

        % Finding index for given point 
        switch_index = find(rho==rho_star(state));

        % Plotting valid states for ql
        Ufigs(2) = figure;
        plot(rho(1:switch_index),v1(state,1:switch_index),'g')
        hold on
        plot(rho(switch_index:end),v1(state,switch_index:end),'r')
        
        % Plotting valid states for qr
        Ufigs(3) = figure;
        plot(rho(1:switch_index),v1(state,1:switch_index),'r')
        hold on
        plot(rho(switch_index:end),v1(state,switch_index:end),'g')
        
        % Plotting contact discontinuity and point
        for k = 2:3
            figure(Ufigs(k))
            plot(rho,v2(state,:),'b')
            plot(rho_star(state),v_star(state),'ro', 'LineWidth', 2)
            x = rho_star(state)+0.01;
            y = v_star(state)+0.05;            
            
            if (k == 2)
                text(x,y,'$u_l$','Interpreter','latex','FontSize',size_font)
            else
                text(x,y,'$u_r$','Interpreter','latex','FontSize',size_font)
            end
            
            axis([0 1 0 1])
            set(gca,'XTick',[0 1])
            set(gca,'YTick',[0 1])
        end
    end

elseif (model == 2)
    % TODO: Add code for PW model
else
    display('Error: Model number must be either 1 or 2')
end

% Formatting figures
for k = 1:length(Ufigs)
    figure(Ufigs(k))
    hXLabel = xlabel('$\rho$','Interpreter','latex');
    hYLabel = ylabel('$v$','Interpreter','latex');
    set([hXLabel, hYLabel], 'FontSize', size_font);
    set(gca,'FontSize',size_font)
    set(gcf, 'Color', 'w');
end