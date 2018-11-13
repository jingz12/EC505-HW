%% test for optimizating T (number of observation)
a_true=[1/4,1/4,1/2;1/2,1/4,1/4;1/4,1/4,1/2];
a_true=reshape(a_true,1,9);
c1=1/(1+1/2+1/16);
c2=1/(1+1/2+1/2);
b_true=[c1.*[1,1/2,1/16];c2.*[1/2,1,1/2];c1.*[1/16,1/2,1]];
b_true=reshape(b_true,1,9);
a_error=zeros(10,9);
b_error=zeros(10,9);
n_test=0;
for time_len=[5:5:15,20:20:100,150:50:800]
    [y,z]=hmm_obs_state(time_len);
    [gama,xi]=hmm_gama_xi(y,z);
    [pi,a,b]=hmm_pi_a_b(xi,gama,y);
    n_test=n_test+1;
    a_error(n_test,:)=(reshape(a,1,9)-a_true)./a_true;
    b_error(n_test,:)=(reshape(b,1,9)-b_true)./b_true;
    savefile=['pi_a_b_',num2str(time_len)];
    save(savefile,'pi','a','b'); 
end
obs_len=[5:5:15,20:20:100,150:50:800];
% plot(obs_len,a_error*100),hold on
% plot(obs_len,zeros(size(obs_len,2),1))%% 0% reference
% xlabel('number of obersation'),ylabel('a-error/%')
% legend('a11','a12','a13','a21','a22','a23','a31','a32','a33','0%')
% title('a-error vs number of observation')
% print(gcf,'-dpng','a-error.png')

hold off,
plot(obs_len,b_error*100),hold on
plot(obs_len,zeros(size(obs_len,2),1))%% 0% reference
xlabel('number of obersation'),ylabel('b-error/%')
legend('b11','b12','b13','b21','b22','b23','b31','b32','b33','0%')
title('b-error vs number of observation')
print(gcf,'-dpng','b-error.png')