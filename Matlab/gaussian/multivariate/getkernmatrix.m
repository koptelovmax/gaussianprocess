function matrix = getkernmatrix(X)
% return kernel matrix for the dataset X

k = size(X);
k = max(k(1),k(2));
matrix = zeros(k,k);
for i=1:k
    for j=1:k
        matrix(i,j)=mykernel(X(i),X(j));
    end
end

end