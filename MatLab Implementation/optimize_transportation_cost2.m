function [xopt, fval] = optimize_transportation_cost2(biofuels, biodigestate, bioenergy, distance)
    % Define the Problem
    
    % Shipment Costs
    C = [0.19 0.12 0.06         0.24 0.16 0.09         0.29 0.20 0.12         0.34 0.24 0.15         0.39 0.28 0.18         0.44 0.32 0.21];

    % Production Capacities
    P = [sum(biofuels(2,:)); sum(biodigestate(2,:)); sum(bioenergy(2,:))];

    % Consumer Demands
    D = [biofuels(1,:); biodigestate(1,:); bioenergy(1,:)];

    % Form the LPP
    lpp = TransportationProblem(C, P, D);

    % Solve the Problem
    [xopt, fval] = linprog(lpp.f, lpp.A, lpp.b, [], [], lpp.lb);

    %xopt = reshape(xopt, lpp.s);
end
