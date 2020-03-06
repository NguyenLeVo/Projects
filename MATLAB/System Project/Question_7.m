%% Question 7 - Nguyen Vo
%% Plotting the response of the vehicle's body 
figure(1);
plot(tout,simout); 
legend('Input','Simulink Response');
xlabel('Time t [s]');
ylabel('Response x [length]');
grid on;