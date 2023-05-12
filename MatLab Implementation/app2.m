%% Define the Problem

% Shipment Costs
C = [1 2 3
     2 4 1];
 
% Production Capacities
P = [900 800];


% Consumer Demands
D = [500 600 300];

%% Form the LPP
lpp = TransportationProblem(C, P, D);

%% Solve the Problem
[xopt, fval] = linprog(lpp.f, lpp.A, lpp.b, [], [], lpp.lb);

xopt = reshape(xopt, lpp.s);