function newFrame = predictNewLatentFrame(X,kern,Kx_inv,X_old) 
% predict new latent X using mean prediction method
k_xx = kernCompute(kern,X(1:end-1,:),X_old);

newFrame = X(2:end,:)'*Kx_inv*k_xx;
