% This function generates plots for the Hugoniot loci and Integral Curves
% for the Aw Rascle model, and overlays contour lines for lambda1 and 
% lambda2.

clear all
close all
clc

global size_font
run variableSetup

size_font = 25;
validity = true;

%% Setting up curves in the U = (rho, v) plane

% Calling function to generate figures
Ufigs = UPlot(1,validity);

% Exporting figures
figure(Ufigs(1))
cd export_fig_code
export_fig( gcf, ...      % figure handle
    '../Images/Validity_U',... % name of output file without extension
    '-painters', ...      % renderer
    '-jpg', ...           % file format
    '-r72' );             % resolution in dpi
cd ..

figure(Ufigs(2))
cd export_fig_code
export_fig( gcf, ...      % figure handle
    '../Images/Validity_U_ql',... % name of output file without extension
    '-painters', ...      % renderer
    '-jpg', ...           % file format
    '-r72' );             % resolution in dpi
cd ..

figure(Ufigs(3))
cd export_fig_code
export_fig( gcf, ...      % figure handle
    '../Images/Validity_U_qr',... % name of output file without extension
    '-painters', ...      % renderer
    '-jpg', ...           % file format
    '-r72' );             % resolution in dpi
cd ..

%% Setting up curves in the M = (rho,rho*v) plane

% Calling function to generate figures
Mfigs = MPlot(1,validity);

% Exporting figues
figure(Mfigs(1))
cd export_fig_code
export_fig( gcf, ...      % figure handle
    '../Images/Validity_M',... % name of output file without extension
    '-painters', ...      % renderer
    '-jpg', ...           % file format
    '-r72' );             % resolution in dpi
cd ..

figure(Mfigs(2))
cd export_fig_code
export_fig( gcf, ...      % figure handle
    '../Images/Validity_M_ql',... % name of output file without extension
    '-painters', ...      % renderer
    '-jpg', ...           % file format
    '-r72' );             % resolution in dpi
cd ..

figure(Mfigs(3))
cd export_fig_code
export_fig( gcf, ...      % figure handle
    '../Images/Validity_M_qr',... % name of output file without extension
    '-painters', ...      % renderer
    '-jpg', ...           % file format
    '-r72' );             % resolution in dpi
cd ..

