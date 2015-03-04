% Function to generate plots in the M plane for the AR and PW model.
% Inputs: model - 1 means AR model, 2 means PW model.
%         validity - boolean indicating whether or not validity is being
%                    considered
% Generates 3 plots: curves for lambda1, curves for lambda2, and both
% curves for a given point.
% Note: expects that the function "variableSetup" has been run.

function Mfigs = MPlot(model,validity)

global v_star rho_star p pprime rho size_font

if (model == 1)
    
    % Setting up equations
    for h = 1:length(v_star)
        for k = 1:length(rho)
            rv1(h,k) = rho(k)*(v_star(h) + p(rho_star(h)) - p(rho(k)));
            rv2(h,k) = v_star(h)*rho(k);
        end
    end
    
    % Plotting 1-curves
    Mfigs(1) = figure;
    plot(rho,rv1,'k')
    
    axis([0 5 0 1])
    set(gca,'XTick',[0 5])
    set(gca,'YTick',[0 1])
    
    state = 1;
    if (~validity)
        % Plotting 2-curves
        Mfigs(2) = figure;
        plot(rho,rv2,'b')
        
        axis([0 5 0 1])
        set(gca,'XTick',[0 5])
        set(gca,'YTick',[0 1])
        
        % Plotting both curves for a given initial state
        Mfigs(3) = figure;
        plot(rho,rv1(state,:),'k')
        hold on
        plot(rho,rv2(state,:),'b')
        plot(rho_star(state),...
            rho_star(state)*v_star(state),'ro', 'LineWidth', 2)
        
        axis([0 .7 0 .1])
        set(gca,'XTick',[0 .69])
        set(gca,'XTickLabel',{'0' '.7'})
        set(gca,'YTick',[0 .1])
        set(gca,'YTickLabel',{'0' '.1'})
    else
        % Creating contours for lambda1 = v - p'(rho)*rho
        % Solving for v gives v = lambda1 + p'(rho)*rho
        % So, rho*v = rho*(lambda1 + p'(rho)*rho)
        lambda = [0 0.3 0.6];
        for h = 1:length(lambda)
            for k = 1:length(rho)
                contourM(h,k) = rho(k)*(lambda(h) + pprime(rho(k))*rho(k));
            end
        end
        
        hold on
        plot(rho,contourM,'m')
        text(0.3,0.85,'\lambda_1 = 0','FontSize',size_font)
        text(1.8,0.85,'\lambda_1 = 0.3','FontSize',size_font)
        text(3.6,0.85,'\lambda_1 = 0.6','FontSize',size_font)
        
        
        % Finding index for given point 
        switch_index = find(rho==rho_star(state));
        
        % Plotting valid states for ql
        Mfigs(2) = figure;
        plot(rho(1:switch_index),rv1(state,1:switch_index),'r')
        hold on
        plot(rho(switch_index:end),rv1(state,switch_index:end),'g')
        
        % Plotting valid states for qr
        Mfigs(3) = figure;
        plot(rho(1:switch_index),rv1(state,1:switch_index),'g')
        hold on
        plot(rho(switch_index:end),rv1(state,switch_index:end),'r')
        
        for k = 2:3
            figure(Mfigs(k))
            plot(rho,rv2(state,:),'b')
            plot(rho_star(state),...
                rho_star(state)*v_star(state),'ro', 'LineWidth', 2)
            x = rho_star(state) + 0.02;
            y = rho_star(state)*v_star(state)-0.005;
            
            if (k == 2)
                text(x,y,'q_l','FontSize',size_font)
            else
                text(x,y,'q_r','FontSize',size_font)
            end
            
            axis([0 .7 0 .1])
            set(gca,'XTick',[0 .69])
            set(gca,'XTickLabel',{'0' '.7'})
            set(gca,'YTick',[0 .1])
            set(gca,'YTickLabel',{'0' '.1'})
        end
    end
    
elseif (model == 2)
    % TODO: Add code for PW model
else
    display('Model number must be either 1 or 2')
end

% Formatting figures
for k = 1:length(Mfigs)
    figure(Mfigs(k))
    hXLabel = xlabel('\rho');
    hYLabel = ylabel('m = \rho v');
    set([hXLabel, hYLabel], 'FontSize', size_font);
    set(gca,'FontSize',size_font)
    set(gcf, 'Color', 'w');
end