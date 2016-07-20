clear; clc;

options.numStates = 1;
options.bDerivativeStates = false; % define state as x = (q, qdot)
options.optimisation.alg = 'RMSProp';
options.px0 = {zeros(options.numStates,1) zeros(options.numStates, options.numStates)}; % mean and cov of p(x_0)
options.qxstar.type = 'SMC'; % How to get q*(x_{0:T})
options.qxstar.numParticles = 300;
options.qxstar.numLagSteps = 3;
options.gpf.meanfun = @(x) 0 * x(:, 1:options.numStates);
options.gpf.covfun  = @covMaternard3;
options.gpf.theta0  = [];
options.gpf.numInducingPoints = 20;
options.q.type = 'Diagonal';
options.lik.type = 'Lin+GaussianDiag'; % GP+Gaussian, Student, function handle, etc.
options.lik.theta0 = [];
options.ini.strategy = 'LinearSubSpace';
options.convergence.type = 'FixedIter';
options.convergence.numIter = 50;
options.minibatch.type = 'Uniform';
options.minibatch.lengthMiniBatch = 100;
options.minibatch.edgeLength = 10;
options.inifun = @InitialiseParameters1d;
options.debugplot = @Plot1DSystem;

Y = generatedata();
U = zeros(size(Y,1), 2);
vgpssm(Y, U, options)
