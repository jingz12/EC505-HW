%%
clear;clc;close all
N=100;
qn=1;
v=sqrt(qn)*rand(100,1);
b=[1,0];a=[1,-1];
x=filter(b,a,v);
figure
plot(x,'o')
title('sample paths of the noise free Brownian motion')
xlabel('N'),ylabel('x')
print(gcf,'-dpng','-r500','sample paths of the noise free Brownian motion')
%% Observation
rn=4;
w=sqrt(rn)*randn(N,1);
cn=[ones(20,1);zeros(30,1);ones(50,1)];
y=cn.*x+w;
figure
plot(1:100,x,'bo',[1:20,51:100],y([1:20,51:100]),'g+',21:50,y(21:50),'r+')
legend('x','y-contain info','y-not contain info')
title('noise free Brownian motion process x and noisy data y')
xlabel('N'),ylabel('data')
print(gcf,'-dpng','-r500','noise free Brownian motion process x and noisy data y')
%% MAP Model Identification
C=diag(cn);
R=rn*eye(N);
D=diag(-1*ones(N-1,1),-1)+diag(ones(N,1));
Qv=qn*eye(N);
Q=inv(D'*inv(Qv)*D);
figure
mesh(Q)
title('covariance Q')
xlabel('N'),ylabel('N')
print(gcf,'-dpng','-r500','covariance Q')
%% MAP Estimation
xmap1=inv(C'*inv(R)*C+inv(Q))*C'*inv(R)*y;
xmap2=Q*C'*inv(C*Q*C'+R)*y;
figure
plot(1:100,x,'bo',[1:20,51:100],y([1:20,51:100]),'g+',21:50,y(21:50),'r+')
hold on 
plot([1:20,51:100],xmap1([1:20,51:100]),'g*',[21:50],xmap1(21:50),'r*')
xlabel('N'),ylabel('data')
legend('x','y-contain info','y-not contain info','xmap-contain info','xmap-not contain info')
title('noise free Brownian motion process x, noisy data y and MAP estimate xmap')
print(gcf,'-dpng','-r500','MAP Estimation-x-y-xmap')
%% MAP Covariance
err=inv(C'*inv(R)*C+inv(Q));
errstd=sqrt(diag(err,0));
upper=xmap1+errstd;lower=xmap1-errstd;
figure
plot(1:100,x,[1:20,51:100],upper([1:20,51:100]),'g.',[21:50],upper(21:50),'r.')
hold on
plot([1:20,51:100],lower([1:20,51:100]),'g.',[21:50],lower(21:50),'r.')
xlabel('N'),ylabel('data')
legend('x','xmap+errstd-contain info','xmap+errstd-not contain info','xmap-errstd-contain info','xmap-errstd-not contain info')
title('MAP Estimation Covariance')
print(gcf,'-dpng','-r500','MAP Estimation Covariance')


