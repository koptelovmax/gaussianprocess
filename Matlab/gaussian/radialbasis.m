clear all; close all;
% radbas
x = -3:0.1:3;
a = radbas(x);
figure(1); plot(x,a);

% net with radbas
x=0:0.4:10;
y=sin(x);
figure(2);  hold on; axis([0 10 -2 2]);
plot(x,y,'+');
eg = 0.02; % sum-squared error goal
sc = 1;    % spread constant
%run first:
%net = newrb(x,y,eg,sc);
yy = net(x); hold on;
plot(x,yy);

