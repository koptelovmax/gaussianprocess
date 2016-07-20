function xp = nonlin(x)
% Very simple piece-wise linear system like in Andrew's paper.

if x < 4
    xp = x + 1;
else
    xp = -4*x + 21;
end

%xp = -0.8 * x;

q = 1^2;
xp = xp + sqrt(q) * randn(1);

end