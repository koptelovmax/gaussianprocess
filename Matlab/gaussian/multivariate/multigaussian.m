clear all; close all;

N = 100; % number of dimensions
m = 1; % number of points for every dimension to generate
L = 8; % number of curves to generate
x = 1:1:N; % data equally spaced
mju = zeros(N,1); % mean vector
x(90:100) = 90:5:140; % not equally
K = getkernmatrix(x);
I = label2rgb(int8(K));
%figure(1); imshow(I);

figure(2); hold on;
color = ['y','m','c','r','g','b','w','k'];

for j=1:L
    f_cond = zeros(N,m); % matrix of points for all dimensions
    f_cond(40,1) = 1; % bound
    f_cond(80,1) = 1; % bound

    f_cond(1,:) = random('Normal', mju(1,1), sqrt(K(1,1)), 1, m);

    for i=2:N
        if f_cond(i,:) == 0
            [MU,SIGMA] = multvarcondens(K,i,f_cond,mju);
            f_cond(i,:) = random('Normal', MU, sqrt(SIGMA), 1, m);
        end
    end
    
    plot(x,f_cond(:,1),'-','Color',color(j));
    
    
end
