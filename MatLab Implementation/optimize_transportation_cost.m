function [xopt, fval] = optimize_transportation_cost(biofuels, biodigestate, bioenergy, distance)

% Combine the three biofuels data into one matrix
biofuels_combined = [biofuels; biodigestate; bioenergy];

% Calculate the transportation cost matrix
transport_cost = distance' .* biofuels_combined(3,:);

% Production Capacities
P = [10000 9000 8000];

% Consumer Demands
D = [7500 7500 7500 7500 7500 7500];

% Form the LPP
lpp = TransportationProblem(transport_cost, P, D);

% Solve the problem
[xopt, fval] = linprog(lpp.f, lpp.A, lpp.b, [], [], lpp.lb);

% Reshape xopt to get the transportation matrix
%xopt = reshape(xopt, lpp.s);

end


