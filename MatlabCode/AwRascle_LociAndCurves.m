% This function plots the Hugoniot loci and Integral Curves
% for the Aw Rascle model.
% Note that the loci and the integral curves coincide for this model,
% so only two equations are needed.

clear all
close all
clc 

global v_star rho_star p pprime rho
variableSetup();

plotLambdaContours = 0;
fontSize = 25;

%% Setting up curves in the U = (rho, v) plane
for h = 1:length(v_star)
    for k = 1:length(rho)
        v1(h,k) = v_star(h) + p(rho_star(h)) - p(rho(k));
        v2(h,k) = v_star(h);
    end
end

% Creating contours for lambda1 = v - p'(rho)*rho
lambda = [.1 .6 1.1];
for h = 1:length(lambda)
    for k = 1:length(rho)
        contour2(h,k) = lambda(h) + pprime(rho(k))*rho(k);
    end
end

% Plotting 1-curves
figure(1)
plot(rho,v1,'k')
if (plotLambdaContours)
    hold on
    plot(rho,contour2(1,:),'g')
    plot(rho,contour2(2,:),'r')
    plot(rho,contour2(3,:),'b')
end

axis([0 1 0 1])
set(gca,'XTick',[0 1])
set(gca,'YTick',[0 1])

hXLabel = xlabel('\rho');
hYLabel = ylabel('v');
set([hXLabel, hYLabel], 'FontSize', fontSize);
set(gca,'FontSize',fontSize)
set(gcf, 'Color', 'w');

cd export_fig_code
export_fig( gcf, ...      % figure handle
    '../Images/HLIC_U_lamb1',... % name of output file without extension
    '-painters', ...      % renderer
    '-jpg', ...           % file format
    '-r72' );             % resolution in dpi
cd ..

% Plotting 2-curves 
figure(2)
plot(rho,v2,'b')

axis([0 1 0 1])
set(gca,'XTick',[0 1])
set(gca,'YTick',[0 1])

hXLabel = xlabel('\rho');
hYLabel = ylabel('v');
set([hXLabel, hYLabel], 'FontSize', fontSize);
set(gca,'FontSize',fontSize)
set(gcf, 'Color', 'w');

cd export_fig_code
export_fig( gcf, ...      % figure handle
    '../Images/HLIC_U_lamb2',... % name of output file without extension
    '-painters', ...      % renderer
    '-jpg', ...           % file format
    '-r72' );             % resolution in dpi
cd ..

% Plotting both curves for a given initial state
figure
plot(rho,v1(2,:),'k')
hold on
plot(rho,v2(2,:),'b')
plot(rho_star(2),v_star(2),'ro', 'LineWidth', 2)

axis([0 1 0 1])
set(gca,'XTick',[0 1])
set(gca,'YTick',[0 1])

hXLabel = xlabel('\rho');
hYLabel = ylabel('v');
set([hXLabel, hYLabel], 'FontSize', fontSize);
set(gca,'FontSize',fontSize)
set(gcf, 'Color', 'w');
cd export_fig_code
export_fig( gcf, ...      % figure handle
    '../Images/HLIC_U',... % name of output file without extension
    '-painters', ...      % renderer
    '-jpg', ...           % file format
    '-r72' );             % resolution in dpi
cd ..

%% Setting up curves in the M = (rho*v,rho) plane

for h = 1:length(v_star)
    for k = 1:length(rho)
        rv1(h,k) = rho(k)*(v_star(h) + p(rho_star(h)) - p(rho(k)));
        rv2(h,k) = v_star(h)*rho(k);
    end
end

% Plotting 1-curves
figure
plot(rho,rv1,'k')

axis([0 5 0 1])
set(gca,'XTick',[0 5])
set(gca,'YTick',[0 1])

hXLabel = xlabel('\rho');
hYLabel = ylabel('m = \rho v');
set([hXLabel, hYLabel], 'FontSize', fontSize);
set(gca,'FontSize',fontSize)
set(gcf, 'Color', 'w');

cd export_fig_code
export_fig( gcf, ...      % figure handle
    '../Images/HLIC_M_lamb1',... % name of output file without extension
    '-painters', ...      % renderer
    '-jpg', ...           % file format
    '-r72' );             % resolution in dpi
cd ..

% Plotting 2-curves
figure
plot(rho,rv2,'b')

axis([0 5 0 1])
set(gca,'XTick',[0 5])
set(gca,'YTick',[0 1])

hXLabel = xlabel('\rho');
hYLabel = ylabel('m = \rho v');
set([hXLabel, hYLabel], 'FontSize', fontSize);
set(gca,'FontSize',fontSize)
set(gcf, 'Color', 'w');
cd export_fig_code
export_fig( gcf, ...      % figure handle
    '../Images/HLIC_M_lamb2',... % name of output file without extension
    '-painters', ...      % renderer
    '-jpg', ...           % file format
    '-r72' );             % resolution in dpi
cd ..

% Plotting both curves for a given initial state
figure
plot(rho,rv1(1,:),'k')
hold on
plot(rho,rv2(1,:),'b')
hold on
plot(rho_star(1),rho_star(1)*v_star(1),'ro', 'LineWidth', 2)

axis([0 .7 0 .1])
set(gca,'XTick',[0 .69])
set(gca,'XTickLabel',{'0' '.7'})
set(gca,'YTick',[0 .1])
set(gca,'YTickLabel',{'0' '.1'})

hXLabel = xlabel('\rho');
hYLabel = ylabel('m = \rho v');
set([hXLabel, hYLabel], 'FontSize', fontSize);
set(gca,'FontSize',fontSize)
set(gcf, 'Color', 'w');
cd export_fig_code
export_fig( gcf, ...      % figure handle
    '../Images/HLIC_M',... % name of output file without extension
    '-painters', ...      % renderer
    '-jpg', ...           % file format
    '-r72' );             % resolution in dpi
cd ..

%% Setting up curves in the Y = (rho,y) plane

for h = 1:length(v_star)
    for k = 1:length(rho)
        y1(h,k) = rho(k)*v_star(h) + rho(k)*p(rho_star(h));
        y2(h,k) = rho(k)*v_star(h) + rho(k)*p(rho(k));
    end
end

% Plotting 1-curves
figure
plot(rho,y1,'k')

axis([0 0.1 0 0.1])
set(gca,'XTick',[0 0.1])
set(gca,'XTickLabel',{'0' '.1'})
set(gca,'YTick',[0 0.1])
set(gca,'YTickLabel',{'0' '.1'})

hXLabel = xlabel('\rho');
hYLabel = ylabel('y');
set([hXLabel, hYLabel], 'FontSize', fontSize);
set(gca,'FontSize',fontSize)
set(gcf, 'Color', 'w');
cd export_fig_code
export_fig( gcf, ...      % figure handle
    '../Images/HLIC_Y_lamb1',... % name of output file without extension
    '-painters', ...      % renderer
    '-jpg', ...           % file format
    '-r72' );             % resolution in dpi
cd ..

% Plotting 2-curves
figure
plot(rho,y2,'b')

axis([0 0.1 0 0.1])
set(gca,'XTick',[0 0.1])
set(gca,'XTickLabel',{'0' '.1'})
set(gca,'YTick',[0 0.1])
set(gca,'YTickLabel',{'0' '.1'})

hXLabel = xlabel('\rho');
hYLabel = ylabel('y');
set([hXLabel, hYLabel], 'FontSize', fontSize);
set(gca,'FontSize',fontSize)
set(gcf, 'Color', 'w');
cd export_fig_code
export_fig( gcf, ...      % figure handle
    '../Images/HLIC_Y_lamb2',... % name of output file without extension
    '-painters', ...      % renderer
    '-jpg', ...           % file format
    '-r72' );             % resolution in dpi
cd ..

% Plotting both curves for a given initial state
figure
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

hXLabel = xlabel('\rho');
hYLabel = ylabel('y');
set([hXLabel, hYLabel], 'FontSize', fontSize);
set(gca,'FontSize',fontSize)
set(gcf, 'Color', 'w');
cd export_fig_code
export_fig( gcf, ...      % figure handle
    '../Images/HLIC_Y',... % name of output file without extension
    '-painters', ...      % renderer
    '-jpg', ...           % file format
    '-r72' );             % resolution in dpi
cd ..

