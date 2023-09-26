function sensitivity_analysis()

    % Define the Problem
    C = [1 147 188 95 175 76;
         147 1 62 204 215 42;
         188 62 1 224 236 105;
         95 204 224 1 40 186;
         175 215 236 40 1 146;
         76 42 105 186 146 1];
     
    C = C / 1000;
    
    % Unit Price of Cost of Transportation
    R = [4.84 4.69 4.28 5.02 4.23 4.54];

    C = C .* R';

    % Production Capacities
    P = [250100 157800 158100 284100 138100 132600];

    % Consumer Demands
    D = [100500 135000 492800 120000 5000 127000]; % assumed values

    % Form the LPP
    lpp = ProblemConstructor(C, P, D);

    % Solve the Problem
    [xopt, fval] = linprog(lpp.f, lpp.A, lpp.b, [], [], lpp.lb);

    xopt = reshape(xopt, lpp.s);

    % Display Results
    disp('Original Optimal Solution:');
    disp(xopt);
    disp(['Original Minimum Cost: #' num2str(fval)]);

    % Sensitivity Analysis
    perturbation_factor = 0.01; % 1% perturbation
    num_perturbations = 50; % Number of perturbations to analyze
    perturbation_range = linspace(1 - perturbation_factor, 1 + perturbation_factor, num_perturbations);

    % Store perturbed costs and minimum costs
    perturbed_costs = zeros(num_perturbations, 1);
    perturbed_solutions = cell(num_perturbations, 1);

    for i = 1:num_perturbations
        % Perturb the unit price of cost of transportation
        R_perturbed = R * perturbation_range(i);

        % Update the objective function coefficients (C) with the perturbed prices
        C_perturbed = C .* R_perturbed';

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
    ylabel('Minimum Cost');
    title('Sensitivity Analysis: Unit Price of Cost of Transportation');
    grid on;
    
    % Plot the optimal solutions for each perturbation
    figure;
    for i = 1:num_perturbations
        subplot(5, 10, i);
        imagesc(perturbed_solutions{i});
        title(['Perturbation: ' num2str(perturbation_range(i))]);
        xlabel('Destination');
        ylabel('Source');
        colormap(gray);
        axis off;
    end
end

