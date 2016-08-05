% This is the demo script for the algorithm Multi-Kernel Gaussian Process
% Dynamic Model.

clear;clc;

%rand('twister',sum(clock*100))

addpath('mkgpdm');
addpath('netlab');
addpath(genpath('kernelFunctions'));

% Load DT sequences as training samples
texture_name = 1; 
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

global_setting;
segments = 1;
format long;

%% Set the paramters for SCG
opt = foptions;
opt(1) = 1;
opt(9) = 0;
opt(14) = 20; % total number of iterations
extItr = 25; % do extItr*opt(14) iterations in total

%%

N = size(Y, 1);  % The count of samples
D = size(Y, 2);  % The dimensionality of observed space
Q = 20;          % The dimensionality of latent space

%% ! missing frame
Nmis = 10; % number of last frames to be missed
Ymissed = Y(end-Nmis+1:end,:); % save missed frames
Y(end-Nmis+1:end,:)=[]; % remove missed frames

%% !!! Normalization using mean and standard deviation

Y_min = min(Y(:));
Y_max = max(Y(:));
Y_denorm = Y;

Y_mean = mean(Y(:));
Y_std = std(Y(:));
Y = (Y - Y_mean)/Y_std; % normalization

%% Initialize the latent variable using PCA
X = zeros(N, Q);
[u,~,v,~] = princomp(Y);
X = Y*u(:, 1:Q)*diag(1./sqrt(v(1:Q))); 

%% Define the combined kernels
%kernType = {'poly','ratquad','mlp'};
kernType = {'lin','rbf','poly','ratquad','mlp','matern32'};
kern = kernCreate(1:(N-segments),kernType);
kern = mk_initKernWeight(kern);

%% Initialize the hyperparameters
hyperpara_Ky = [1 1 exp(1)];
num_hyperpara_Kx = 1; % ÔëÉùÏî¿ªÊ¼Ëã
for i = 1:length(kern.comp)
    num_hyperpara_Kx = num_hyperpara_Kx + kern.comp{i}.nParams;
end

hyperpara_Kx = rand(num_hyperpara_Kx,1);
hyperpara_Kx(end) = exp(1);
hyperpara_Kx = hyperpara_Kx';

weight = mk_weightsConstrain(ones(length(kernType),1));

%% Define the combined kernel structure

kern = mk_kernExpandParam(kern,hyperpara_Kx);
kern = mk_updateKernWeight(kern,weight);

%% Optimization
[X, hyperpara_Ky, hyperpara_Kx, weight] = mk_gpdm(X, Y, segments, hyperpara_Ky, hyperpara_Kx, kern, opt, extItr);

%% Prediction
[Ysample, Ymean, X_pred] = mk_prediction(X, Y, hyperpara_Ky, hyperpara_Kx, weight, kern, predFrames, segments);
figure(1); plot(X_pred);

%% Denormalization
Ysynt = Ymean; % mean prediction (take Ymean instead of Ysample)
Y_synt_denorm = floor(Y_std * Ysynt + Y_mean);

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