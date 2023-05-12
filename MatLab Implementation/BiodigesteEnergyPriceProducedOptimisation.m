%% Define the Problem
% This helps to define the minimum total transportation cost between each
% of the places

% Energy in MW
C = [9 17.4 17.8 17.2 17.8 18
     9 17.4 17.8 17.2 17.8 18
     9 17.4 17.8 17.2 17.8 18
     9 17.4 17.8 17.2 17.8 18];
 
%Unit Price of Bioethanol
R = [0.4 0.42 0.42 0.54 0.7 0.74];
C = C .* R;
% Production Capacities(4)
P = [24440 24900 29120 26900 ];

% Consumer Demands(6)
D = [6700 8250 7600 7760 8170 7800];%Biodemand used inplace of power demand(assumption)


%%Visualisation of Data
% Heatmap of matrix C
figure;
heatmap(C, 'Colormap', parula, 'ColorbarVisible', 'off');
xlabel('Consumer');
ylabel('Source');
title('Energy in MW');

% Bar plot of vector R
figure;
bar(R);
xlabel('Source');
ylabel('Unit Price');
title('Unit Price of Biodigeste');

% Stacked bar plot of matrix C and vector P
figure;
h = bar(C);
set(gca, 'xticklabel', {'S1', 'S2', 'S3', 'S4', 'S5', 'S6'});
ylabel('Minimised Cost ($)');
hold on;
bar(P, 'stacked');
hold off;
legend('C1', 'C2', 'C3', 'C4', 'C5', 'C6', 'Production Capacity');
title('Production Capacity and Energy Price');

%% Form the LPP
lpp = ProblemConstructor(C, P, D);

%% Solve the Problem
[xopt, fval] = linprog(lpp.f, lpp.A, lpp.b, [], [], lpp.lb);

xopt = reshape(xopt, lpp.s);

%% Display Results
disp('Optimal Solution:');
disp(xopt);
disp(['Optimised Cost($): ' num2str(fval)]);

%% Plot 3D Solution
[X,Y] = meshgrid(1:size(C,2), 1:size(C,1));
Z = zeros(size(X));
for i=1:numel(Z)
    Z(i) = C(i)*xopt(i);
end

figure;
surf(X, Y, Z);
xlabel('Demand');
ylabel('Source');
zlabel('Energy Cost($)');
title('Energy Price Optimisation for Biodigestate');

