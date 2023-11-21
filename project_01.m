function newton_system_example()

    % System of equations
    syms x y;
    f = x + 2*y - 2;
    g = x^2 + 4*y^2 - 4;

    % Partial derivatives
    dfdx = diff(f, x);
    dfdy = diff(f, y);
    dgdx = diff(g, x);
    dgdy = diff(g, y);

    % Initial guess
    x0 = 1;
    y0 = 2;

    % Tolerance and maximum iterations
    tolerance = 1e-10;
    max_iterations = 25;

    % Iterative process
    for n = 1:max_iterations
        % Evaluate functions and derivatives
        f_value = subs(f, [x, y], [x0, y0]);
        g_value = subs(g, [x, y], [x0, y0]);
        J = [subs(dfdx, [x, y], [x0, y0]), subs(dfdy, [x, y], [x0, y0]); ...
             subs(dgdx, [x, y], [x0, y0]), subs(dgdy, [x, y], [x0, y0])]; % Jacobian matrix
        delta = J \ [-f_value; -g_value]; % Solve for delta x and delta y
        x0 = x0 + delta(1);
        y0 = y0 + delta(2);

        % Check for convergence
        if norm([delta(1); delta(2)], inf) < tolerance
            break;
        end
    end

    % Display results
    fprintf('Approximate root: x = %.10f, y = %.10f\n', x0, y0);
    fprintf('Number of iterations: %d\n', n);

end

