format compact
%% === Kinematic Analysis of 4-bar linkages ===

%% === Position Analysis for the 4-bar linkage ===

% Define variables
a=0.762;  % Link 1 length
b=1.905;  % Link 2 length
c=1.905;  % Link 3 length 
d=2.667;  % Link 4 length (fixed)
th2=linspace(-pi,pi,361); 
                            
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

%% === Angular Velocity for the 4-bar linkage ===

% Define variables
w2=2*pi;  % Initial Angular Velocity to be 60 rpm
alp2=0; % Initial Angular Acceleration to be 0 rad/s^2

% Compute w3 and w4 for open-configuration
w3o=w2*(a/b*sin(th4o-th2)./sin(th3o-th4o)); % Has to include . to yield multiple results
w4o=w2*(a/b*sin(th2-th3o)./sin(th4o-th3o));

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

% Define coordinates of P for open-configuration
p=0.9525;         % Length of P
thp=0*pi/180;  % Angle of P in Radians (Constant)

%% === Dynamic/ Joint Force Analysis ===

%% Setting up the equations for the CG, Mass, IG, Moment arms, and Accel
% For the triangular coupler
Rcg3xp=(p*cos(thp)+b)/3;    % Distance to the Center of Gravity of the Triangle in the x-direction
Rcg3yp=(p*cos(thp))/3;      % Distance to the Center of Gravity of the Triangle in the y-direction
Rcg3=(Rcg3xp^2+Rcg3yp^2)^0.5;
del3p=atan2(Rcg3yp,Rcg3xp); % Delta3'

% Width of each link except triangular coupler
wi2=0.05;
wi4=0.05;

% Width of triangular coupler
wi3=0.05; % Chosen arbitrarily

% Thickness of each link
t2=0.025;
t3=0.025;
t4=0.025;

% Define densities
dens=7.8*10^3; % density of steel kg/m^3
dena=2.8*10^3; % density of aluminum kg/m^3

% Mass of each link
m2=25.53;
m3=140.25; % Use aluminum for the coupler
m4=61.48;

% IG of each link
ig2=1.49;
ig3=35.72;
ig4=19.79;

% Define external force and its components
fp=0; % external force on coupler point P
thf=0; % direction of fp in radians

fpX=fp*cos(thf);
fpY=fp*sin(thf);

% Moment arms of link 2
Rcg2=a/2;
R12x=Rcg2*cos(th2+pi);
R12y=Rcg2*sin(th2+pi);
R32x=Rcg2*cos(th2);
R32y=Rcg2*sin(th2);

% Moment arms of link 3
R23x=Rcg3*cos(th3o+del3p+pi);
R23y=Rcg3*sin(th3o+del3p+pi);
R43x=b*cos(th3o)-Rcg3*cos(th3o+del3p);
R43y=b*sin(th3o)-Rcg3*sin(th3o+del3p);
Rpx=p*cos(th3o+thp)-abs(R23x);
Rpy=p*sin(th3o+thp)-abs(R23y);

% Moment arms of link 4
Rcg4=c/2;
R34x=Rcg4*cos(th4o);
R34y=Rcg4*sin(th4o);
R14x=Rcg4*cos(th4o+pi);
R14y=Rcg4*sin(th4o+pi);

% Acceleration components at the CG point of each link
Acg2X=-Rcg2*alp2*sin(th2)-Rcg2*w2.^2.*cos(th2);
Acg2Y= Rcg2*alp2*cos(th2)-Rcg2*w2.^2.*sin(th2);
Acg3X=-Rcg3*alp3o.*sin(th3o)-Rcg3*w3o.^2.*cos(th3o);
Acg3Y= Rcg3*alp3o.*cos(th3o)-Rcg3*w3o.^2.*sin(th3o);
Acg4X=-Rcg4*alp4o.*sin(th4o)-Rcg4*w4o.^2.*cos(th4o);
Acg4Y= Rcg4*alp4o.*cos(th4o)-Rcg4*w4o.^2.*sin(th4o);

%% Solving for the Forces and Torque
sol=[]; % Dynamic Arrays
for i=1:length(th2)
    % Geometrix Matrix % 9x9 Matrix
    geom=[  1           0           1           0           0               0           0           0           0;        
            0           1           0           1           0               0           0           0           0;
            -R12y(i)    R12x(i)     -R32y(i)    R32x(i)     0               0           0           0           1;
            0           0           -1      	  0           1               0           0           0           0;
            0           0           0           -1          0               1           0           0           0;
            0           0           R23y(i)     -R23x(i)    -R43y(i)        R43x(i)     0           0           0;
            0           0           0           0           -1              0           1           0           0;
            0           0           0           0           0               -1          0           1           0;
            0           0           0           0           R34y(i)         -R34x(i)   -R14y(i)     R14x(i)     0];
        
    % Dynamic Matrix % 9x1 Matrix 
    dynm=[  m2*Acg2X(i);
            m2*Acg2Y(i);
            ig2*alp2; % Both ig2 and alp2 don't need indexing
            m3*Acg3X(i)-fpX; % fpX and fpY don't need indexing because constant
            m3*Acg3Y(i)-fpY;
            ig3*alp3o(i)-Rpx(i)*fpY+Rpy(i)*fpX; % Rpx and Rpy needs indexing because they change with time
            m4*Acg4X(i);
            m4*Acg4Y(i);
            ig4*alp4o(i)]; % No -T4 because we did not include external torque T4

    % Solve for Joint Forces
    sol=[sol geom\dynm];
end

%% Output Joint Forces and 
% Naming the output forces and torque
F12x=sol(1,1:361);
F12y=sol(2,1:361);
F32x=sol(3,1:361);
F32y=sol(4,1:361);
F43x=sol(5,1:361);
F43y=sol(6,1:361);
F14x=sol(7,1:361);
F14y=sol(8,1:361);
T12 =sol(9,1:361);

% Find the magniture of forces and torque
fO2=sqrt(F12x.^2+F12y.^2);
fA =sqrt(F32x.^2+F32y.^2);
fB =sqrt(F43x.^2+F43y.^2);
fO4=sqrt(F14x.^2+F14y.^2);

%%  Plotting of Joint Forces 
figure(1);
plot(th2_d,fO2,'bo',th2_d,fA,'ro',th2_d,fB,'yo',th2_d,fO4,'mo');
axis([-180 180 0 3000]); 
legend('O2','A','B','O4');
title('Joint Forces (open configuration) as a function of theta 2');
xlabel('Theta2 [Degree]');
ylabel('Force [N]');
grid on;

%%  Plotting of Required Torque
figure(2);
plot(th2_d,T12,'o');
axis([-180 180 -3000 3000]); 
title('Required torque T12 (open configuration) as a function of theta 2');
xlabel('Theta2 [Degree]');
ylabel('Torque [Nm]');
grid on;