function [Ymean, X_pred] = mk_prediction1(X, Y, missed, hyperpara_Ky, hyperpara_Kx, weight, kern, predFrames, segments)

Xmissed = X(missed,:); % save predicted X
X(missed,:) = []; % remove missed frame

% ����Ky��invKy
[Ky, invKy] = computeKernel(X, hyperpara_Ky);

% ����Xin
%%%[Xin, ~] = mk_priorIO(X, segments);

% [~, invKd] = mk_computePriorKernel(Xin, hyperpara_Kx);

% �Ѻ�Kx��صĳ�������Ȩ�ض�Ƕ�뵽�˽ṹ����
%%%kern = mk_kernExpandParam(kern,hyperpara_Kx(1:(end-1)));
%%%kern = mk_updateKernWeight(kern,weight);

% ����Kx
%%%[~, sum_kerns] = mk_computeCompoundKernel(kern, Xin);
%%%Kx = sum_kerns + eye(size(Xin, 1))*1/hyperpara_Kx(end); % ���Ȼ�����������

% ����invKx
%%%invKx = pdinv(Kx);

% ����֡������
%%%simSteps = predFrames;

% starts at ened of training sequence;
% ��ʹ�ö���Markovģ��ʱ����һ�����岻��ȷ
%%%simStart = [X(segments(1)+1,:) X(end,:)]; %  inputs 2 points in case using 2nd order model ����simStart����[X(2) X(200)]

% ���ɵ�simSteps֡������
%[X_pred, ~] = mk_simulatedynamics(X, segments, hyperpara_Kx, invKx, simSteps, simStart, kern);
X_pred = Xmissed;

% �ٰ��������ع�����ά�ռ�
[~, Ymean] = mk_sampleReconstruction(X_pred, X, Y, hyperpara_Ky, Ky, invKy);
