%% Question 6 - Nguyen Vo
% Define constants
KT=0.05;
Kb=KT;
La=2e-3;
Ra=0.5;
IM=9e-5;
c=1e-4;
% Define the  function matrix with z-variables and z-values
zdot=@(t,z)([   -Ra/La*z(1)-Kb/La*z(2)+10/La;
                KT/IM*z(1)-c/IM*z(2)]);
% Define Time Span, ICs, and Relative Erros/Tolerance
tspan=[0 0.2]; % Time Span, Time Steps will be determined by Matlab
options=odeset('reltol',1e-6,'abstol',1e-8); % Set Solver Options (optional)
% Solving the non-stiff ode 
[t sol]=ode45(zdot,tspan,[0;0],options); % Function, Time span, ICs, Tolerance
% Data extraction
current=sol(:,1);  % Extract current
omega=sol(:,2);    % Extract angular velocity
% Plot results
figure(1);
subplot(2,1,1);
plot(t,KT*current); % Torque = KT * Current 
grid on;
xlabel('Time, t [sec]');
ylabel('Torque, T [N-m]');
subplot(2,1,2);
plot(t,omega);
grid on;
xlabel('Time, t [sec]');
ylabel('Angular Velocity, \omega [rad/s]');