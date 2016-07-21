clear; clc;

randn('seed', 1e5);
rand('seed', 1e5);

%%N = 50;
%%D = 5;
if ~exist('mappingKern', 'var'), mappingKern = 'rbfardjit'; end
if ~exist('indPoints', 'var'), indPoints = 100; end
if ~exist('latentDim', 'var'), latentDim = 20; end
% Define a temporal model
if ~exist('dynamicsConstrainType', 'var'), dynamicsConstrainType = {'time'}; end
if ~exist('initVardistIters', 'var'), initVardistIters = 100; end
if ~exist('itNo', 'var'), itNo = [50 50]; end
if ~exist('dynamicKern', 'var'), dynamicKern = {'rbf','white','bias'}; end
%if ~exist('dynamicKern', 'var'), dynamicKern = {'rbf','white','lin'}; end
if ~exist('makePlot', 'var'), makePlot = true; end

%! Load DT sequences as training samples
texture_name = 6; 
im_width = 120;
im_height = 90;
predFrames = 500;
videoSize = [im_width im_height];

load(strcat(num2str(texture_name),'.mat'));
Y = zeros(length(mov),im_height*im_width);
for k = 1:length(mov)
    I = rgb2gray(mov(k).cdata);
    Y(k,:) = I(:);
end

%! Perform normalization
Y_mean = mean(Y(:));
Y_std = std(Y(:));
Y = (Y - Y_mean)/Y_std; % normalization

% Define dimensionalities
N = size(Y,1);
D = size(Y,2);
t = linspace(0, 2*pi, N)';
assert(N == length(t));

%% Create and optimise the model

% Options for the model
vargplvm_init; % Returns a configuration structure 'globalOpt'
options = vargplvmOptions('dtcvar');
options.kern = mappingKern;
options.numActive = indPoints;
options.optimiser = 'scg2';
options.latentDim = latentDim;
options.initSNR = 100;

if ~isempty(dynamicsConstrainType)
    % Temporal model (VGPDS)
    if ~exist('optionsDyn', 'var')
        optionsDyn.type = 'vargpTime';
        optionsDyn.t=t;
        if ~isstruct(dynamicKern)
            optionsDyn.kern = kernCreate(t, dynamicKern);
        else
            optionsDyn.kern = dynamicKern;
        end
    end
    % Create and optimise the model
    [~, ~, ~, ~, model] = vargplvmEmbed2(Y, latentDim, options, initVardistIters, itNo, true, optionsDyn);
else
    % Non-dynamical model (Bayesian GP-LVM)
    % Create and optimise the model
    [~, ~, ~, ~, model] = vargplvmEmbed2(Y, latentDim, options, initVardistIters, itNo, true);
end

% Uncomment the following for to optimise for some more iterations
% model = vargplvmOptimiseModel(model, true, true, {initVardistIters, itNo}, true);

%% Plot the fit
%{
if ~isempty(dynamicsConstrainType) && makePlot
    vgpdsPlotFit(model, [], 1:model.d, 6);
end
%}

%% Prediction
% Perform prediction of new X
K_x = kernCompute(model.dynamics.kern, model.X(1:end-1,:));
invKx = pdinv(K_x);

X_synt = zeros(predFrames,model.q);
X_last = model.X(end,:);

for i = 1:predFrames
    X_synt(i,:) = predictNewLatentFrame(model.X,model.dynamics.kern,invKx,X_last);
    X_last = X_synt(i,:);
end

plot(X_synt);

% Perform syntesis of dynamic texture based on predicted X
Y_synt = zeros(predFrames,D);

K_y = kernCompute(model.kern, model.X);
invKy = pdinv(K_y);

K_yy = kernCompute(model.kern, model.X, X_synt);
K_y2 = kernCompute(model.kern, X_synt, X_synt);

meann = Y'*invKy*K_yy;
cov = K_y2 - (K_yy'*invKy*K_yy);

for i = 1:D
    Y_synt(:,i) = (cov*randn(predFrames,1)) + meann(i,:)';
end

%% Denormalization
Y_synt_denorm = floor(Y_std * Y_synt + Y_mean);

synth_Result(1:predFrames) = struct('frame', zeros(im_height, im_width, 'uint8'));

for t = 1:predFrames
   I = Y_synt_denorm(t,:);
   I_min = min(I(:));
   I_max = max(I(:));
   I = (255/(I_max - I_min))*(I - I_min);   
   synth_Result(t).frame = reshape(uint8(I),im_height,im_width);
end

%% Output the results
save('synth_Result.mat','synth_Result');
