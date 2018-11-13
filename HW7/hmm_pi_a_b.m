%% problem set 7, 5.22-c
%clear,clc,close all
%load('gama_xi_500.mat')
%load('y_z_500.mat')
function [pi,a,b]=hmm_pi_a_b(xi,gama,y)
time_len=size(xi,1);
state=[0,1,2];
obs_state=[0,1,2];
pi=zeros(1,3);
for ii=1:size(state,2)
    pi(ii)=gama(1,ii);
end
a=zeros(size(state,2),size(state,2));
for ii=1:size(state,2)
    for jj=1:size(state,2)
        sum_xi=sum(xi(:,ii,jj));
        sum_gama=sum(gama(:,ii));
        a(ii,jj)=sum_xi/sum_gama;
    end
end
b=zeros(size(state,2),size(obs_state,2));
for ii=1:size(state,2)
    for ll=1:size(obs_state,2)
        sum_gama=0;
        for tt=1:time_len
            if y(tt)==obs_state(ll)
                sum_gama=sum_gama+gama(tt,ii);
            end
        end
        b(ii,ll)=sum_gama/sum(gama(:,ii));
    end
end
savefile=['pi_a_b_',num2str(time_len)];
save(savefile,'pi','a','b'); 

