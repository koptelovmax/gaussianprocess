clear all; close all;
c=randn(1,1000);
%figure(1);
%histfit(c);
Px=1;
Py=3;
x=0:0.1:3;
y=zeros(1,length(x));
figure(2); hold on; axis([0 3 0 5]);
for i=1:length(c)
    m=(Py-c(i))/Px;
    for j=1:length(x)
       y(j)=m*x(j)+c(i); 
    end
    plot(x,y);
end