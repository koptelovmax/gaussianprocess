function val = mykernel(x1,x2)
% return kernel matrix for the dataset X

a = 1;
l = 50;
val = a*exp(-((x1-x2)^2)/(2*l^2));
H = 0.3;
%val = abs(x1)^(2*H) + abs(x2)^(2*H) - abs(x1-x2)^(2*H);

end



