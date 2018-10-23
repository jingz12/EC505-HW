%% cauchy noise
meanvector=0:0.5:4;%noisevector=0:0.2:2;
Gamma=-1:0.2:3;
pd=zeros(size(Gamma,2),size(meanvector,2));%pd=zeros(size(Gamma,2),size(noisevector,2));
pf=zeros(size(Gamma,2),size(meanvector,2));%pf=zeros(size(Gamma,2),size(noisevector,2));%
for jj=1:size(meanvector,2)%size(noisevector,2)%
    mean=meanvector(jj);%noise=noisevector(jj);%
    y0=randn(5000,1);
    noise=randcau(5000,1,1);
    y1=mean+noise.*randn(5000,1);
    %% problem B
    % y0=randn(5000,1);
    % y1=2.*randn(5000,1);
    Gamma=-1:0.2:3;

    for ii=1
        detfunname=['det',num2str(ii)];
        [pd(:,jj),pf(:,jj)] = roc(detfunname,Gamma,y0,y1);
    %     scatter(pf(:,ii),pd(:,ii))
    %     xlabel('pf'),ylabel('pd'),title([detfunname,'-','ROC-','ProblemA'])
    %     ylim([0 1]),xlim([0 1])
    %     print(gcf,'-dpng',[detfunname,'-','ROC','-ProblemA'])

    end
end
for ii=1:size(meanvector,2)%size(noisevector,2)%
    scatter(pf(:,ii),pd(:,ii));hold on
end
%legend('det1-roc','det2-roc','det3-roc','det4-roc','Location','southeast')
legend('mean=0','mean=0.5','mean=1','mean=1.5','mean=2','mean=2.5','mean=3','mean=3.5','mean=4','Location','southeast')
%legend('noise=0','noise=0.2','noise=0.4','noise=0.6','noise=0.8','noise=1','noise=1.2','noise=1.4','noise=1.6','noise=1.8','noise=2','Location','southeast')
xlabel('pf'),ylabel('pd'),title(['all det-','ROC-','ProblemA-cauchy-noise'])
%plot(pf(10,5),pd(10,5),'r*')
%plot(pf(10,6),pd(10,6),'r*')
plot(pf(10,7),pd(10,7),'r*')
print(gcf,'-dpng',['all det-','ROC-','ProblemA-cauchy-noise'])

function [pd,pf] = roc(detfunname,Gamma,y0,y1)
eval(['D0 = ',detfunname,'(y0,Gamma);'])
eval(['D1 = ',detfunname,'(y1,Gamma);'])
pf = sum(D0)/length(y0);
pd = sum(D1)/length(y1);
end

