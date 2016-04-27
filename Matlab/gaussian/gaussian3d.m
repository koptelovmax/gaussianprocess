clear all; close all;
g1 = randn(1,1000);
g2 = randn(1,1000);
g3d = [g1; g2];
figure(1); hist3(g3d');

% model in 3d
N = 3.0;
x=linspace(-N, N);
y=x;
[X,Y]=meshgrid(x,y);
z=(1000/sqrt(2*pi).*exp(-(X.^2/2)-(Y.^2/2)));
figure(2);
surf(X,Y,z);
shading interp
axis tight