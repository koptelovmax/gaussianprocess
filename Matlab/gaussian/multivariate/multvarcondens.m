function [meann,var] = multvarcondens(K,n,f,mju)
% returns mean and variance parameters for multivariate conditional
% density depending on covariance matrix K, initial points matrix f, 
% total number of attributes n and initial mean vector mju

% preallocation for speed
K1n = zeros(1,n-1);
Kn1 = zeros(n-1,1);
Knn = zeros(n-1,n-1);
Fmju = zeros(n-1,1);

for i=1:(n-1)
    K1n(1,i) = K(n,n-i);
    Kn1(i,1) = K(n-i,n);
    Fmju(i,1) = f(n-i,1)-mju(n-i,1);
    for j=1:(n-1)
       Knn(i,j) = K(n-i,n-j);
    end
end

%invKnn = Knn^(-1);
R = chol(Knn);
S = R^(-1);
invKnn = S*S';

meann = mju(n,1) + K1n*invKnn*Fmju;
var = K(n,n) - K1n*invKnn*Kn1;

end