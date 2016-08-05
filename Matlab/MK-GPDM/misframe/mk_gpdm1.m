function [X, hyperpara_Ky, hyperpara_Kx, w_params] = mk_gpdm1(X, Y, missed, segments, hyperpara_Ky, hyperpara_Kx, kern, options, extIters)


N = size(X,1);  % now N is taken as a number of latent frames X
D = size(Y,2);  %����ά��
Q = size(X,2);  %�ӿռ�ά��

lnHyperpara_Ky = log(hyperpara_Ky);   % ����log��ʽ�� theta�� theta��Ӧ����alpha
lnHyperpara_Kx = log(hyperpara_Kx); % ����log��ʽ�� thetap�� thetap��Ӧ����beta

w_options = options;
w_options(14) = 20;


for iters = 1:extIters %ÿһ�ε�������ME�㷨�Ļ��������ķ�ʽ���ܻ�����Ҫ�ģ�
    
    fprintf(2,'Iteration %d\n',iters);
  
    % STAGE 1, OPTIMIZE THE HYPERPARAMETERS AND X

    params = [X(:)' lnHyperpara_Ky lnHyperpara_Kx];

    [params, options, flog] = scg('mk_likelihood1', params, options, 'mk_gradient1', Y, segments, kern, N, missed);
    % ����SCG������ģ�ͽ�����⣬�õ��Ż���params����
        
    % STAGE 2, OPTIMIZE THE WEIGHT PARAMETERS

    [X,lnHyperpara_Kx,lnHyperpara_Ky] = mk_paramsDecompose(params,N,Q,kern);  % ע�⣬������SCG�����Ĺ����У���������ĳ���������ln��ʽ��
    
    % ��Kx�ĳ�����Ƕ�뵽�ṹ���У�֮���һֱ���ֲ��䣬ֱ����һ�εĵ���    
    
    kern = mk_kernExpandParam(kern,exp(lnHyperpara_Kx));
   
    % �ѽṹ���е�Ȩ����ȡ��������Ϊ�µ�params
    w_params = mk_kernWeightExtract(kern);
    
    
    [w_params, options, flog] = scg('weight_likelihood', w_params, w_options, 'weight_gradient',X, kern);
    
    w_params = mk_weightsConstrain(w_params); %  ��Ȩ����Լ��
    
%     plot(w_params,'-o');    
   
    kern = mk_updateKernWeight(kern,w_params); % ��Ȩ��ֵ�������뵽�˺����ṹ���У�������һ�ε��Ż�
  
end

hyperpara_Ky = exp(lnHyperpara_Ky);
hyperpara_Kx = exp(lnHyperpara_Kx);