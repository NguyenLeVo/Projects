%% Solving ODE's using MATLAB

% An ordinary differential equation problem is stiff if the solution being 
% sought is varying slowly, but there are nearby solutions that vary 
% rapidly, so the numerical method must take small steps to obtain satisfactory results.
% Nonstiff methods can solve stiff problems; they just take a long time to do it

% Reference: https://www.mathworks.com/company/newsletters/articles/stiff-differential-equations.html

%% A model of flame propagation

% Non-stiff
delta = 0.01;                       % Initial radius
% With delta is relatively large, function is non stiff
F = inline('y^2 - y^3','t','y');    % Function of the ball of flame
opts = odeset('RelTol',1.e-4);      % Setting relative error to 10^-4
ode45(F,[0 2/delta],delta,opts);    
% (Function F, Time 0=>2/delta, Initial Condition y(0)= delta, Relative Error)
% ode45 is non-stiff (vary rapidly)
% We for the time inversely proportional to delta

% Stiff
deltas = 0.0001;                     % Initial radius
% With delta is relatively small, function is stiff. 
% So using ode45 will take a lot of time
F1 = inline('y^2 - y^3','t','y');    % Function of the ball of flame
ode23s(F1,[0 2/deltas],deltas,opts);
% ode23s do more work per step, that's how it solves non-stiff odes
