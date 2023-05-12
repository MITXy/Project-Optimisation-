% Define the distance matrix between the provinces (in km)
BioproductDistance = [
    0   147 188 95  175 76  188;
    147 0   62  204 215 42  215;
    188 62  0   224 236 105 236;
    95  204 224 0   40  186 224;
    175 215 236 40  0   146 236;
    76  42  105 186 146 0   186;
    188 215 236 224 236 186 0
];

% Define the number of provinces
numProvinces = size(BioproductDistance, 1);

% Define the objective function coefficients
f = [0.31 0.35 0.30 0.27 0.28 0.37 0.29];

% Define the constraint matrix A and right-hand side b
Aeq = ones(1, numProvinces);
beq = 1;
lb = zeros(numProvinces, 1);
ub = ones(numProvinces, 1);

% Define the inequality constraint matrix Aineq and right-hand side bineq
Aineq = [ones(1,7), zeros(1,14);         zeros(1,7), ones(1,7), zeros(1,7);         zeros(1,14), ones(1,7);         -[BioproductDistance(:); zeros(7,1)], zeros(14,7);
         zeros(7,7), -[BioproductDistance; zeros(1,7)]];

bineq = zeros(numProvinces, 1);

% Solve the linear program
[x, fval, exitflag] = linprog(f, Aineq, bineq, Aeq, beq, lb, ub);

% Print the results
disp('Optimal allocation of transportation resources:');
disp(x');

% Plot the distances between provinces
provinces = {'Osogbo', 'Abeokuta', 'Ikeja', 'Akure', 'Ado-Ekiti', 'Ibadan', 'New'};
figure;
imagesc(BioproductDistance);
colorbar;
set(gca, 'XTick', 1:numProvinces, 'XTickLabel', provinces, 'YTick', 1:numProvinces, 'YTickLabel', provinces);
xlabel('To');
ylabel('From');
title('Distances between provinces (km)');

% Plot the optimal transportation allocations
figure;
bar(x);
set(gca, 'XTick', 1:numProvinces, 'XTickLabel', provinces);
xlabel('Province');
ylabel('Fraction of resources allocated');
title('Optimal allocation of transportation resources');

% Plot the total transportation cost
totalCost = sum(BioproductDistance .* x);
figure;
bar(totalCost);
set(gca, 'XTick', 1:numProvinces, 'XTickLabel', provinces);
xlabel('Province');
ylabel('Total transportation cost (km)');
title('Total transportation cost for each province');
