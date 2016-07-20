function Plot1DSystem(P,options)

[mu,Sigma] = nat2mv(P.eta1new, P.eta2new);

plot(P.Z(:,1), mu(:,1),'o')
hold on
meanType = 'identity';
switch meanType
    case 'identity'
        plot([-6 4 6],[-5 5 -3],'g','LineWidth',2)
    case 'zero'
        plot([-6 4 6],[-5 5 -3]-[-6 4 6],'g','LineWidth',2)
end
xstar = linspace(-6,6,300)';

Kuu = options.gpf.covfun(P.theta.gp, P.Z);
L = chol(Kuu + 1e-6 * Kuu(1,1) * eye(size(Kuu)));
xu = [xstar zeros(size(xstar,1), 2)];
Kmu = options.gpf.covfun(P.theta.gp, xu, P.Z);
A = (Kmu / L) / L';
V  = L' \ Kmu';
B = options.gpf.covfun(P.theta.gp, xu, 'diag') - sum(V.*V, 1)';
plot(xstar, A * mu, 'b')
if true
%     plot(xstar, A * mu + 2 * sqrt(B), 'r')
%     plot(xstar, A * mu - 2 * sqrt(B), 'r')
    ASA = diag(A * Sigma * A');
    plot(xstar, A * mu + 2 * sqrt(B + ASA), 'm')
    plot(xstar, A * mu - 2 * sqrt(B + ASA), 'm')
end

end