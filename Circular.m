%% Circular Cross-Section
clc;
clear vars;
close all;
%% State Problem
% vars: A1, A2, A3, A4, l, E, P, theta, alpha
% Objective: Min(Weight [Volume]),
% Constraints: buckkling conditions & axial stress <= allowable strength ;
% End Deflection Constraint: delta <= delta_max ;
% Bounds:  10 e-06 <= A1, A2, A3, A4 <= 500 e-06 ;

% Givens: l= 1; delta_max= 2e-03  P= 2000 ,E= 2 e+011, S_all= 5 e+08, theta= 45 deg, alpha= 33.69 deg;
%% Solution
% Create Bounds
P=10000;
E = 72000;
L=1000;
LB= [12.5 1 ];  %Lower Bound
UB= [50 5 ];  %Upper Bound

% Optimization Options
optimization = optimoptions(@ga, 'MaxGenerations', 300, 'PopulationSize', 300 ...
    , 'FunctionTolerance', 1e-015, 'EliteCount', 5, 'PlotFcn', {@gaplotbestf,@gaplotstopping});

% Run GA
rng(0, 'twister');

[xbest, fbest, exitflag] = ga(@Area, 2, [], [], [], [], ...
    LB, UB, @CCConstraints, [], optimization);
A=2*pi*xbest(1)*xbest(2);

display(xbest);
fprintf('Best Volume returned by ga = %g\n', fbest);

effeciency=(P/A)/E^(2/3)/(P/L^2)^(1/3);
