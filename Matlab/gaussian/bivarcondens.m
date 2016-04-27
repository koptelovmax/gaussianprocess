function [meann,cov] = bivarcondens(f1,f2)
% returns mean and covariance parameters for bivariate conditional
% density depending on points vectors f1 and f2

K = zeros(2,2);
K(1,1)=mykernel(f1,f1);
K(1,2)=mykernel(f1,f2);
K(2,1)=mykernel(f2,f1);
K(2,2)=mykernel(f2,f2);

meann = mju1 + K(2,1)*(K(1,1)^(-1))*(f1(1)-mju1);
cov = K22 - K(2,1)*(K(1,1)^(-1))*K(1,2);

end