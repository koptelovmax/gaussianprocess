clear; clc;

randn('seed', 1e5);
rand('seed', 1e5);

%%N = 50;
%%D = 5;
if ~exist('mappingKern', 'var'), mappingKern = 'rbfardjit'; end
if ~exist('indPoints', 'var'), indPoints = 50; end
if ~exist('latentDim', 'var'), latentDim = 20; end
% Define a temporal model
if ~exist('dynamicsConstrainType', 'var'), dynamicsConstrainType = {'time'}; end
if ~exist('initVardistIters', 'var'), initVardistIters = 100; end
if ~exist('itNo', 'var'), itNo = [50 50]; end
%if ~exist('dynamicKern', 'var'), dynamicKern = {'rbf','white','bias'}; end
if ~exist('dynamicKern', 'var'), dynamicKern = {'rbf','dexp','mlp'}; end
if ~exist('makePlot', 'var'), makePlot = true; end

%! Load DT sequences as training samples
texture_name = 7; 
im_width = 120;
im_height = 90;
predFrames = 250;
videoSize = [im_width im_height];

load(strcat(num2str(texture_name),'.mat'));
Y = zeros(length(mov),im_height*im_width);
for k = 1:length(mov)
    I = rgb2gray(mov(k).cdata);
    Y(k,:) = I(:);
end

%% ! missing frame
Nmis = 10; % number of last frames to be missed
Ymissed = Y(end-Nmis+1:end,:); % save missed frames
Y(end-Nmis+1:end,:)=[]; % remove missed frames

%! Perform normalization
Y_min = min(Y(:));
Y_max = max(Y(:));
Y_denorm = Y;

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
%{
K_x = kernCompute(model.dynamics.kern, model.X(1:end-1,:));
invKx = pdinv(K_x);

X_synt = zeros(predFrames,model.q);
X_last = model.X(end,:);

for i = 1:predFrames
    X_synt(i,:) = predictNewLatentFrame(model.X,model.dynamics.kern,invKx,X_last);
    X_last = X_synt(i,:);
end
%}

%X_synt = zeros(predFrames,model.q);

d_t = t(end)-t(end-1);
t_new = [t' t(end)+d_t:d_t:t(end)+(d_t*Nmis)]';

K_tt = kernCompute(model.dynamics.kern,t_new,t);
invKt = pinv(model.dynamics.Kt);
X_synt = K_tt * invKt * model.X;

figure(1); plot(X_synt);

% Perform syntesis of dynamic texture based on predicted X

K_mm = model.K_uu;
K_mn1 = kernCompute(model.kern, model.X_u, model.X);
K_n1m = kernCompute(model.kern, model.X, model.X_u);
K_mn = kernCompute(model.kern, model.X_u, X_synt);

Y_synt = ((pinv(K_mm + (K_mn1 * K_n1m)) * K_n1m' * Y)' * K_mn)';


% Which method do they use to generate Y? Check in tutorials
% Look at paper and in README

%{
U = ?
invKu = model.invK_uu;
K_uu = kernCompute(model.kern, model.X_u, X_synt);
Y_synt = U' * invKu * K_uu;
%}

%% Denormalization
Y_synt_denorm = floor(Y_std * Y_synt + Y_mean);

synth_Result(1:predFrames) = struct('frame', zeros(im_height, im_width, 'uint8'));

for t = 1:predFrames
   I = Y_synt_denorm(t,:);
   I_min = min(I(:));
   I_max = max(I(:));
   I = (255/(I_max - I_min))*(I - I_min);
   %I = (((Y_max - Y_min)/255)*(I)) + Y_min;
   %Y_synt_denorm(t,:) = I;
   synth_Result(t).frame = reshape(uint8(I),im_height,im_width);
end

% after denormalization
min(Y_synt_denorm(:)), max(Y_synt_denorm(:))
Y_min, Y_max

mean(Y_synt_denorm(:)), std(Y_synt_denorm(:))
Y_mean, Y_std

%% Mean Sqaure Error
Ymissed_synt = Y_synt_denorm(end-Nmis+1:end,:);
Ymissed_synt_const = zeros(Nmis,D);
for i = 1:Nmis
    Ymissed_synt_const(i,:) = Y_synt_denorm(end-Nmis+1,:);
end

MSE = (1/D).*sum((Ymissed - Ymissed_synt).^2,2);
MSE_const = (1/D).*sum((Ymissed - Ymissed_synt_const).^2,2);
figure(2); hold on;
plot(MSE,'b'); 
plot(MSE_const,'r');

MSE_min = min(MSE(:));
MSE_mean = mean(MSE(:));
MSE_max = max(MSE(:));

dif = mean(abs(Ymissed - Ymissed_synt),2);
dif_min = min(dif);
dif_mean = mean(dif);
dif_max = max(dif);

%% Output the results
save('synth_Result.mat','synth_Result');
