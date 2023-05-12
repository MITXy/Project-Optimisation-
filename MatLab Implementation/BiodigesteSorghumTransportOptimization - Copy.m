clc
clear
%% Define the Problem
% This helps to define the minimum total transportation cost between each
% of the places

% Distances Between the Refineries
C = [1 147 188 95 175 76;
     147 1 62 204 215 42;
     188 62 1 224 236 105;
     95 204 224 1 40 186;
     175 215 236 40 1 146;
     76 42 105 186 146 1];
 
%Unit Price of Biodigeste
R = [4.84 4.69 4.28 5.02 4.23 4.54];

C = C .* R';

% Production Capacities
P = [80 80 80 80 80 4700];

% Consumer Demands
D = [300 150 530 120 200 40];%assumed values

%% Form the LPP
lpp = ProblemConstructor(C, P, D);

%% Solve the Problem
[xopt, fval] = linprog(lpp.f, lpp.A, lpp.b, [], [], lpp.lb);

xopt = reshape(xopt, lpp.s);

%% Display Results
disp('Optimal Solution:');
disp(xopt);
disp(['Minimum Cost: #' num2str(fval)]);

%% Plot 3D Solution
[X,Y] = meshgrid(1:size(C,2), 1:size(C,1));
Z = zeros(size(X));
for i=1:numel(Z)
    Z(i) = C(i)*xopt(i);
end

figure;
surf(X, Y, Z);
xlabel('Destination');
ylabel('Source');
zlabel('Cost');
title('Optimal Solution for sorghum Transport');
