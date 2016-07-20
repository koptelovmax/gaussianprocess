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
if ~exist('initVardistIters', 'var'), initVardistIters = 20; end
if ~exist('itNo', 'var'), itNo = [50 50]; end
%if ~exist('dynamicKern', 'var'), dynamicKern = {'rbf','white','bias'}; end
if ~exist('dynamicKern', 'var'), dynamicKern = {'rbf','white','lin'}; end
if ~exist('makePlot', 'var'), makePlot = true; end

%! Load DT sequences as training samples
texture_name = 6; 
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
if ~isempty(dynamicsConstrainType) && makePlot
    vgpdsPlotFit(model, [], 1:model.d, 6);
end
