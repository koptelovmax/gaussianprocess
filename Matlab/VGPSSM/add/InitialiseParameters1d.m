function P = InitialiseParameters1d(S, options)

% Inducing inputs (spherical Gaussian + random selection of inputs)
P.Z = [ 3 * randn(options.gpf.numInducingPoints, options.numStates) ...
        S.U(randperm(size(S.U,1), options.gpf.numInducingPoints),:)];

% GP covfun hyper-parameters
if ~isempty(options.gpf.theta0)
    P.theta.gp = options.gpf.theta0;
else
    sigmaf = 1.6;
    P.theta.gp = [ 1.8 + zeros(size(P.Z, 2), 1); log(sigmaf)];
end

% State transition noise
P.theta.Q = eye(options.numStates);

% Dynamics initialisation
switch options.ini.strategy
    % Sample initial mean q(u) from prior p(u)
    case 'LinearSubSpace'
        % Use linear subspace identification method for initialisation
        data = iddata(S.Y, S.U);
        sys = n4sid(data, options.numStates);
        % convert to discrete ss model!!!!!!!
        mu = sys.A * P.Z(:,1:options.numStates)' + sys.B * P.Z(:,options.numStates+1:end)';
        mu = mu';
    case 'RandomNonlinear'
        % TODO
    case 'MarginallyStableLinear'
        % TODO
end
% Initialisation of Sigma will have an influence on smoother
%tmp = feval(options.gpf.covfun, P.theta.gp, P.Z);
tmp = 4^2 * eye(options.gpf.numInducingPoints);
Sigma = blkdiagn(tmp, options.numStates);
[P.eta1new, P.eta2new] = mv2nat(mu, Sigma);function plot1dsystem(P,options)

[mu,Sigma] = nat2mv(P.eta1new, P.eta2new);

plot(P.Z(:,1), mu(:,1),'o')
hold on
%plot([-6 4 6],[-5 5 -3],'g','LineWidth',2)
plot([-6 4 6],[-5 5 -3]-[-6 4 6],'g','LineWidth',2)

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

% Likelihood
P.theta.lik = options.lik.theta0;
switch options.lik.type
    case 'Lin+GaussianDiag'
        if options.numStates >= size(S.Y, 2)
            P.theta.lik.C = [eye(size(S.Y, 2))  zeros(size(S.Y, 2), options.numStates-size(S.Y, 2))];
        end
end
% TODO: This should be initialised with the noise estimated when
% initialising the dynamics.
P.theta.lik.R = eye(size(S.Y, 2));

end