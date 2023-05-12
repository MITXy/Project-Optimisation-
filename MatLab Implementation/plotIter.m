% Define the data
iter = [0 1 2 3 4 5 6 7 8 9 10 11 12 13 14];
f_count = [7 14 21 28 35 42 49 56 63 70 77 84 91 98 105];
fx = [7.800000e+05 7.814758e+05 1.024676e+06 3.569468e+06 3.607291e+06 3.607341e+06 3.642096e+06 3.611554e+06 3.611342e+06 3.614431e+06 3.609271e+06 3.609202e+06 3.612128e+06 3.640000e+06 3.640000e+06];
feasibility = [1.000e+03 9.995e+02 9.178e+02 5.484e+01 3.765e+01 3.761e+01 2.180e+01 1.643e+01 1.642e+01 1.521e+01 1.063e+01 1.062e+01 9.611e+00 0.000e+00 0.000e+00];
optimality = [8.803e+02 8.803e+02 8.803e+02 7.205e+01 7.205e+01 7.205e+01 7.205e+01 7.162e+01 6.027e+01 5.572e+01 5.542e+01 4.950e+01 9.611e+00 2.375e-02 1.112e-04];
step = [NaN 4.955e-01 8.688e+01 9.880e+02 8.803e+01 4.636e-01 1.262e+02 4.661e+02 2.314e+00 6.663e+00 2.637e+02 1.310e+00 1.390e+00 1.321e+01 8.065e-05];

% Set the line characteristics
line_style = {'-', '--', ':', '-.', ':'};
line_color = {'b', 'r', 'g', 'k', 'm'};

% Plot each column against iter on a separate figure
figure;
plot(iter, f_count, 'LineStyle', line_style{1}, 'Color', line_color{1});
xlabel('Iter');
ylabel('F-count');
title('F-count vs Iter');

figure;
plot(iter, fx, 'LineStyle', line_style{2}, 'Color', line_color{2});
xlabel('Iter');
ylabel('f(x)');
title('f(x) vs Iter');

figure;
plot(iter, feasibility, 'LineStyle', line_style{3}, 'Color', line_color{3});
xlabel('Iter');
ylabel('Feasibility');
title('Feasibility vs Iter');

figure;
plot(iter, optimality, 'LineStyle', line_style{4}, 'Color', line_color{4});
xlabel('Iter');
ylabel('Optimality');
title('Optimality vs Iter');

figure;
plot(iter, step, 'LineStyle', line_style{5}, 'Color', line_color{4});
xlabel('Iter');
ylabel('Step');
title('Step vs Iter');
