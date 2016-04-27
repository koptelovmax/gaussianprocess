function matrix = getkernmatrix2(X,Y)
% return kernel matrix for the dataset X

k1 = max(size(X));
k2 = max(size(Y));
matrix = zeros(k1,k2);
for i=1:k1
    for j=1:k2
        matrix(i,j)=mykernel(X(i),Y(j));
    end
end

matrix = matrix + eye(k1,k2)*0.0001;

end