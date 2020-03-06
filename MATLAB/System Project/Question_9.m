%% Question 9 - Nguyen Vo
a=0.1^2; % Define a
% Define the  function matrix with z-variables and z-values
zdot=@(t,z)([z(2);-a*sin(z(1))]);
%% Part a - theta(0)=0.1 and theta_dot(0)=0.1
tspan=[0 20]; % Time span
z0=[0.1;0.1]; % Initial Conditions of a)
options=odeset('reltol',1e-6,'abstol',1e-8); % Set Solver Options
% Solving the ode
[t sol]=ode45(zdot,tspan,z0,options);
th=sol(:,1); % Extract theta(non-linear)
% Setting up the linear ode solution
tl=0:0.001:20;
th_linear=sin(0.1*tl)+0.1*cos(0.1*tl);
% Plotting of theta (linear and exact)
figure(1);
plot(tl,th_linear,t,th);
legend('Linear','Nonlinear');
xlabel('time t [sec]');
ylabel('\theta [rad]');
grid on; 

%% Part b - theta(0)=1 and theta_dot(0)=1
tspan=[0 20]; % Time span
z0=[1;1]; % Initial Conditions of b)
options=odeset('reltol',1e-6,'abstol',1e-8); % Set solver options
% Solving the ode
[t sol]=ode45(zdot,tspan,z0,options);
th=sol(:,1); % Extract theta(non-linear)
% Setting up the linear ode solution
tl=0:0.001:20;
th_linear=10*sin(0.1*tl)+cos(0.1*tl);
% Plotting of theta (linear and exact)
figure(2);
plot(tl,th_linear,t,th);
legend('Linear','Nonlinear');
xlabel('time t [sec]');
ylabel('\theta [rad]');
grid on; 
