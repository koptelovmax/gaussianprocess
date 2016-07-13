figure(1)

%% last latent variable
% X vs lin
hold on
plot(X(:,20),'r')
plot(lin(:,20),'b')
ylim([-2 3])

% X vs rbf
hold on
plot(X(:,20),'r')
plot(rbf(:,20),'b')
ylim([-2 3])

% X vs poly
hold on
plot(X(:,20),'r')
plot(poly(:,20),'b')
ylim([-2 3])

% X vs rq
hold on
plot(X(:,20),'r')
plot(rq(:,20),'b')
ylim([-2 3])

% X vs mlp
hold on
plot(X(:,20),'r')
plot(mlp(:,20),'b')
ylim([-2 3])

% X vs mat32
hold on
plot(X(:,20),'r')
plot(mat32(:,20),'b')
ylim([-2 3])

%% first latent variable
% X vs lin
hold on
plot(X(:,1),'r')
plot(lin(:,1),'b')
ylim([12 19])

% X vs rbf
hold on
plot(X(:,1),'r')
plot(rbf(:,1),'b')
ylim([12 19])

% X vs poly
hold on
plot(X(:,1),'r')
plot(poly(:,1),'b')
ylim([12 19])

% X vs rq
hold on
plot(X(:,1),'r')
plot(rq(:,1),'b')
ylim([12 19])

% X vs mlp
hold on
plot(X(:,1),'r')
plot(mlp(:,1),'b')
ylim([12 19])

% X vs mat32
hold on
plot(X(:,1),'r')
plot(mat32(:,1),'b')
ylim([12 19])

%% middle latent variable
% X vs lin
hold on
plot(X(:,10),'r')
plot(lin(:,10),'b')
ylim([-6 -0.5])

% X vs rbf
hold on
plot(X(:,10),'r')
plot(rbf(:,10),'b')
ylim([-6 -0.5])

% X vs poly
hold on
plot(X(:,10),'r')
plot(poly(:,10),'b')
ylim([-6 -0.5])

% X vs rq
hold on
plot(X(:,10),'r')
plot(rq(:,10),'b')
ylim([-6 -0.5])

% X vs mlp
hold on
plot(X(:,10),'r')
plot(mlp(:,10),'b')
ylim([-6 -0.5])

% X vs mat32
hold on
plot(X(:,10),'r')
plot(mat32(:,10),'b')
ylim([-6 -0.5])