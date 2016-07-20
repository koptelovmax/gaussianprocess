function Plot2DSystem(P,options)

[mu,Sigma] = nat2mv(P.eta1new, P.eta2new);

% Ground truth
%                x1      x2
%        x1  0.9306   0.321
%        x2  -0.321  0.6096
A = [0.9306   0.321;  -0.321  0.6096];
        

type = 'DoNotPlotMean';
switch type
    case 'PlotMean'
        m = options.gpf.meanfun(P.Z);
        subplot(121)
        plot3(P.Z(:,1), P.Z(:,2), m(:,1) + mu(:,1), 'bo')
        grid on; rotate3d on
        subplot(122)
        plot3(P.Z(:,1), P.Z(:,2), m(:,2) + mu(:,2), 'bo')
        grid on; rotate3d on
        
        xlims = get(gca,'XLim');
        ylims = get(gca,'YLim');
        [X1,X2] = meshgrid(linspace(xlims(1),xlims(2),10), linspace(ylims(1),ylims(2),10));
        subplot(121)
        hold on
        surf(X1, X2, reshape([X1(:) X2(:)] * A(1,:)', size(X1)),'FaceColor','none')
        subplot(122)
        hold on
        surf(X1, X2, reshape([X1(:) X2(:)] * A(2,:)', size(X1)),'FaceColor','none')
        
        
    case 'DoNotPlotMean'
        subplot(121)
        plot3(P.Z(:,1), P.Z(:,2), mu(:,1), 'bo')
        grid on; rotate3d on
        subplot(122)
        plot3(P.Z(:,1), P.Z(:,2), mu(:,2), 'bo')
        grid on; rotate3d on
        
        xlims = get(gca,'XLim');
        ylims = get(gca,'YLim');
        [X1,X2] = meshgrid(linspace(xlims(1),xlims(2),10), linspace(ylims(1),ylims(2),10));
        m = options.gpf.meanfun([X1(:) X2(:)]);
        subplot(121)
        hold on
        mesh(X1, X2, reshape([X1(:) X2(:)] * A(1,:)' - m(:,1), size(X1)),'EdgeColor',[0 0 0])
        subplot(122)
        hold on
        mesh(X1, X2, reshape([X1(:) X2(:)] * A(2,:)' - m(:,2), size(X1)),'EdgeColor',[0 0 0])
end
% Compute error metric
pred  = options.gpf.meanfun(P.Z) + mu;
truth = P.Z * A';
disp([char(8) ', err:' num2str( sqrt( sum(sum( (pred-truth).^2 )) ) )])
%disp([pred truth pred-truth])


% Plot prediction
[mu,Sigma] = nat2mv(P.eta1new, P.eta2new);
xstar = [X1(:) X2(:)];
Kuu = options.gpf.covfun(P.theta.gp, P.Z);
L = chol(Kuu + 1e-6 * Kuu(1,1) * eye(size(Kuu)));
Kmu = options.gpf.covfun(P.theta.gp, xstar, P.Z);
A = (Kmu / L) / L';
V  = L' \ Kmu';
B = options.gpf.covfun(P.theta.gp, xstar, 'diag') - sum(V.*V, 1)';
subplot(121)
hold on
mesh(X1, X2, reshape(A * mu(:,1), size(X1)),'FaceColor','none','EdgeColor',[0 0 1])
ASA = diag(A * Sigma(1:20,1:20) * A');
mesh(X1, X2, reshape(A * mu(:,1) + 2 * sqrt(B + ASA), size(X1)),'FaceColor','none','EdgeColor',[1 0 1])
mesh(X1, X2, reshape(A * mu(:,1) - 2 * sqrt(B + ASA), size(X1)),'FaceColor','none','EdgeColor',[1 0 1])
subplot(122)
hold on
mesh(X1, X2, reshape(A * mu(:,2), size(X1)),'FaceColor','none','EdgeColor',[0 0 1])
ASA = diag(A * Sigma(21:40,21:40) * A');
mesh(X1, X2, reshape(A * mu(:,2) + 2 * sqrt(B + ASA), size(X1)),'FaceColor','none','EdgeColor',[1 0 1])
mesh(X1, X2, reshape(A * mu(:,2) - 2 * sqrt(B + ASA), size(X1)),'FaceColor','none','EdgeColor',[1 0 1])

end