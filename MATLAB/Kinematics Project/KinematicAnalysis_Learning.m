% Basic Understanding of Kinematics Matlab
format compact
% Program 1
fprintf(" Program 1 \n Original numbers \n");
a=[ 5 6 9 3 4 7 1]
ind=find(a>=5); % With semicolon, it will not show the result
fprintf("Postion of values larger or equal to 5 \n");
ind % This will show the position of the value that is larger or equal to 5
fprintf("Values that are larger or equal to 5\n");
a=a(ind) % This will show the value of the position of the value >=5

% Program 2
fprintf("\n Program 2 \n Original angles \n");
b=[20 -30 50 -120 -350 0]
fprintf("The negative value will have 1 \n");
c=b<0 % No semicolon to show the result % Angle of 0 will have c=1
fprintf("New angles \n");
b=b+c*360
fprintf("Shortened method \n");
b=b+360*(b<0)

