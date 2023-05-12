clc
clear

% Define the objective function coefficients
f = [1000; 1100; 1200; 1400; 1500; 1600];

% Define the inequality constraint matrix A and vector b
A = [-1 -1 0 0 0 0;     0 -1 -1 0 0 0;     0 0 -1 -1 0 0;     0 0 0 -1 -1 0;     0 0 0 0 -1 -1;     -1 0 0 0 0 -1];
b = [-1000; -500; -700; -900; -1200; -800];

% Define the lower bound and upper bound vectors
lb = [0; 0; 0; 0; 0; 0];
ub = [];

% Define the initial guess for the solution
x0 = [100; 100; 100; 100; 100; 100];

% Set options for the optimization algorithm
options = optimoptions('fmincon', 'Display', 'iter', 'MaxIterations', 1000);

% Solve the optimization problem
[x, fval, exitflag, output] = fmincon(@(x) f' * x, x0, A, b, [], [], lb, ub, [], options);

% Print the solution
fprintf('x1 = %f\n', x(1));
fprintf('x2 = %f\n', x(2));
fprintf('x3 = %f\n', x(3));
fprintf('x4 = %f\n', x(4));
fprintf('x5 = %f\n', x(5));
fprintf('x6 = %f\n', x(6));

