%% Question 1 - Nguyen Vo
% Finding the closed-form solution
syms s; % Define s as a symbolic variable
X=((6/(s^2+9))+s+3.5)/(s^2+4*s+6); % X(s)
x=ilaplace(X); % Inverse Laplace to find x(t)
pretty(x) % Simplify x(t)