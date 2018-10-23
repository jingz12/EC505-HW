clear;clc;close all
%% problem A
y0=randn(5000,1);
y1=2+randn(5000,1);
%% problem B
% y0=randn(5000,1);
% y1=2.*randn(5000,1);
Gamma=-1:0.2:3;
pd=zeros(size(Gamma,2),4);
pf=zeros(size(Gamma,2),4);
for ii=1:4
    detfunname=['det',num2str(ii)];
    [pd(:,ii),pf(:,ii)] = roc(detfunname,Gamma,y0,y1);
    scatter(pf(:,ii),pd(:,ii))
    xlabel('pf'),ylabel('pd'),title([detfunname,'-','ROC-','ProblemA'])
    ylim([0 1]),xlim([0 1])
    print(gcf,'-dpng',[detfunname,'-','ROC','-ProblemA'])
end
for ii=1:4
    scatter(pf(:,ii),pd(:,ii));hold on
end
legend('det1-roc','det2-roc','det3-roc','det4-roc','Location','southeast')
xlabel('pf'),ylabel('pd'),title(['all det-','ROC-','ProblemA'])
print(gcf,'-dpng',['all det-','ROC-','ProblemA'])

function [pd,pf] = roc(detfunname,Gamma,y0,y1)
eval(['D0 = ',detfunname,'(y0,Gamma);'])
eval(['D1 = ',detfunname,'(y1,Gamma);'])
pf = sum(D0)/length(y0);
pd = sum(D1)/length(y1);
end


