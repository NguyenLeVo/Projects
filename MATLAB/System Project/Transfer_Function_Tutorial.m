format compact;

%% === Transfer Function Practice ===

%% Example 8 - Partial Fraction 
top1=[9*10^-4 10^-3];
top2=[0.5];
bottom=[18*10^-8 4.52*10^-5 2.55*10^-3 0];
[r1,p1,k1]=residue(top1,bottom)
[r2,p2,k2]=residue(top2,bottom)

%%  Example 9 - tf() function (Real- or Complex-valued transfer function) 
% or to convert state-space models to transfer function form

% Define variables
KT=0.05;
Kb=KT;
La=2e-3;
Ra=0.5;
IM=9e-5;
c=1e-4;

% Transfer function % Combined the numerator/denominator into the tf()
torque=tf(KT*[IM,c],[La*IM,Ra*IM+c*La,c*Ra+Kb*KT]); % torque (eqn 7.1)
omega=tf([KT],[La*IM,Ra*IM+c*La,c*Ra+Kb*KT]);       % motor speed (eqn 7.2)
    % transfer_function=tf(output_function,input_function)
    % output_function=[an,an-1,...,a0] * [s^n,s^n-1,...,1]
    % input_function=[bn,bn-1,...,b0]

% Plotting
t=0:0.001:0.1;
[torq,tt]=step(torque,t); % Matlab will determine time steps for accuracy
[speed,ts]=step(omega,t);
    % Plotting the torque transfer function
figure(1);
subplot(2,1,1); % 10*torq because it is a unit step function so have to *10
plot(tt,10*torq);
grid on;
xlabel('Time, t [sec]');
ylabel('Torque, T [N-m]');
    % Plotting the angular velocity transfer function
subplot(2,1,2);
plot(ts,10*speed);
grid on;
xlabel('Time, t [sec]');
ylabel('Speed, \omega [rad/s]');

%% Example 10 - lsim() function

% Define variables
m1=6;
m2=50;
k1=1100;
k2=1530;
c=400;

% Transfer function
num=[k1*c k1*k2]; % numerator of G(s)
den=[m1*m2 (m1+m2)*c k1*m2+k2*(m1+m2) k1*c k1*k2]; % denominator of G(s)
sys=tf(num,den); % G(s)
% or sys=tf([k1*c k1*k2],[m1*m2 (m1+m2)*c k1*m2+k2*(m1+m2) k1*c k1*k2]);

% Plotting
t=0:0.01:10; % time span
    % The following two lines cook the input function
unitstep=@(x)(x>=0); % Define the unit step function. True is 1, False is 0
u=t.*(1-unitstep(t-1))+(-t+2).*(unitstep(t-1)-unitstep(t-2)); % The input
    % Solve for the output given the input function
x=lsim(sys,u,t); 
    % Plotting the input in red and transfer function in blue
figure(2);
plot(t,x,t,u);
xlabel('time t');
ylabel('x');
grid on; 

%% Example 11 - impulse() function

% Transfer function of 1/(55s^2 + 100s +2500) with input of 5*Dirac_Delta_t
num=[1]; % numerator of G(s)
den=[55 100 2500]; % denominator of G(s)
sys=tf(num,den); % G(s)

% Impulse function
[x t]=impulse(sys); % MATLAB will determine time steps and span for you

% Plotting of x
figure(3);
plot(t,5*x);
xlabel('time t');
ylabel('x');
grid on; 