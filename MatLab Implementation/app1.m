%% Defining the problem stating the objective function as f

f = [-5 -6];

A = [ 1 1
     -1 1
      5 4 ];

 b = [ 10 
       -3 
       35];
   
 Aeq = [];
 beq = [];
 
 lb = [0 0];
 ub = [];
 
 %% Solve the LP Problem
 [xopt, fval] = linprog(f, A, b, Aeq, beq, lb, ub);
 
 
    