function lpp = TransportationProblem(C, P, D)
    % this function helps convert the input into a form needed by the
    % linprog function.
    
    np = size(C, 1);
    nc = size(C, 2);
    nx = numel(C);
    
    % Objective Function
    f= C(:);
    
    %Index Converter
    ind = @ (i,j) sub2ind(size(C), i,j);
    
    %Initialising A anb b
    A = zeros(np + nc, nx);
    b = zeros(np + nc, 1);
    c = 0;
    
    %Constraints for Production capacities
    for i = 1:np
        c = c + 1;
        for j = 1:nc
            A(c,ind(i,j))=1;
        end
        b(c) = P(i);
        
    end
    
    %Constraints for Consumer Demands
    for j = 1:nc
        c = c + 1; 
        for i = 1:np
            A(c,ind(i,j))= -1;
        end
        b(c) = -D(j);
    end
    
    
    %Lower Bounds
    lb = zeros(nx, 1);
    
    lpp.np = np;
    lpp.nc = nc;
    lpp.nx = nx;
    lpp.s = size(C);
    lpp.f = f;
    lpp.A = A;
    lpp.b = b;
    lpp.lb = lb;
    
end