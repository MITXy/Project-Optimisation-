%%Defining the Problem
% Distance matrix
dist_matrix = [ 1 147 188  95 175  76;
                147 1  62 204 215  42;
                188  62 1 224 236 105; 
                95 204 224 1 40 186;
                175 215 236 40 1 146;
                76  42 105 186 146 1 ];

% Cost per unit distance
cost_per_km = [ 18.32; 15.71; 15.18; 14.66; 14.14; 16.75 ];

% Define the objective function
f = reshape(dist_matrix', [], 1);

% Define the inequality constraints
A = kron(eye(6), ones(1, 6));
b = [45000; 60000; 25000; 30000; 49000; 69000];

% Define the lower bound and upper bound of the decision variables
lb = zeros(36, 1);
ub = inf(36, 1);

%% Solving the Problem with Linear Programming Algorithm
% Solve the linear program
[x, cost] = linprog(f, [], [], A, b, lb, ub);

%% Visualisations
% Print the optimal cost
fprintf('Total cost: $%.2f\n', cost);

% Reshape the decision variable into a 6x6 matrix
x_matrix = reshape(x, 6, [])';

% Create a 2D plot of the transport plan
figure;
imagesc(x_matrix);
colorbar;
colormap(parula);
set(gca, 'XTick', 1:6, 'XTickLabel', {'Osogbo', 'Abeokuta', 'Ikeja', 'Akure', 'Ado-Ekiti',"Ibadan"}, 'YTick', 1:6, 'YTickLabel', {'Osogbo', 'Abeokuta', 'Ikeja', 'Akure', 'Ado-Ekiti', "Ibadan"});
xlabel('To');
ylabel('From');
title('Transport Plan');