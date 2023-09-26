%% Define the Problem
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

%% Form the LPP
lpp = ProblemConstructor(C, P, D);

%% Solve the Problem
[xopt, fval] = linprog(lpp.f, lpp.A, lpp.b, [], [], lpp.lb);

xopt = reshape(xopt, lpp.s);

%% Display Results
disp('Original Optimal Solution:');
disp(xopt);
disp(['Original Optimised Cost($): ' num2str(fval)]);

%% Sensitivity Analysis
perturbation_factor = 0.01; % 1% perturbation
num_perturbations = 50; % Number of perturbations to analyze
perturbation_range = linspace(1 - perturbation_factor, 1 + perturbation_factor, num_perturbations);

% Store perturbed costs and minimum costs
perturbed_costs = zeros(num_perturbations, 1);
perturbed_solutions = cell(num_perturbations, 1);

for i = 1:num_perturbations
    % Perturb the unit price of bioethanol (R)
    R_perturbed = R * perturbation_range(i);
    
    % Update the matrix C with the perturbed prices
    C_perturbed = C .* R_perturbed;
    
    % Form the LPP for the perturbed problem
    lpp_perturbed = ProblemConstructor(C_perturbed, P, D);
    
    % Solve the perturbed problem
    [xopt_perturbed, fval_perturbed] = linprog(lpp_perturbed.f, lpp_perturbed.A, lpp_perturbed.b, [], [], lpp_perturbed.lb);
    
    perturbed_costs(i) = fval_perturbed;
    perturbed_solutions{i} = reshape(xopt_perturbed, lpp_perturbed.s);
end

% Plot the sensitivity graph
figure;
plot(perturbation_range, perturbed_costs, 'b.-');
xlabel('Perturbation Factor');
ylabel('Optimised Cost ($)');
title('Sensitivity Analysis: Unit Price of Bioethanol');
grid on;

%% Visualize Sensitivity Solutions
% Plot the optimal solutions for each perturbation
figure;
for i = 1:num_perturbations
    subplot(5, 10, i);
    imagesc(perturbed_solutions{i});
    title(['Perturbation: ' num2str(perturbation_range(i))]);
    xlabel('Consumer');
    ylabel('Source');
    colormap(gray);
    axis off;
end

