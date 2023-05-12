% Define the objective function coefficients
f = [25.48; 25.96; 26.92; 37.5; 42.79; 38.46; 1.96; 1.56; 1.78; 2.28; 2.34; 2.14];

% Define the inequality constraints
A = [24440 0 0 0 0 0 -177600 0 0 0 0 0; 0 24900 0 0 0 0 0 -197200 0 0 0 0; 0 0 29120 0 0 0 0 0 -160100 0 0 0; 0 0 0 26900 0 0 0 0 0 -355100 0 0; 0 0 0 0 37580 0 0 0 0 0 -172600 0; 0 0 0 0 0 24680 0 0 0 0 0 -178200; -1.96 -1.56 -1.78 -2.28 -2.34 -2.14 0 0 0 0 0 0; 1 0 0 0 0 0 0 0 0 0 0 0; 0 1 0 0 0 0 0 0 0 0 0 0; 0 0 1 0 0 0 0 0 0 0 0 0; 0 0 0 1 0 0 0 0 0 0 0 0; 0 0 0 0 1 0 0 0 0 0 0 0; 0 0 0 0 0 1 -80000 -100000 -89000 -90800 -98000 -95000];

b = [-665872; -674112; -799206.4; -929475; -1609814.4; -984288; -5000; 1; 1; 1; 1; 1; 1];

% Define the lower and upper bounds of the decision variables
lb = zeros(12, 1);
ub = inf(12, 1);

% Solve the linear program
[x, cost] = linprog(f, A, b, [], [], lb, ub);

% Print the optimal solution and cost
fprintf('Optimal solution:\n');
disp(x);
fprintf('Optimal cost: $%.2f\n', cost);

% Define the range of objective function coefficients to test
f_range = 20:0.5:50;

% Initialize arrays to store the optimal cost and solution for each value of f
costs = zeros(size(f_range));
solutions = zeros(length(f), length(f_range));

% Loop through the range of f values and solve the linear program for each one
for i = 1:length(f_range)
    f_i = f_range(i)*ones(size(f));  % Set all coefficients to the current value of f
    [solutions(:,i), costs(i)] = linprog(f_i, A, b, [], [], lb, ub);
end

% Plot the results
figure;
plot(f_range, costs);
xlabel('Value of f');
ylabel('Optimal cost');
title('Optimal cost as a function of objective function coefficients');
