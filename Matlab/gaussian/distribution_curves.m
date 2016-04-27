y1 = random('Normal', 0, 100, 100, 1);
y2 = random('Normal', 0, 100, 100, 1);
%histfit(y1);
%histfit(y2);
%plot(y1,'.');
%plot(y2,'.');
%plot(y1,y2,'.');

%hist3(y1,y2);
%data(1,:)=y1;
%data(2,:)=y2;
%xi = linspace(min(data(1,:)), max(data(1,:)), 50);
%yi = linspace(min(data(2,:)), max(data(2,:)), 50);
%hist3(data',{xi yi});


% distribution curves
mu1=mean(y1);
sg1=std(y1);
mu2=mean(y2);
sg2=std(y2);

x=linspace(mu1-4*sg1,mu1+4*sg1,100);
%%pdfx1=1/sqrt(2*pi)/sg1*exp(-(x-mu1).^2/(2*sg1^2));
%%pdfx2=1/sqrt(2*pi)/sg2*exp(-(x-mu2).^2/(2*sg2^2));
%%pdfx1x2 = pdfx1*pdfx2;
%%figure(2); hold on; %axis([-1*10^(-3) 5*10^(-3) -1*10^(-3) 5*10^(-3)]);
%%plot(pdfx2,pdfx1,'b');

pdfVals = zeros(size(y1));
pdfVals1 = zeros(size(y1));
for i=1:size(y1,1)
    for j=1:size(y2,1)
        pdfx1=1/sqrt(2*pi)/sg1*exp(-(x(i)-mu1).^2/(2*sg1^2));
        pdfx2=1/sqrt(2*pi)/sg2*exp(-(x(j)-mu2).^2/(2*sg2^2));
        pdfx1x2 = pdfx1*pdfx1;
        pdfVals(i,j) = pdfx1x2;
        pdfVals1(i,j) = pdfx1;
    end
end

figure(1); hold on;
contour(x,x, pdfVals);
contour(x,x, pdfVals1);

mm = [mu1; mu2];
ss = cov(y1,y2);
h = plot_gaussian_ellipsoid(mm,ss);

mm = [mu2; mu2];
ss = cov(y2,y2);
h = plot_gaussian_ellipsoid(mm,ss);



mu1=0;
sg1=1;
mu2=2;
sg2=4;

x=linspace(mu1-4*sg1,mu1+4*sg1,200);
pdfx1=1/sqrt(2*pi)/sg1*exp(-(x-mu1).^2/(2*sg1^2));
pdfx2=1/sqrt(2*pi)/sg2*exp(-(x-mu2).^2/(2*sg2^2));
%figure(2); hold on; axis([-1*10^(-3) 5*10^(-3) -1*10^(-3) 5*10^(-3)]);
plot(pdfx2,pdfx1,'b');



