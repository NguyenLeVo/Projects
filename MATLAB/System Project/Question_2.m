%% Question 2 - Nguyen Vo
% Transfer function of 1/(s^2 + 4s + 9) 
num=[1]; % numerator of G(s)
den=[1 4 9]; % denominator of G(s)
sys=tf(num,den); % G(s)

%% Part i - tf() and impulse()
% Impulse function with input of 5*Dirac_Delta_t
[x t]=impulse(sys); % MATLAB will determine time steps and span
% Plotting of x
figure(1);
plot(t,5*x); % 5*x is 5*Dirac_Delta_t
legend('x(t)');
xlabel('Time, t [s]');
ylabel('Response, x [length]');
grid on; 

%% Part ii - tf() and step()
% Step function
t=0:0.01:10;
[x,tt]=step(sys,t); 
% Plotting of x
figure(2);
plot(tt,5*x);
legend('x(t)');
xlabel('Time, t [s]');
ylabel('Response, x [length]');
grid on;

%% Part iii - tf() and lsim()
t=0:0.01:10; % time span
% The following two lines create the input function
unitstep=@(x)(x>=0); % Define the unit step function. True is 1, False is 0
u=5*t.*(1-unitstep(t-2))+2*sin(6*t); % The input function
% Solve for the output given the input function using lsim()
x=lsim(sys,u,t); 
% Plotting of x
figure(3);
plot(t,x);
legend('x(t)');
xlabel('Time, t [s]');
ylabel('Response, x [length]');
grid on; 