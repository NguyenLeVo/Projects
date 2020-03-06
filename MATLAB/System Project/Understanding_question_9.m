unitstep=@(x)(x>=0); % define the unitstep function
zdot=@(t,z)([z(2);666*(1-unitstep(t-0.3)).*cos(z(1))-14*sin(z(1))]);
tspan=[0 0.5]; % Time span
z0=[0;0]; % Initial Conditions
options=odeset('reltol',1e-6,'abstol',1e-8); % set solver options(optional)
[t sol]=ode45(zdot,tspan,z0,options);
th=sol(:,1); % Extract th
th_dot=sol(:,2); % Extract th_dot

tl=0:0.001:0.5;
th_linear=3.458*(1-cos(14*tl))-3.458*(1-cos(14*(tl-0.3))).*unitstep(tl-0.3);
plot(tl,th_linear,t,th);xlabel('time t [sec]');ylabel('\theta [rad]');
grid on; %plot displacements