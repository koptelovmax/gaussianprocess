function P = InitialiseParameters2d(S, options)
% TODO: update this has hard coded stuff and won not work in general!!!!

% Inducing inputs (spherical Gaussian + random selection of inputs)
P.Z = [ 3 * randn(options.gpf.numInducingPoints, options.numStates) ...
        S.U(randperm(size(S.U,1), options.gpf.numInducingPoints),:)];

% GP covfun hyper-parameters
if ~isempty(options.gpf.theta0)
    P.theta.gp = options.gpf.theta0;
else
    sigmaf = 1.6;
    P.theta.gp = [ 2.3 + zeros(size(P.Z, 2), 1); log(sigmaf)];
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
        mu = mu' - options.gpf.meanfun(P.Z);
        disp('N4SID C matrix: ')
        disp(sys.C)
    case 'RandomNonlinear'
        % TODO
    case 'MarginallyStableLinear'
        % TODO
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

% Initialisation of Sigma will have an influence on smoother
%tmp = feval(options.gpf.covfun, P.theta.gp, P.Z);
tmp = 1^2 * eye(options.gpf.numInducingPoints);
Sigma = blkdiagn(tmp, options.numStates);
[P.eta1new, P.eta2new] = mv2nat(mu, Sigma);

end