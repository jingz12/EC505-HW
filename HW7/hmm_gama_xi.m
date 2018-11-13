%% problem set 7, 5.22-b
%% forward and backward
%% pi
%clear,clc,close all
function [gama,xi]=hmm_gama_xi(y,z)
c=1/(1/8+1+1/32);
pi=[c/8,c,c/32];
state=[0,1,2];
obs_state=[0,1,2];
%% a
a=[1/4,1/4,1/2;1/2,1/4,1/4;1/4,1/4,1/2];
%% b
c1=1/(1+1/2+1/16);
c2=1/(1+1/2+1/2);
b=[c1.*[1,1/2,1/16];c2.*[1/2,1,1/2];c1.*[1/16,1/2,1]];
%load('y_z_500.mat')
time_len=size(y,1);
%% alpha
alpha=zeros(time_len,size(state,2));
alpha(1,:)=pi;
for tt=2:time_len
    for state_now=1:size(state,2)
        for state_before=1:size(state,2)
            alpha(tt,state_now)=alpha(tt,state_now)+...
                alpha(tt-1,state_before)*a(state_before,state_now)*b(state_now,find(obs_state==y(tt)));
        end
    end
end
%%figure,plot(alpha,'DisplayName','alpha')
%% beta
beta=zeros(time_len,size(state,2));
beta(time_len,:)=ones(1,3);
for tt=time_len-1:-1:1
    for state_now=1:size(state,2)%% i at p.164 of bh
        for state_after=1:size(state,2)%% j at p.164 of bh
            beta(tt,state_now)=beta(tt,state_now)+...
                beta(tt+1,state_after)*a(state_now,state_after)*b(state_after,find(obs_state==y(tt+1)));
        end
    end
end
%%figure,plot(beta,'DisplayName','beta')
%% gama
gama=zeros(time_len,size(state,2));
for tt=1:time_len
    for state_now=1:size(state,2)
        sum=0;
        for state_loop=1:size(state,2)
            sum=sum+alpha(tt,state_loop)*beta(tt,state_loop);
        end
        gama(tt,state_now)=alpha(tt,state_now)*beta(tt,state_now)/sum;
    end
end
figure,plot(gama,'DisplayName','gama')
%% xi
xi=zeros(time_len,size(state,2),size(state,2));
for tt=1:time_len-1
    for state_1=1:size(state,2)%% i
        for state_2=1:size(state,2)%% j
            xi(tt,state_1,state_2)=gama(tt,state_1)*a(state_1,state_2)*b(state_2,find(obs_state==y(tt+1)))*...
                beta(tt+1,state_2)/beta(tt,state_1);
        end
    end
end
figure,plot(xi(:,:,1),'DisplayName','xi(:,:,1)')
figure,plot(xi(:,:,2),'DisplayName','xi(:,:,2)')
figure,plot(xi(:,:,3),'DisplayName','xi(:,:,3)')
savefile=['gama_xi_',num2str(time_len)];
save(savefile,'gama','xi');            
            

    
    