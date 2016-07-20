function out = generatedata()
% Generate data from nonlin system (no external inputs).

persistent X

T = 1e4;

if isempty(X)
    X = nan(T,1);
    X(1) = 0;
    for i = 2:T
        X(i) = nonlin(X(i-1));
    end
end
out = X;

end
