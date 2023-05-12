%% Load data
C = [1 147 188 95 175 76;
     147 1 62 204 215 42;
     188 62 1 224 236 105;
     95 204 224 1 40 186;
     175 215 236 40 1 146;
     76 42 105 186 146 1];
 
d = [142100 157800 128100 284100 138100 142600];

s = [100500 235000 492800 120000 50000 127000];

%%Convert the minimization problem to a maximization problem
f = -reshape(C', 1, [])';

%% Equality constraint: supply = demand
Aeq = kron(eye(6), ones(1,6));
beq = reshape(s', [], 1);

%%Inequality constraints: supply and demand are non-negative
lb = zeros(size(f));

%% Solve the linear programming problem
[x, fval, exitflag] = linprog(f, [], [], Aeq, beq, lb);

%% Reshape the solution into a matrix
X = reshape(x, 3, [])';

%% Plot the solution
figure
bar3(X, 'detached')
title('Optimal Transport Plan')

%% Plot the cost matrix
figure
bar3(C, 'detached')
title('Cost Matrix')

%% Plot the supply and demand vectors
figure
bar([d s])
legend('Supply', 'Demand')
title('Supply and Demand')
