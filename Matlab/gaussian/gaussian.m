%% Gaussian distribution
g1 = random('Normal', 0, 1, 1, 1000); % ('Normal' distribution, zero mean, standard derivation(variance), number of points, dimension)
g2 = randn(1,1000);
figure(1); histfit(g1);
figure(2); histfit(g2);

% example height, m
g3 = random('Normal', 1.7, sqrt(0.0225), 1, 1000);
figure(3); histfit(g3);
% example weight, kg
g4 = random('Normal', 75, sqrt(36), 1, 1000);
figure(4); histfit(g4);
% joint distribution
figure(5);
plot(g3,g4,'+');