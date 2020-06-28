format compact
%% === Kinematic Analysis of 4-bar linkages ===

%% === Position Analysis for the 4-bar linkage ===

% Define variables
a=30;  % Link 1 length
b=75;  % Link 2 length
c=75;  % Link 3 length 
d=105;  % Link 4 length (fixed)
% This is a crank rocker
th2=linspace(-pi,pi,361);   % From 0 to 2*pi, with (2*pi)/(721-1) increment
                            % Increment is pi/360 (rad) w/ 720 increments
                            % Using increments to plot the whole movement
                            
% Computation of necessary parameters
K1=d/a;
K2=d/c;
K3=(a*a-b*b+c*c+d*d)/(2*a*c);

A=cos(th2)-K1-K2*cos(th2)+K3;
B=-2*sin(th2);
C=K1-(K2+1)*cos(th2)+K3;

K4=d/b;
K5=(c*c-d*d-a*a-b*b)/(2*a*b);

Ap=cos(th2)-K1+K4*cos(th2)+K5;  % A'
Bp=-2*sin(th2); % B'=B          % B' 
Cp=K1+(K4-1)*cos(th2)+K5;       % C'

% Extract valid th2 (i.e., th2 within toggle positions)
Cond=(B.^2-4*A.*C);
Index=find(Cond>0);
th2=th2(Index); % Redefined th2 to only yield positive delta

% Extract parameters corresponding to valid th2
A=A(Index);
B=B(Index);
C=C(Index);
Ap=Ap(Index);
Bp=Bp(Index);
Cp=Cp(Index);

% Compute th3 for both open- and cross-configuration
Ypo=-Bp-sqrt(Bp.^2-4*Ap.*Cp);    % Open-configuration 
% Cannot use sqrt(Cond) b/c Cond has 721 values while sqrt(-) has fewer values
Ypc=-Bp+sqrt(Bp.^2-4*Ap.*Cp);    % Cross-configuration
Xp=2*Ap;
th3o=2*atan2(Ypo,Xp);
th3c=2*atan2(Ypc,Xp);

% atan2 is the arctangent function with two arguments. 
% atan2(y,x)= tan^-1(y/x)
% The angle is positive for counter-clockwise angles(y>0), and negative for clockwise angles (y<0)

% Compute th4 for both open- and cross-configuration
Yo=-B-sqrt(B.^2-4*A.*C);    % Open-configuration 
Yc=-B+sqrt(B.^2-4*A.*C);    % Cross-configuration
X=2*A;
th4o=2*atan2(Yo,X);
th4c=2*atan2(Yc,X);

% Make th3 and th4 positive angles
th3o=th3o+2*pi*(th3o<0);
th3c=th3c+2*pi*(th3c<0);
th4o=th4o+2*pi*(th4o<0);
th4c=th4c+2*pi*(th4c<0);
% Thus, this is needed because atan2(y,x) returns a negative angle when y<0

% Change radians to degrees
th2_d=th2*180/pi;
th3o_d=th3o*180/pi;
th3c_d=th3c*180/pi;
th4o_d=th4o*180/pi;
th4c_d=th4c*180/pi;
% MATLAB only reads radians but we want to express with degrees

% Plot results 
figure(1);
plot(th2_d,th3o_d,'bo',th2_d,th4o_d,'ro',th2_d,th3c_d,'b+',th2_d,th4c_d,'r+');
axis([-90 90 0 360]); % -90 to 90 for x-axis, 0 to 360 for y-axis
legend('Theta3(Open)','Theta4(Open)','Theta3(Cross)','Theta4(Cross)');
title('Theta3 and Theta 4 vs Theta2 for both open and cross configurations');
xlabel('Theta2 [Degree]');
ylabel('Theta3, Theta4 [Degree]');
grid on;

%% === Angular Velocity for the 4-bar linkage ===

% Define variables
w2=2*pi;    % Initial Angular Velocity
alp2=1;     % Initial Angular Acceleration

% Compute w3 and w4 for open-configuration
w3o=w2*(a/b*sin(th4o-th2)./sin(th3o-th4o)); % Has to include . to yield multiple results
w4o=w2*(a/b*sin(th2-th3o)./sin(th4o-th3o));

% Compute w3 and w4 for cross-configuration
w3c=w2*(a/b*sin(th4c-th2)./sin(th3c-th4c));
w4c=w2*(a/b*sin(th2-th3c)./sin(th4c-th3c));

% Plot results for angular velocity
figure(2);
plot(th2,w3o,'bo',th2,w4o,'ro',th2,w3c,'b+',th2,w4c,'r+');
axis([-pi/2 pi/2 -25 25]);
legend('Omega3(Open)','Omega4(Open)','Omega3(Cross)','Omega4(Cross)');
title('Omega3 and Omega4 vs Theta2 for both open and cross configurations');
xlabel('Theta2 [Radians]');
ylabel('Omega3, Omega4 [Radians/s]');
grid on;

%% === Acceleration Analysis for the 4-bar linkage ===

% Compute alp3 and alp4 for open-configuration
AAo=c*sin(th4o);
BBo=b*sin(th3o);
CCo=a*alp2*sin(th2)+a*w2*w2*cos(th2)+b*w3o.*w3o.*cos(th3o)-c*w4o.*w4o.*cos(th4o);
DDo=c*cos(th4o);
EEo=b*cos(th3o);
FFo=a*alp2*cos(th2)-a*w2*w2*sin(th2)-b*w3o.*w3o.*sin(th3o)+c*w4o.*w4o.*sin(th4o);

alp3o=(CCo.*DDo-AAo.*FFo)./(AAo.*EEo-BBo.*DDo);
alp4o=(CCo.*EEo-BBo.*FFo)./(AAo.*EEo-BBo.*DDo);

% Compute alp3 and alp4 for cross-configuration
AAc=c*sin(th4c);
BBc=b*sin(th3c);
CCc=a*alp2*sin(th2)+a*w2*w2*cos(th2)+b*w3c.*w3c.*cos(th3c)-c*w4c.*w4c.*cos(th4c);
DDc=c*cos(th4c);
EEc=b*cos(th3c);
FFc=a*alp2*cos(th2)-a*w2*w2*sin(th2)-b*w3c.*w3c.*sin(th3c)+c*w4c.*w4c.*sin(th4c);

alp3c=(CCc.*DDc-AAc.*FFc)./(AAc.*EEc-BBc.*DDc);
alp4c=(CCc.*EEc-BBc.*FFc)./(AAc.*EEc-BBc.*DDc);

% Plot results for angular acceleration
figure(3);
plot(th2,alp3o,'bo',th2,alp4o,'ro',th2,alp3c,'b+',th2,alp4c,'r+');
axis([-1 1 -120 120]);
legend('Alpha3(Open)','Alpha4(Open)','Alpha3(Cross)','Alpha4(Cross)');
title('Alpha3 and Alpha4 vs Theta2 for both open and cross configurations');
xlabel('Theta2 [Radians]');
ylabel('Alpha3, Alpha4 [Radians/s^2]');
grid on;

%% === Position Analysis of a Coupler Point ===

% Define coordinates of P for open-configuration
p=37.5;         % Length of P
thp=0*pi/180;  % Angle of P in Radians (Constant)

ppx=a*cos(th2)+p*cos(thp+th3o);  % Position of point P in the x-axis
ppy=a*sin(th2)+p*sin(thp+th3o);  % Position of point P in the y-axis

% Plot results
figure(4);
plot(th2_d,ppx,'bo',th2_d,ppy,'ro');
axis([-180 180 0 12]);
legend('Px','Py');
title('Position of point P vs Theta for open configuration');
xlabel('Theta2 [Degree]');
ylabel('Px,Py ["]');
grid on;

figure(5);
plot(ppx,ppy,'o');
axis([0 12 0 10]);
title('Trajectory of point P for open configuration');
xlabel('Px');
ylabel('Py');
grid on;

%% === Velocity Analysis of a Coupler Point ===

% Define velocity components
vpx=-a*w2*sin(th2)-p*w3o.*sin(thp+th3o);    % Velocity in the x-axis
vpy= a*w2*cos(th2)+p*w3o.*cos(thp+th3o);    % Velocity in the y-axis

% Plot results
figure(6);
plot(th2_d,vpx,'bo',th2_d,vpy,'ro');
axis([-180 180 -40 40]);
legend('Vx','Vy');
title('Velocity of point P vs Theta for open configuration');
xlabel('Theta2 [Degree]');
ylabel('Vx,Vy [in/s]');
grid on;

%% === Acceleration Analysis of a Coupler Point ===

% Define acceleration components
apx=(-a*alp2*sin(th2)-w2*w2*cos(th2))+(-p*alp3o.*sin(th3o+thp)-w3o.*w3o.*cos(th3o+thp));    % Acceleration in the x-axis
apy=( a*alp2*cos(th2)-w2*w2*sin(th2))+( p*alp3o.*cos(th3o+thp)-w3o.*w3o.*sin(th3o+thp));    % Acceleration in the y-axis

% Plot results
figure(7);
plot(th2_d,apx,'bo',th2_d,apy,'ro');
axis([-180 180 -2000 2000]);
legend('Ax','Ay');
title('Acceleration of point P vs Theta for open configuration');
xlabel('Theta2 [Degree]');
ylabel('Ax,Ay [in/s^2]');
grid on;