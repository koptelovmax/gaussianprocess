function [Y, U] = generatedata2d()
% Generate data from nonlin system (no external inputs).

persistent X

T = 1e4;
U = randn(T,0);
if isempty(X)
    A = [0 1; -1 -1];
    B = [];
    C = eye(2);
    D = [];
    dt = 0.4;
    dsys = c2d(ss(A,B,C,D), dt);
    
    X = nan(T,2);
    X(1,:) = [1 1];
    for i = 2:T
        X(i,:) = (dsys.A * X(i-1,:)')' + randn(1,2);
    end
end
Y = X * [1 0]'; % no observation noise!

end