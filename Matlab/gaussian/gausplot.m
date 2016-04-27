function gausplot(M,V)
% plots Gaussian curve depending on mean M and variance V

x = random('Normal', M, sqrt(V), 1, 100); % mean = M, standard deviation = sqrt(V)
histfit(x);

end