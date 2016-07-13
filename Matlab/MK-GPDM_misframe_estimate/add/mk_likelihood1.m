function L = testlikelihood(params, Y, segments, kern, N, missed)


% global W_VARIANCE
% global M_CONST
% global BALANCE


% recConst = M_CONST; % =1 ���ڵ�������beta���Ż���������ʧ�����е�ϵ����Ĭ��Ϊ1
% lambda = BALANCE;   % =1������B-GPDMģ��

%%%N = size(Y, 1); % �۲�����ĳ���
D = size(Y, 2); % �۲������ά��

% num_hyperpara_Kx = 4; % ����ѧģ���г������ĸ���

num_kern = length(kern.comp);
num_hyperpara_Kx = 1; % �����ʼ��
for i = 1:num_kern
    num_hyperpara_Kx = num_hyperpara_Kx + kern.comp{i}.nParams;
end

%% ���������params�н���ʼ����������X��K_y�ĳ�������K_y�ĳ�������ȡ����

% ��ȡ������X
Q = floor((length(params)-(num_hyperpara_Kx+3))/N);  %�ع�����������X��ά�ȣ�Ҳ���ǽ�ά���ά��
X = reshape(params(1:N*Q), N, Q); % �ѳ�ʼ������������params�г�ȡ����

% ��ȡK_y�ĳ�����
hyperpara_Ky = exp(params(end-(num_hyperpara_Kx+2):end-num_hyperpara_Kx)); % ��ȡK_y�ĳ�����������Ϊ3
hyperpara_Kx = exp(params(end-(num_hyperpara_Kx-1):end)); % ��ȡK_X�еĳ�������������Ҫ�仯

% fprintf( 'hyperpara_Ky: %s \n',num2str(hyperpara_Ky));
% fprintf( 'hyperpara_Kx: %s \n',num2str(hyperpara_Kx));
% ��������Ƕ�뵽�ṹ����

kern = mk_kernExpandParam(kern,hyperpara_Kx);

% init_para = 1;
% for i = 1:length(kern.comp)
%     fhandle = str2func([kern.comp{i}.type 'KernExpandParam']);  
% 	kern.comp{i} = fhandle(kern.comp{i}, hyperpara_Kx(init_para:init_para+kern.comp{i}.nParams-1)); % �������ṹ�������볬����
%     init_para = init_para + kern.comp{i}.nParams;
% end
% dynamic_noise_para = exp(params(end));

% theta = thetaConstrain(theta);
% thetap = thetaConstrain(thetap);

%% ����Markovģ�ͽ�Xin��Xout�ֳ��������ﲻ������������ȱʧ�����
[Xin, Xout] = mk_priorIO(X, segments); % ��Xin��Xout��X�м��ȡ���������������һ��Markovģ�͵����
num_Xin = size(Xin, 1);  % Xin���ݵĳ���

%% ���ݵ�ǰ�����ͱ�������K_y��K_x
[Ky, ~] = computeKernel(X, hyperpara_Ky); % compute Ky with respect to N frames of X 
X1 = [X(1:missed-1,:); X(missed+1:end,:)]; % update X with N-1 frames (without missed frame)
[~, invKy] = computeKernel(X1, hyperpara_Ky); % compute Ky with respect to N-1 frames of X 
% [Kx, invKx, ~] = mk_computePriorKernel(Xin, hyperpara_Kx);  % ������µĺ���

[~, sum_kerns] = mk_computeCompoundKernel(kern, Xin);

% Kx = zeros(num_Xin,num_Xin);
% for i = 1:num_kern
%     Kx = Kx + mk_kern{i};
% end
Kx = sum_kerns + eye(size(Xin, 1))*1/hyperpara_Kx(end); % ���Ȼ�����������
invKx = pdinv(Kx);
clear mk_kern;


%% ������ʧ����L

LOG2PI = log(2*pi); % Ϊ�˽�ʡ����ʱ�䣬����һ��Ԥ����

% Constant = - (DN+Q(N-1))/2 * ln 2pi 
CONST = -D*N/2*LOG2PI - Q*num_Xin/2*LOG2PI; % ��ʧ�����еĳ����num_Xin = N-1

% L_part1 = - D/2 * log |Ky|
L_part1 = -D/2*logdet(Ky); 

% L_part2 = 1/2 * tr(Ky^{-1}*Y*Y^T)
L_part2 = 0;
for d= 1:D % L = L - sum_i^D (-1/2 * w_i * w_i * Y_i^T * K^-1 * Y_i)
    L_part2 = L_part2 -0.5*Y(:, d)'*invKy*Y(:, d); % fix here(!) use another invKy
end

% L_part3 = Q/2 * log |Kx|
L_part3 = - Q/2*logdet(Kx);

% L_part4 = 1/2 * tr(Ky^{-1}*Xout*Xout^T)
L_part4 = 0;
for d= 1:Q
    L_part4 = L_part4 - 0.5*Xout(:, d)'*invKx*Xout(:, d); % -0.5 * SUM_i (Xout_i^T * K_x^{-1} * Xout_i) 
end

% L_part5 = sum(ln(hyperpara_Ky)) + sum(ln(hyperpara_Kx))
L_part5 = - sum(log(hyperpara_Ky)) - sum(log(hyperpara_Kx));

% L_part6 = ln p(x_1)
L_part6 = - size(segments,2)*Q/2*LOG2PI - 0.5*sum(sum(X(segments,:).*X(segments,:)));

% ��������ʵ��ȫ�������� 
L = CONST + L_part1 + L_part2 + L_part3 + L_part4 + L_part5 + L_part6;

% W_part 
% W_part = N*sum(log(w)); % L = L + N*sum(log w_i)
% if (W_VARIANCE > 0) 
%     W_part = W_part + D*log(2) - D/2*log(2*pi*W_VARIANCE) - 0.5/W_VARIANCE*sum(w.*w) ; % L = L + D * log(2) - *** ����Ĳ��ֺ�Ȩ�ز���w���
% end
% L = -(L + W_part);

L = -L;