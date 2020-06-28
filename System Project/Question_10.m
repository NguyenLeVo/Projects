%% Question 10 - Nguyen Vo
%% Plotting the response of the mass m 
figure(1);
plot(tout,simout); 
legend('Simulink Response');
xlabel('Time t [s]');
ylabel('Response x [length]');
grid on;