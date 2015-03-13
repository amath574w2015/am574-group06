% Function to generate plots in the M plane for the AR and PW model.
% Inputs: model - 1 means AR model, 2 means PW model.
%         validity - boolean indicating whether or not validity is being
%                    considered
% Generates 3 plots: curves for lambda1, curves for lambda2, and both
% curves for a given point if validity = false. curves for lambda1 with
% contour lines overlayed, and valid shocks and rarefactions for ql and qr
% if validity = true.
% Note: expects that the function "variableSetup" has been run.

function Mfigs = MPlot(model,validity)

global v_star rho_star p pprime rho size_font gamma

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
        lambda = [0 0.3 0.5];
        for h = 1:length(lambda)
            for k = 1:length(rho)
                contourM(h,k) = rho(k)*(lambda(h) ...
                    + pprime(rho(k))*rho(k));
            end
        end
        
        hold on
        plot(rho,contourM,'c')
        text(0.18,0.85,'\lambda_1 = 0.5','FontSize',size_font)
        text(1.8,0.85,'\lambda_1 = 0.3','FontSize',size_font)
        text(3.6,0.85,'\lambda_1 = 0','FontSize',size_font)
        
        % Finding index for given point
        switch_index = find(rho==rho_star(state));
        
        % Plotting valid states for ql
        Mfigs(2) = figure;
        plot(rho(1:switch_index),rv1(state,1:switch_index),'g')
        hold on
        plot(rho(switch_index:end),rv1(state,switch_index:end),'r')
        
        % Plotting valid states for qr
        Mfigs(3) = figure;
        plot(rho(1:switch_index),rv1(state,1:switch_index),'r')
        hold on
        plot(rho(switch_index:end),rv1(state,switch_index:end),'g')
        
        for k = 2:3
            figure(Mfigs(k))
            plot(rho,rv2(state,:),'b')
            plot(rho_star(state),...
                rho_star(state)*v_star(state),'ro', 'LineWidth', 2)
            x = rho_star(state) + 0.01;
            y = rho_star(state)*v_star(state)-0.004;
            
            if (k == 2)
                text(x,y,'$q_l$','Interpreter',...
                    'latex','FontSize',size_font)
            else
                text(x,y,'$q_r$','Interpreter',...
                    'latex','FontSize',size_font)
            end
            
            axis([0 .7 0 .1])
            set(gca,'XTick',[0 .69])
            set(gca,'XTickLabel',{'0' '.7'})
            set(gca,'YTick',[0 .1])
            set(gca,'YTickLabel',{'0' '.1'})
        end
    end
    
    % Finished plotting for model = AR
    
elseif (model == 2)

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
    
   
    % Plotting all loci for a given state:
    Mfigs(1) = figure;
        
    for state = 1:3
        switch_index = find(rho==rho_star(state));
        
        % Loci for lambda 1
        plot(rho(1:switch_index),...
            rv1_loci(state,1:switch_index),'m')
        hold on
        plot(rho(switch_index:end),...
            rv2_loci(state,switch_index:end),'m')
        
        % Loci for lambda 2
        plot(rho(switch_index:end),...
            rv1_loci(state,switch_index:end),'r')
        plot(rho(1:switch_index),...
            rv2_loci(state,1:switch_index),'r')
        
        axis([0 0.3 -0.2 0.2])
        set(gca,'XTick',[0 .3])
        set(gca,'XTickLabel',{'0' '.3'})
        set(gca,'YTick',[-0.2 .2])
        set(gca,'YTickLabel',{'-.2' '.2'})
    end
    
    % Done plotting all loci for a given state
    
    
    % Plotting all integral curves for a given state:
    Mfigs(2) = figure;
    
    for state = 1:3
        plot(rho,rv1_int(state,:),'Color',[0,1,0])
        hold on
        plot(rho,rv2_int(state,:),'Color',[0,0.3,0])
        
        axis([0 0.3 -0.2 0.2])
        set(gca,'XTick',[0 .3])
        set(gca,'XTickLabel',{'0' '.3'})
        set(gca,'YTick',[-0.2 .2])
        set(gca,'YTickLabel',{'-.2' '.2'})
    end
    
    % Done plotting all integral curves for a given state
    
    
    % Plotting both curves for lambda1 for a given state:
    state = 1;
    switch_index = find(rho==rho_star(state));
    Mfigs(3) = figure;
    
    plot(rho(1:switch_index),...
        rv1_loci(state,1:switch_index),'m')
    hold on
    plot(rho(switch_index:end),...
        rv2_loci(state,switch_index:end),'m')   
    plot(rho,rv1_int(state,:),'Color',[0,1,0])
    plot(rho_star(state),...
        rho_star(state)*v_star(state),'ro', 'LineWidth', 2)
    
    axis([0 0.3 -0.1 0.2])
    set(gca,'XTick',[0 .3])
    set(gca,'XTickLabel',{'0' '.3'})
    set(gca,'YTick',[-0.1 .2])
    set(gca,'YTickLabel',{'-.1' '.2'})
    
    % Plotting contours for lambda1:
    % Creating contours for lambda1 = v - sqrt(p'(rho))
    % Solving for v gives v = lambda1 + sqrt(p'(rho))
    % So, rho*v = rho*(lambda1 + sqrt(p'(rho)))
    lambda = [-2 -1 0];
    for h = 1:length(lambda)
        for k = 1:length(rho)
            contourM(h,k) = rho(k)*(lambda(h) ...
                + sqrt(pprime(rho(k))));
        end
    end
    
    hold on
    plot(rho,contourM,'c')
    text(0.14,0.165,'\lambda_1 = 0','FontSize',size_font)
    text(0.15,0,'\lambda_1 = -1','FontSize',size_font)
    text(0.09,-0.07,'\lambda_1 = -2','FontSize',size_font)
    
    % Done plotting curves for lambda1
    
    
    % Plotting both curves for lambda2 for a given state:
    Mfigs(4) = figure;

    plot(rho(switch_index:end),...
        rv1_loci(state,switch_index:end),'r')
    hold on
    plot(rho(1:switch_index),...
        rv2_loci(state,1:switch_index),'r') 
    plot(rho,rv2_int(state,:),'Color',[0,0.3,0])
    plot(rho_star(state),...
        rho_star(state)*v_star(state),'ro', 'LineWidth', 2)
    
    axis([0 0.3 -0.1 0.2])
    set(gca,'XTick',[0 .3])
    set(gca,'XTickLabel',{'0' '.3'})
    set(gca,'YTick',[-0.1 .2])
    set(gca,'YTickLabel',{'-.1' '.2'})
    
    % Plotting contours for lambda2:
    % Creating contours for lambda2 = v + sqrt(p'(rho))
    % Solving for v gives v = lambda2 - sqrt(p'(rho))
    % So, rho*v = rho*(lambda2 - sqrt(p'(rho)))
    lambda = [0 0.7 2];
    for h = 1:length(lambda)
        for k = 1:length(rho)
            contourM(h,k) = rho(k)*(lambda(h) ...
                - sqrt(pprime(rho(k))));
        end
    end
    
    hold on
    plot(rho,contourM,'c')
    text(0.09,0.15,'\lambda_2 = 2','FontSize',size_font)
    text(0.22,-0.01,'\lambda_2 = 0.7','FontSize',size_font)
    text(0.08,-0.085,'\lambda_2 = 0','FontSize',size_font)
    
    % Done plotting curves for lamdba2
    
    % Plotting all curves for a given state ql,
    % With validity taken into account
    state = 1;
    Mfigs(5) = figure;
    
    % lamdba1 curves
    plot(rho(switch_index:end),...
        rv2_loci(state,switch_index:end),'m')  
    hold on
    plot(rho(1:switch_index),...
        rv1_int(state,1:switch_index),'Color',[0,1,0])
    
    % lambda2 curves
    plot(rho(1:switch_index),rv2_loci(state,1:switch_index),'r')
    plot(rho(switch_index:end),...
        rv2_int(state,switch_index:end),'Color',[0,0.3,0])
    
    % Plotting valid curves for qr
    Mfigs(6) = figure;
    
    % lamdba1 curves
    plot(rho(1:switch_index),...
        rv1_loci(state,1:switch_index),'m')  
    hold on
    plot(rho(switch_index:end),...
        rv1_int(state,switch_index:end),'Color',[0,1,0])
    
    % lambda2 curves
    plot(rho(switch_index:end),rv1_loci(state,switch_index:end),'r')
    plot(rho(1:switch_index),...
        rv2_int(state,1:switch_index),'Color',[0,0.3,0])
    
    for k = 5:6
        figure(Mfigs(k))
        plot(rho_star(state),...
            rho_star(state)*v_star(state),'ro', 'LineWidth', 2)
        x = 0.2;
        y = 0.02;
        
        if (k == 5)
            text(x,y,'$q_l$','Interpreter',...
                'latex','FontSize',size_font)
        else
            text(x,y,'$q_r$','Interpreter',...
                'latex','FontSize',size_font)
        end
        
        axis([0 0.3 -0.2 0.2])
        set(gca,'XTick',[0 .3])
        set(gca,'XTickLabel',{'0' '.3'})
        set(gca,'YTick',[-0.2 .2])
        set(gca,'YTickLabel',{'-.2' '.2'})
    end
    
    % Done plotting all curves for a given state
    
    % Finished plotting for model = PW
    
else
    display('Model number must be either 1 or 2')
end

% Formatting figures
for k = 1:length(Mfigs)
    figure(Mfigs(k))
    hXLabel = xlabel('$\rho$','Interpreter','latex');
    hYLabel = ylabel('$m = \rho v$','Interpreter','latex');
    set([hXLabel, hYLabel], 'FontSize', size_font);
    set(gca,'FontSize',size_font)
    set(gcf, 'Color', 'w');
end