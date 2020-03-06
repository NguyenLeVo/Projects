%% Question 3 - Nguyen Vo
%% Part i
% Transfer function of (7s + 5)/(2s^2 + 7s + 20) with input of 5u(t)
num=[7 5]; % numerator of G(s)
den=[2 7 20]; % denominator of G(s)
sys=tf(num,den); % G(s)
[x,tt]=step(sys,t); % Matlab will determine time steps for accuracy
% Plotting of x
figure(1);
plot(tt,5*x);
legend('x(t)');
xlabel('Time t [s]');
ylabel('Response x [length]');
grid on;

%% Part ii
t=0:0.01:10; % Time Span
% The following two lines create the input function
unitstep=@(x)(x>=0); % Define the unit step function. True is 1, False is 0
u=t.*(1-unitstep(t-1))+(-t+2).*(unitstep(t-1)-unitstep(t-3))+(t-4).*(unitstep(t-3)-unitstep(t-4)); % The input
% Solve for the output given the input function using lsim()
x=lsim(sys,u,t); 
% Plotting of x
figure(2);
plot(t,x,t,u);
legend('x(t)','Input u(t)');
xlabel('Time t [s]');
ylabel('Response x [length]');
grid on;