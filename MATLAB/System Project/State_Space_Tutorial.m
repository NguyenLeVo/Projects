format compact;
%% === State Space Analysis ===

%% Example 9 - Find e^At 
syms t;
A = [   0   1; 
        -5  -2];
pretty(expm(A*t)); % Pretty will clean up the expression
% expm(A*t)= L^-1[(sI-A)^-1] % Inverse Laplace of Inverse of (sI-A)

%% Example 1 - METHOD 1 - Standard Approach

% Inputs:   t=time
%           z=[z(1);z(2);z(3);z(4)]=[x1;x1_dot;x2;x2_dot]
% Output:   zdot=[  z(2);
                   %-2*z(1)-3*z(2)+z(3)+1/2;
                   %z(4);
                   %-4*z(1)-3*z(2)-2*z(4)+3*sin(2*t)];

% Define the  function matrix with z-variables and z-values
zdot=@(t,z)([   z(2);
                -2*z(1)-3*z(2)+z(3)+0.5;
                z(4);
                -4*z(1)-3*z(2)-2*z(4)+3*sin(2*t)]);

% Define Time Span, ICs, and Relative Erros/Tolerance
tspan=[0 20]; % Time Span, Time Steps will be determined by Matlab
z0=[1;2;1;0]; % Initial Conditions
options=odeset('reltol',1e-6,'abstol',1e-8); % Set Solver Options (optional)

% Solving the non-stiff ode 
[t sol]=ode45(zdot,tspan,z0,options); % Function, Time span, ICs, Tolerance
% For neatness [t sol]=ode45(zdot,[0 20],z0,options)

% Data extraction
x1=sol(:,1);        % Extract x1
x1_dot=sol(:,2);    % Extract x1_dot if needed
x2=sol(:,3);        % Extract x2
x2_dot=sol(:,4);    % Extract x2_dot if needed

% Plot results
figure(1);
plot(t,x1,t,x2);
legend('x1','x2');
xlabel('Time t [s]');
ylabel('x1 and x2 [m]');
grid on; 

%% Example 2 - METHOD 2 - lsim() function

t=0:0.01:20; % time span and fixed time step, have to specify time steps to use lsim
z0=[1;2;1;0]; % initial conditions

A=[0 1 0 0;-2 -3 1 0;0 0 0 1;-4 -3 0 -2]; % state matrix A
B=[0 0;1/2 0;0 0;0 3]; % input matrix B
C=[1 0 0 0;0 0 1 0]; % output matrix C
D=0; % direct transmission matrix D

% input u must have the same number of rows as t (2001 this case)
% and the same number of columns as B (2 in this case)
unitstep=@(x)(x>=0); % define the unit step function
u=[unitstep(t)' sin(2*t)']; % size of u is 2001x2

x=lsim(ss(A,B,C,D),u,t,z0); % size of x is 2001x2

x1=x(:,1); % extract x1
x2=x(:,2); % extract x2

% Plot results
figure(2);
plot(t,x1,t,x2);
legend('x1','x2');
xlabel('Time t [s]');
ylabel('x1 and x2 [m]');
grid on; 

%% Example 3 - initial() function

z0=[1;2;1;0]; % initial conditions

A=[0 1 0 0;-2 -3 1 0;0 0 0 1;-4 -3 0 -2]; % state matrix A
B=zeros(4); % input matrix B (4x4 Zero Matrix)
C=eye(4); % output matrix C (4x4 Identity Matrix)
D=0;

[x t]=initial(ss(A,B,C,D),z0);

x1=x(:,1); % Extract x1
x1_dot=x(:,2); % Extract x1_dot
x2=x(:,3); % Extract x2
x2_dot=x(:,4); % Extract x2_dot

% Plot results
figure(3);
plot(t,x1,t,x2);
legend('x1','x2');
xlabel('Time t [s]');
ylabel('x1 and x2 [m]');
grid on; 

%% Example 4 - step() function

% Zero initial conditions assumed / z0=[0;0;0;0];
A=[0 1 0 0;-2 -3 1 0;0 0 0 1;-4 -3 0 -2]; % state matrix A
B=[0;1/2;0;1]; % input matrix B
C=eye(4); % output matrix C
D=0;

[x t]=step(ss(A,B,C,D));

x1=x(:,1); % Extract x1
x1_dot=x(:,2); % Extract x1_dot
x2=x(:,3); % Extract x2
x2_dot=x(:,4); % Extract x2_dot

% Plot results
figure(4);
plot(t,x1,t,x2);
legend('x1','x2');
xlabel('Time t [s]');
ylabel('x1 and x2 [m]');
grid on; 

%% Example 5 - impulse() function

% Zero initial conditions assumed / z0=[0;0;0;0];
A=[0 1 0 0;-2 -3 1 0;0 0 0 1;-4 -3 0 -2]; % state matrix A
B=[0;1/2;0;1]; % input matrix B
C=eye(4); % output matrix C
D=0;

[x t]=impulse(ss(A,B,C,D));

x1=x(:,1); % Extract x1
x1_dot=x(:,2); % Extract x1_dot
x2=x(:,3); % Extract x2
x2_dot=x(:,4); % Extract x2_dot

% Plot results
figure(5);
plot(t,x1,t,x2);
legend('x1','x2');
xlabel('Time t [s]');
ylabel('x1 and x2 [m]');
grid on; 

%% Example 6 - Closed-form solution with MATLAB

A=[0 1;-2 -3];
B=[0;2];
C=[1 0];
x0=[1;0];

syms t tau

stm1=simplify(expm(A*t)); % state transition matrix
stm2=subs(stm1,t,t-tau); % replaced t with (t-tau)

x=stm1*x0+simplify(int(stm2*B*sin(2*t),tau,0,t)); % solution x
% (f,x,0,y) (function f, with respect to x, from 0 to y)

y=simplify(C*x) % final solution y
