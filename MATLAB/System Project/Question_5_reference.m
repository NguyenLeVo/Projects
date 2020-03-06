% Problem 5
% Abrar Rashid 
a = [0 1;-10 -4];
b = [0;5];
c = [1 0];
x0 = [1;0.5];
% Part 1
syms t t2;
M = expm(a*t);% state transition matrix
M2 = subs(M,t,t-t2); %state transition matrix 2
y = M*x0+int((M2*b*sin(2*t2)),t2,0,t); %
x = c*y;
t = 0:0.01:7;
x2 = subs(x);
pretty(x)

% Part 2
yprime = @(t,y)([y(2);-10*y(1)-4*y(2)+5*sin(2*t)]);
op = odeset('reltol',1e-6,'abstol',1e-8);
[tau,sol] = ode45(yprime,t,x0,op); 
y1 = sol(:,1);
y2 = sol(:,2);

% Part 3
t = 0:0.01:7;
a = [0 1;-10 -4];
b = [0 0; 0 5];
c = [1 0; 0 0];
d = 0;
x0 = [1;0.5];
unit = @(x)(x>=0);
u = [unit(t)' sin(2*t)'];
z = lsim(ss(a,b,c,d),u,t,x0);
z1 = z(:,1);
z2 = z(:,2);

% Part 4
% addition of 0.25,0.5 & 0.75 is to differentiate the curves on a single
% plot
plot(t,y1+0.25,'b',t,z1+0.5,'g',tout,simout+0.75,'r')
hold on;
fplot(x,[0,7]);
hold off;
xlabel('Time (s)')
ylabel('x(t)')
legend('i','ii','iii','iv')
axis([0 6 -0.5 2]);
grid on;