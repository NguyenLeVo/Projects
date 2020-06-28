%% Question 5 - Nguyen Vo
%% Part i - expm() and int()
% Matrices
A=[0 1;-10 -4]; % State Matrix A
B=[0;5]; % Input Matrix B
C=[1 0]; % Output Matrix C
x0=[1;0.5]; % Initial Condition
% Finding the closed-form solutionsyms t tau
stm1=expm(A*t); % State transition matrix
stm2=subs(stm1,t,t-tau); % Replaced t with (t-tau)
y=stm1*x0 + int((stm2*B*sin(2*tau)),tau,0,t); % 2x1 matrix solution 
x=C*y; % Final solution of x
pretty(x) % Simplify x(t)
x1 = subs(x);
%% Part ii - ode45()
% Define the  function matrix with z-variables and z-values
zdot=@(t,z)([   z(2);
                -10*z(1)-4*z(2)+5*sin(2*t)]);
% Define Time Span, ICs, and Relative Errors/Tolerance
tspan=[0 7]; % Time Span, Time Steps will be determined by Matlab
z0=[1;0.5]; % Initial Conditions
options=odeset('reltol',1e-6,'abstol',1e-8); % Set Solver Options (optional)
% Solving the non-stiff ode 
[t sol]=ode45(zdot,tspan,z0,options); % Function, Time span, ICs, Tolerance
% Data extraction
x2=sol(:,1); % Extract x
%% Part iii - ss() and lsim()
t3=0:0.01:7; % Time span and fixed time step, have to specify time steps to use lsim
x0=[1;0.5]; % Initial Conditions
A=[0 1;-10 -4]; % State Matrix A
B=[0;5]; % Input Matrix B
C=[1 0]; % Output Matrix C
D=0; % Direct Transmission Matrix D
unitstep=@(x)(x>=0); % Define the Unit Step Function
u=sin(2*t3); % Input function
% lsim() function
x=lsim(ss(A,B,C,D),u,t3,x0); 
x3=x(:,1); % extract x
%% Part v - Plotting of x with intentional different heights for comparison
figure(1);
fplot(x1,[0 7]);
hold on;
plot(t,x2+0.25,t3,x3+0.5,tout,simout+0.75); % Add value (+0.25, etc.) to see the plots better
hold off;
legend('expm() and int()','ode45()','ss() and lsim()','simulink');
xlabel('Time t [s]');
ylabel('Response x [length]');
grid on; 