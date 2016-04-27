clear all; close all;
% construction of radial basis
x = -8:0.1:8;
l = 2;
figure(1); hold on;

mean_x = -4;
Phi = exp(-abs(x-mean_x).^2/(2*l^2));
plot(x,Phi,'b');

mean_x = 0;
Phi = exp(-abs(x-mean_x).^2/(2*l^2));
plot(x,Phi,'g');

mean_x = 4;
Phi = exp(-abs(x-mean_x).^2/(2*l^2));
plot(x,Phi,'r');

% construction
figure(2); hold on;
N = 5; 
w = randn(1,N);
fx = 0; mean_x = -4;
for i=1:N
   mean_x = mean_x + 1;
   Phi = exp(-abs(x-mean_x).^2/(2*l^2));
   fx = fx + w(i)*Phi;
end
plot(x,fx,'b');

w = randn(1,N);
fx = 0; mean_x = -4;
for i=1:N
   mean_x = mean_x + 1;
   Phi = exp(-abs(x-mean_x).^2/(2*l^2));
   fx = fx + w(i)*Phi;
end
plot(x,fx,'g');

w = randn(1,N);
fx = 0; mean_x = -4;
for i=1:N
   mean_x = mean_x + 1;
   Phi = exp(-abs(x-mean_x).^2/(2*l^2));
   fx = fx + w(i)*Phi;
end
plot(x,fx,'r');

histfit(fx);
