% Function to generate plots in the Y plane for the AR model.
% Generates 3 plots: curves for lambda1, curves for lambda2, and both
% curves for a given point.
% Note: expects that the function "variableSetup" has been run.

function Yfigs = YPlot()

global v_star rho_star p rho size_font

% Setting up equations
for h = 1:length(v_star)
    for k = 1:length(rho)
        y1(h,k) = rho(k)*v_star(h) + rho(k)*p(rho_star(h));
        y2(h,k) = rho(k)*v_star(h) + rho(k)*p(rho(k));
    end
end

% Plotting 1-curves
Yfigs(1) = figure;
plot(rho,y1,'k')

axis([0 0.1 0 0.1])
set(gca,'XTick',[0 0.1])
set(gca,'XTickLabel',{'0' '.1'})
set(gca,'YTick',[0 0.1])
set(gca,'YTickLabel',{'0' '.1'})

% Plotting 2-curves
Yfigs(2) = figure;
plot(rho,y2,'b')

axis([0 0.1 0 0.1])
set(gca,'XTick',[0 0.1])
set(gca,'XTickLabel',{'0' '.1'})
set(gca,'YTick',[0 0.1])
set(gca,'YTickLabel',{'0' '.1'})

% Plotting both curves for a given initial state
Yfigs(3) = figure;
state = 1;
plot(rho,y1(state,:),'k')
hold on
plot(rho,y2(state,:),'b')
y_star = rho_star(state)*v_star(state)...
    + rho_star(state)*p(rho_star(state));
plot(rho_star(state),y_star,'ro', 'LineWidth', 2)

axis([0 0.4 0 0.3])
set(gca,'XTick',[0 0.4])
set(gca,'XTickLabel',{'0' '.4'})
set(gca,'YTick',[0 0.3])
set(gca,'YTickLabel',{'0' '.3'})

% Formatting figures
for k = 1:length(Yfigs)
    figure(Yfigs(k))
    hXLabel = xlabel('$\rho$','Interpreter','latex');
    hYLabel = ylabel('$y$','Interpreter','latex');
    set([hXLabel, hYLabel], 'FontSize', size_font);
    set(gca,'FontSize',size_font)
    set(gcf, 'Color', 'w');
end