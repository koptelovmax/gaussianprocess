clear all; close all;
x=zeros(25,100);
for i=1:25
   x(i,:)=randn(1,100); 
end
figure(1); hold on; 
plot(x,'.');
C=corrcoef(x');
plot(C);

figure(2);
plot(x(1,:),x(2,:),'+');

figure(3);
CC = int8(abs(C*100));
I=label2rgb(CC);
imshow(I);

%x=0:0.4:10;
%y=sin(x);
%plot(x,y,'o');