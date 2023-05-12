% Define the objective function coefficients
c = [7; 10; 8; 6; 9; 11];

% Define the inequality constraints matrix and vector
A = [1 2 2 0 0 0;
     0 1 0 1 0 0;
     0 0 1 0 1 0;
     0 0 0 1 1 1];
b = [1000; 200; 300; 500];

% Define the bounds for the decision variables
lb = zeros(6,1);
ub = [Inf; Inf; Inf; 200; 300; 400];

% Solve the linear program
[x, fval, exitflag] = linprog(c, -A, -b, [], [], lb, ub);

% Print the results
fprintf('Optimal transport plan:\n');
fprintf('   From  To    Quantity\n');
for i = 1:6
    if x(i) > 0
        fprintf('    %d     %d     %d\n', mod(i-1,3)+1, ceil(i/3), x(i));
    end
end
fprintf('Total cost: $%.2f\n', fval);

% Plot the results
figure;
bar(x);
xlabel('Transport plan');
ylabel('Quantity');
title('Optimal transport plan');

figure;
pie(x, {'NY -> CHI', 'NY -> SFO', 'NY -> MIA', 'CHI -> SFO', 'SFO -> MIA', 'MIA -> CHI'});
title('Optimal transport plan');

figure;
bar(c);
xlabel('Biomaterials');
ylabel('Transport cost');
title('Objective function coefficients');
