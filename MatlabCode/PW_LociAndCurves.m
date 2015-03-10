% This function generates plots for the Hugoniot loci and Integral Curves
% for the PW model.
% Note that the loci and the integral curves coincide for this model,
% so only two equations are needed.

clear all
close all
clc

global size_font
run variableSetup

size_font = 25;
validity = true;

%% Setting up curves in the M = (rho, rho*v) plane

% Calling function to generate figures
Mfigs = MPlot(2, true);

% Exporting figures
figure(Mfigs(1))
cd export_fig_code
export_fig( gcf, ...      % figure handle
    '../Images/PW_Loci',... % name of output file without extension
    '-painters', ...      % renderer
    '-jpg', ...           % file format
    '-r72' );             % resolution in dpi
cd ..

figure(Mfigs(2))
cd export_fig_code
export_fig( gcf, ...      % figure handle
    '../Images/PW_IntegralCurves',... % name of output file without extension
    '-painters', ...      % renderer
    '-jpg', ...           % file format
    '-r72' );             % resolution in dpi
cd ..

figure(Mfigs(3))
cd export_fig_code
export_fig( gcf, ...      % figure handle
    '../Images/PW_Lambda1Curves',... % name of output file without extension
    '-painters', ...      % renderer
    '-jpg', ...           % file format
    '-r72' );             % resolution in dpi
cd ..

figure(Mfigs(4))
cd export_fig_code
export_fig( gcf, ...      % figure handle
    '../Images/PW_Lambda2Curves',... % name of output file without extension
    '-painters', ...      % renderer
    '-jpg', ...           % file format
    '-r72' );             % resolution in dpi
cd ..

figure(Mfigs(5))
cd export_fig_code
export_fig( gcf, ...      % figure handle
    '../Images/PW_validStateCurvesLeft',... % name of output file without extension
    '-painters', ...      % renderer
    '-jpg', ...           % file format
    '-r72' );             % resolution in dpi
cd ..

figure(Mfigs(6))
cd export_fig_code
export_fig( gcf, ...      % figure handle
    '../Images/PW_validStateCurvesRight',... % name of output file without extension
    '-painters', ...      % renderer
    '-jpg', ...           % file format
    '-r72' );             % resolution in dpi
cd ..