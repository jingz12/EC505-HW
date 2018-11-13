%% problem set 7, 5.22
%% pi
%clear,clc,close all
function [y,z]=hmm_obs_state(time_len)
%time_len=500;
c=1/(1/8+1+1/32);
pi=[c/8,c,c/32];
pi_cdf=[pi(1),pi(1)+pi(2),pi(1)+pi(2)+pi(3)];
pi=[0,pi_cdf];
state=[0,1,2];
obs_state=[0,1,2];
%% a
a=[1/4,1/4,1/2;1/2,1/4,1/4;1/4,1/4,1/2];
a_cdf=[a(:,1),a(:,1)+a(:,2),a(:,1)+a(:,2)+a(:,3)];
a=[zeros(size(state,2),1),a_cdf];
%% b
c1=1/(1+1/2+1/16);
c2=1/(1+1/2+1/2);
b=[c1.*[1,1/2,1/16];c2.*[1/2,1,1/2];c1.*[1/16,1/2,1]];
b_cdf=[b(:,1),b(:,1)+b(:,2),b(:,1)+b(:,2)+b(:,3)];
b=[zeros(size(state,2),1),b_cdf];
%% initialization
z=zeros(time_len,1);y=z;
%% z(1)
for ii=1:size(state,2)
    temp=rand;
    if(temp<=pi(ii+1)&&temp>=pi(ii))
        z(1)=state(ii);
    end
end
%% y(1)
state_now=find(state==z(1));
for jj=1:size(obs_state,2)
    temp=rand;
    if(temp<=a(state_now,ii+1)&&temp>=a(state_now,ii))
        y(1)=obs_state(jj);
    end
end

for tt=2:size(z)
    state_before=find(state==z(tt-1));
    for ii=1:size(state,2)
        temp=rand;
        if(temp<=a(state_before,ii+1)&&temp>=a(state_before,ii))
            z(tt)=state(ii);
        end
    end
    state_now=find(state==z(tt));
    for jj=1:size(obs_state,2)
        temp=rand;
        if(temp<=a(state_now,ii+1)&&temp>=a(state_now,ii))
            y(tt)=obs_state(jj);
        end
    end
end
scatter([1:size(y,1)],y,'r')
hold on,scatter([1:size(z,1)],z,'b')
savefile=['y_z_',num2str(time_len)];
save(savefile,'y','z');

        
    
