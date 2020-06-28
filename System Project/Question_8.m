%% Question 8 - Nguyen Vo
%% Part i 
% Finding the closed-form solution
syms s; % Define s as a symbolic variable
X=(1+3*exp(-s)+exp(-3*s)/s)/((s^2+4*s+3));
x=ilaplace(X);
pretty(x) 
x1=subs(x);

%% Part ii - ss() and lsim()
% Transfer function of 1/(s^2+4s+3) with input of
% Dirac_Delta_t + 3*Dirac_Delta_(t-1) +u(t-3)
num=[1]; % numerator of G(s)
den=[1 4 3]; % denominator of G(s)
sys=tf(num,den); % G(s)
t=0:0.01:7; % Time Span
% The following two lines create the input function
unitstep=@(x)(x>=0); % Define the unit step function. True is 1, False is 0
deltat=0.01;
u=(unitstep(t)-unitstep(t-deltat))/deltat+3*(unitstep(t-1)-unitstep(t-1-deltat))/deltat+unitstep(t-3); 
% The input(unitstep(t-t0)-unistep(t-t0-deltat))/deltat is the numerical definition of dirac delta function
% Solve for the output given the input function using lsim()
x2=lsim(sys,u,t); 

%% Part iv - Plotting of x with intentional different heights for comparison
figure(1);
plot(t,x1,t,x2+0.25,tout,simout+0.5);
legend('ilaplace()','tf() and lsim()','simulink');
xlabel('Time t [s]');
ylabel('Response x [m]');
grid on;  