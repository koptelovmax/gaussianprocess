function g = testgradient(params, Y, segments, kern, N, missed)

% ����˵��
% GLOBAL_PARA�����ڴ���ȫ�ֿ��Ʋ���
%
% N �۲������������Ҳ��������������
% D �۲������ά��
% num_hyperpara_Kx ����ѧģ���еĳ���������

% params �����ݽṹΪ [X hyperpara_Ky hyperpara_Kx weight]

% global GLOBAL_PARA; % ϵͳ��ȫ�ֲ����Ľṹ��

recConst = 1; %GLOBAL_PARA.M_CONST;  % =1 ���ڵ�������beta���Ż���������ʧ�����е�ϵ����Ĭ��Ϊ1
lambda   = 1; %GLOBAL_PARA.BALANCE;  % =1������B-GPDMģ��

%%N = size(Y, 1);  % �۲������������Ҳ��������������
D = size(Y, 2);  % �۲������ά��

% num_hyperpara_Kx = 4;  % 
% ���㶯��ѧģ���к˺����ĳ���������
num_kern = length(kern.comp);
num_hyperpara_Kx = 1; % �����ʼ��
for i = 1:num_kern
    num_hyperpara_Kx = num_hyperpara_Kx + kern.comp{i}.nParams;
end

%% ���������params�н���ʼ����������X��K_y�ĳ�������K_y�ĳ�������ȡ����

% ��ȡ������X
Q = floor((length(params)-(num_hyperpara_Kx+3))/N);  % ������ȡ����������ά�ȣ�Ҳ����X��ά��
X = reshape(params(1:N*Q), N, Q);                    % ������X��ԭ�ɾ���

% ��ȡK_y�ĳ�����
hyperpara_Ky = exp(params(end-(num_hyperpara_Kx+2):end-num_hyperpara_Kx)); % ��ȡK_y�ĳ�����������Ϊ3
hyperpara_Kx = exp(params(end-(num_hyperpara_Kx-1):end));  % ��ȡK_X�еĳ�����

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

[Xin, Xout] = mk_priorIO(X, segments); % Xin��Xout�ֱ��Ӧ�ڲ�ʿ�����е�Xin��Xout
num_Xin = size(Xin, 1); % Xin���ݵĳ���

%% ���ݵ�ǰ�����ͱ�������K_y��K_x

% ����K_y������ʹ��RBF��,�ڱ��������У������Խ�ά���̿��Ƕ�˵����
[Ky, invKy] = computeKernel(X, hyperpara_Ky); % �����K_Y��K_Y^{-1}������ʹ�õ���RBF�˼���������
Ky_RBF = Ky - eye(size(X, 1))*1/hyperpara_Ky(end); % ����GPLVM�е�computeKernel��������ĺ˲��ְ���������������������ȥ�������»ָ��ɴ�RBF��,���ں�����

% ����K_x������ʹ�õ���RBF�˼������Ժˣ������ǵ�ʵ������Ҫ��������ָĳɶ�˵���ʽ
[~, sumKern]= mk_computeCompoundKernel(kern,Xin);

% sumKern = zeros(num_Xin,num_Xin);
% for i = 1:num_kern
%     sumKern = sumKern + Kx{i};
% end
sumKern = sumKern + eye(size(Xin, 1))*1/hyperpara_Kx(end);

invKx = pdinv(sumKern);

% [~, invKx, Kx_RBF] = mk_computePriorKernel(Xin, hyperpara_Kx);  % ������µĺ���

%% ������ʧ����L�����������X��Kx�ĳ�����hyperpara_Kx��Ky�ĳ�����hyperpara_Ky���ݶȣ�������

% SECTION (1) ������ʧ����L�Գ�����hyperpara_Ky���ݶ� (����鹫ʽ)

% ���� dL / dKy
dL_dKy = -D/2*invKy + .5*invKy*invKy; % (!) Y*Y' is removed

% ������mkģ����û��Ϊÿ��ά�����һ��Ȩ�أ��������ﲻ����w
% Yscaled = Y;
% for d=1:D
%     Yscaled(:,d) = w(d)*Y(:,d); % ��ÿһ��ά�ȵ�Y����һ��Ȩ�أ�Ҳ����w(d),�����ǵ�ģ������û���õ�
% end
% dL_dK = -D/2*invKy + .5*invKy*(Yscaled*Yscaled')*invKy; % ����͹�ʽ�Ƕ�Ӧ���ϵ�

% ���� dKy / d hyperpara_Ky 
[dK{1}, dK{2}] = kernelDiffParams(X, X, hyperpara_Ky, Ky_RBF); % hyperpara_Ky�а���3��������������ͷ������RBF�˵ĳ���������������������ĳ�����������ֿ�����

% ������ʽ�����L��hyperpara_Ky���ݶ������
dk = zeros(1, 3); % Ӧ����K_Y�г������ĵ�������Ϊ������3��,��Ҫ�ر�˵��һ�µľ��� dk(1)��Ӧ����beta2���ݶȣ�dk(2)��Ӧ����beta1�ݶ�
for i = 1:2
    dk(i) = sum(sum(dL_dKy.*dK{i})); % �����е��ݶȼ�����
end
dk(3) = -sum(diag(dL_dKy)/hyperpara_Ky(end).^2); % �������Ǿ���ļ���������ֵ��ݶ�

% Ϊ�˷�ֹoverfit
grad_Ky_HyperParam = dk.*hyperpara_Ky - recConst; % ��ÿһ����������һ��Ȩ��������ڹ�ʽ�г��Գ������Ĵ���ʽ������ѳ������˵�ǰ����ݶ��У��������Խ���ݶ�Խ���Ч��

% SECTION (2) ������ʧ����L�Գ�����hyperpara_Kx���ݶ� (����鹫ʽ)

% ���� dL / dKx
dL_dKx = -Q/2*invKx + 0.5*invKx*(Xout*Xout')*invKx; % -Q/2*K_x^{-1} + 0.5*K_x^{-1}*X*X^T*K_x^{-1}
dL_dKx = lambda*dL_dKx; % lambda���趨Ϊ1,���ڵ�������ѧģ�����Ż��е�Ȩ��

% % ���� dKy / d hyperpara_Ky 
% dk = zeros(1, num_hyperpara_Kx);  % ��ʼ�����󳬲������ݶȣ�����dk�м�Ӧ����4������
% [dK{1}] = lin_kernelDiffParams(Xin, hyperpara_Kx(1)); % �����Ժ˵Ĳ�����
% [dK{2}, dK{3}] = kernelDiffParams(Xin, Xin, hyperpara_Kx(2:3), Kx_RBF); % ��RBF�˵Ĳ�����
% 
% % ������ʽ�����L��hyperpara_Kx���ݶ������
% for i = 1:(num_hyperpara_Kx-1)
%     dk(i) = sum(sum(dL_dKx.*dK{i})); % dL_dK_x * dK_x/d\lambda
% end
% dk(num_hyperpara_Kx) = -sum(diag(dL_dKx)/hyperpara_Kx(end).^2); % ��������ݶ�

% ���� dKy / d hyperpara_Ky, ��������ʽ�����L��hyperpara_Kx���ݶ������
dk = mk_KernGradient(kern,Xin,dL_dKx);
dk(num_hyperpara_Kx) = -sum(diag(dL_dKx)/hyperpara_Kx(end).^2); % ��������ݶ�

% Ϊ�˷�ֹoverfit
grad_Kx_HyperParam = dk.*hyperpara_Kx - 1; % ��ÿһ����������һ��Ȩ��������ڹ�ʽ�г��Գ������Ĵ���ʽ������ѳ������˵�ǰ����ݶ��У��������Խ���ݶ�Խ���Ч��

% SECTION (3) ������ʧ����L��������X���ݶȣ������������֣��ֱ���dKy��dKx��Xout (����鹫ʽ)

% ����L��dKy���ֶ�X���ݶȣ�������ʽ���򣬼���dL / dKy * dKy / dX
dL_dx = zeros(N, Q);  % ��Ȼ������������ģ����ƫ����
for d = 1:Q
    Kpart = kernelDiffX(X, hyperpara_Ky, d, Ky_RBF); % ֱ����dK_y/dx�ĺ�����������Ҫÿһ��ά�ȵ���
    dL_dx(:, d) = 2*sum(dL_dKy.*Kpart, 2) - diag(dL_dKy).*diag(Kpart); % dL_dx = dL/dK * dK_y/dx ���������ȥ�Խ���֪��ʲô��˼,�������У�Kpart�����жԽ�Ԫ��ȫ������0����������Ҳ��û�м�ȥ�κ�ֵ
end

% ����L��dKx���ֶ�Xin���ݶȣ�������ʽ���򣬼���dL / dKx * dKx / dxin (ά��N-1),�����޸���
dL_dxin = zeros(num_Xin, Q); % ��ʧ������Xin��
% for d = 1:Q % ÿһ��ά�Ƚ��м���
% 	Kpart = lin_kernelDiffX(Xin, hyperpara_Kx(1), d) + kernelDiffX(Xin, hyperpara_Kx(2:3), d, Kx_RBF); % dK_X/d_xin
%     dL_dxin(:, d) = 2*sum(dL_dKx.*Kpart, 2) - diag(dL_dKx).*diag(Kpart); % dK_X/d_xin
% end

gX = mk_KernGradX(kern,Xin);

for d = 1:Q % ÿһ��ά�Ƚ��м���
    gX_temp(:,:) = gX(:,d,:);
    dL_dxin(:, d) = 2*sum(dL_dKx.*gX_temp', 2);
end

% ����L��Xout���ֶ�X���ݶȣ�dL / dXout = 1/2 (Kx^{-1}*Xout + Kx^{-T}*Xout),Ȼ����ά�Ȱ�
% dL/dXout + dL/dXin �ϲ���һ���γ�һ������ΪNά���ݶ�������dL / dXout = -lambda*invKx*Xout
dLp_dx = mk_priorDiffX(dL_dxin, -lambda*invKx*Xout, N, Q, segments); % �򵥵�˵������һ�����飬���ǰ� dLp_dxin + dLp_dxout���ӵ�ʱ���ն�Ӧ��λ�ã������dLp_dxout�趨Ϊ-lambda*invKp*Xout

dLp_dx(segments,:) = dLp_dx(segments,:) - lambda*X(segments,:); % dLp_dx{1} = dLp_dx{1}��ȥ��ʼ��X��t=1λ�õ�ֵ�������������岻���

%
dL_dx = dL_dx + dLp_dx; % dK_Y/d_xin + dK_X/d_xin

gX= dL_dx(:)';

%% �������е��ݶȻ��ܵ�һ��
g = -[gX(:)' grad_Ky_HyperParam grad_Kx_HyperParam]; % g�м�����˶��������󵼵���ֵ�������������������ֵ���