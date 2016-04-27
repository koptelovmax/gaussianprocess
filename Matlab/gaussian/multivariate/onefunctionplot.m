clear all; close all;

d = 100; % dimensionality
x = 1:1:d; % data equally spaced
x(90:100) = 90:5:140; % not equally
K = getkernmatrix2(x,x);
I = label2rgb(int8(K*100));
%figure(1); imshow(K/max(max(K)));
mju = zeros(1,d);

f_cond = [1; 1];
x_cond = [40 80];

K_x_c = getkernmatrix2(x,x_cond);

%I = label2rgb(int8(K_x_c*100));
%figure(2); imshow(K_x_c/max(max(K_x_c)));

invK_c_c = getkernmatrix2(x_cond,x_cond)^(-1);

mju_cond = mju' + K_x_c*invK_c_c*(f_cond - 0);
sigma_cond = K - K_x_c*invK_c_c*K_x_c';

R = mvnrnd(mju_cond',sigma_cond,5); % multigaussian in one function

plot(x,R,'-');
