%% Question 4 - Nguyen Vo
% Transfer function of s/(2s^2 + 4s + 10) with input of u(t)
num=[1 0]; % numerator of G(s)
den=[2 4 10]; % denominator of G(s)
sys=tf(num,den); % G(s)
% Step function
[x,tt]=step(sys,t); % Matlab will determine time steps for accuracy
% Plotting of x
figure(1);
plot(tt,x);
legend('x(t)');
xlabel('Time t [s]');
ylabel('Response x [length]');
grid on;
