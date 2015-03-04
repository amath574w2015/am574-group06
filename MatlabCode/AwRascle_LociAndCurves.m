% This function generates plots for the Hugoniot loci and Integral Curves
% for the Aw Rascle model.
% Note that the loci and the integral curves coincide for this model,
% so only two equations are needed.

clear all
close all
clc

global size_font
run variableSetup

size_font = 25;
validity = false;

%% Setting up curves in the U = (rho, v) plane

% Calling function to generate figures
Ufigs = UPlot(1, validity);

% Exporting figures
figure(Ufigs(1))
cd export_fig_code
export_fig( gcf, ...      % figure handle
    '../Images/HLIC_U_lamb1',... % name of output file without extension
    '-painters', ...      % renderer
    '-jpg', ...           % file format
    '-r72' );             % resolution in dpi
cd ..

figure(Ufigs(2))
cd export_fig_code
export_fig( gcf, ...      % figure handle
    '../Images/HLIC_U_lamb2',... % name of output file without extension
    '-painters', ...      % renderer
    '-jpg', ...           % file format
    '-r72' );             % resolution in dpi
cd ..

figure(Ufigs(3))
cd export_fig_code
export_fig( gcf, ...      % figure handle
    '../Images/HLIC_U',... % name of output file without extension
    '-painters', ...      % renderer
    '-jpg', ...           % file format
    '-r72' );             % resolution in dpi
cd ..

%% Setting up curves in the M = (rho, rho*v) plane

% Calling function to generate figures
Mfigs = MPlot(1, validity);

% Exporting figues
figure(Mfigs(1))
cd export_fig_code
export_fig( gcf, ...      % figure handle
    '../Images/HLIC_M_lamb1',... % name of output file without extension
    '-painters', ...      % renderer
    '-jpg', ...           % file format
    '-r72' );             % resolution in dpi
cd ..

figure(Mfigs(2))
cd export_fig_code
export_fig( gcf, ...      % figure handle
    '../Images/HLIC_M_lamb2',... % name of output file without extension
    '-painters', ...      % renderer
    '-jpg', ...           % file format
    '-r72' );             % resolution in dpi
cd ..

figure(Mfigs(3))
cd export_fig_code
export_fig( gcf, ...      % figure handle
    '../Images/HLIC_M',... % name of output file without extension
    '-painters', ...      % renderer
    '-jpg', ...           % file format
    '-r72' );             % resolution in dpi
cd ..

%% Setting up curves in the Y = (rho,y) plane

% Calling function to generate figures
Yfigs = YPlot(1);

figure(Yfigs(1))
cd export_fig_code
export_fig( gcf, ...      % figure handle
    '../Images/HLIC_Y_lamb1',... % name of output file without extension
    '-painters', ...      % renderer
    '-jpg', ...           % file format
    '-r72' );             % resolution in dpi
cd ..

figure(Yfigs(2))
cd export_fig_code
export_fig( gcf, ...      % figure handle
    '../Images/HLIC_Y_lamb2',... % name of output file without extension
    '-painters', ...      % renderer
    '-jpg', ...           % file format
    '-r72' );             % resolution in dpi
cd ..

figure(Yfigs(3))
cd export_fig_code
export_fig( gcf, ...      % figure handle
    '../Images/HLIC_Y',... % name of output file without extension
    '-painters', ...      % renderer
    '-jpg', ...           % file format
    '-r72' );             % resolution in dpi
cd ..

