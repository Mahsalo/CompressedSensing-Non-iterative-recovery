clear
clc
close all

q1=37;%%%our method
%q2=89;%%%rip-1
%q3=37;%%%rip2
alfa=20;%% controls the magnitude of the noise

E=6;%%support of the error vector

k=6;
minTime = Inf;
r=3;
n=20000;
num=100;%%%number of unknown vectors we want to test

B1 = DeVore_Exp(q1 , n);%%%our method
%B2 = DeVore_Exp(q2 , n);%%%rip-1
%B3 = DeVore_Exp(q3 , n);%%%rip-2

error1=zeros(num,1);%%%our method
%error2=zeros(num,1);%%%rip-1
%error3=zeros(num,1);%%%rip2

t1=zeros(num,1);%%%time elapsed,our method
%t2=zeros(num,1);%%%rip-1
%t3=zeros(num,1);%%%rip2

%X=zeros(n,num);%%%unknown vector%%%comment since I'm using "our" workspace

%%%predicted vectors

Xhat1=zeros(n,num);%%%our method
%Xhat2=zeros(n,num);%%%rip-1
%Xhat3=zeros(n,num);%%%rip-2
Z=zeros(n,num);%%%rip-2


 for it=1:num
it
% %%generating an unknown signal
loc = randi(n,k,1);
xval = 2*rand(k,1) - ones(k,1);
%%generating N random numbers in (a,b) interval by using a+(b-a).*rand(N,1)
%%a=0,b=100,k different values are required
%xval=100.*rand(k,1);

x = 0*ones(n,1) ;
x(loc) = xval;
X(:,it)=x;

maxx=max(abs(x));%%%get the maximium value of the vector for generating big noise

%%%our method
B1 = DeVore_Exp(q1 , n);
y1 = Exp_mult(B1,x); 
%%we can add big and small noise
%[y1_noisy,eta]=add_noise(y1,E);%%%%small noise
[y1_noisy,eta]=add_big_noise(y1,E,alfa);%%%give this function the maximum value of our vectors for the noise bound

tstart = tic; 
xhat1=MVID_noisy(y1_noisy , q1 , n,  B1 ,k,r,eta);

Xhat1(:,it)=xhat1;
t1(it) = toc(tstart);
error1(it)=norm(x-xhat1);
if it==num
    figure(1);
    stem(x)
    hold on
    stem(xhat1)
    title('Real signal vs. signal predicted by OUR expander recovery algorithm')
    xlabel('Discrete time')
    ylabel('Signal')
    legend('Real signal','Predicted signal')
    figure(2);
    stem(error1)
    title('Error of prediction, OUR expander recovery algorithm')
    xlabel('Discrete time')
    ylabel('Error (signal-predicted signal)')
end
 end
   mean(t1)
   mean(error1)

%% Xu-Hassibi method

% for it=1:num
% 
% B2 = DeVore_Exp(q2 , n);
% x=X(:,it);
% y2 = Exp_mult(B2,x); 
% [y2_noisy,eta]=add_big_noise(y2,E,maxx);

% tstart2 = tic; 
% xhat2 = Xu_Has( y2_noisy , q2 , n,  B2 );%%%%Xu_hassibi algorithm written by Prof.
% 
% Xhat2(:,it)=xhat2;
% t2(it) = toc(tstart2);
% error2(it)=norm(x-xhat2);
% it
% if it==num
%     figure(3);
%     stem(x)
%     hold on
%     stem(xhat2)
%     title('Real signal vs. signal predicted by expander recovery algorithm')
%     xlabel('Discrete time')
%     ylabel('Signal')
%     legend('Real signal','Predicted signal')
%     figure(4);
%     stem(error2)
%     title('Error of prediction, expander recovery algorithm')
%     xlabel('Discrete time')
%     ylabel('Error (signal-predicted signal)')
% end
% end


%% L-1 norm minimization
% 
% for it=1:num
%     
% it
% 
% %%%ell-one-norm minimization
% B3 = DeVore_Exp(q3 , n ) ;
% A_D = B_to_A(B3) ;
% %%Set up the measurement vector
% x=X(:,it);
% 
% y3 = Exp_mult(B3,x) ;
% 
% [y3_noisy,eta]=add_big_noise(y3,E,alfa);
% 
% tstart3 = tic; 
% cvx_begin
% warning('off')
% variable z(n)
% minimize norm(z,1)
% subject to
% norm((A_D*z-y3_noisy),2) <= alfa*sqrt(E) 
% cvx_end
% t3(it) = toc(tstart3);
% Z(:,it)=z;
% 
% error3(it)=norm(x-z);
% if it==num
%     figure(5);
%     stem(x)
%     hold on
%     stem(z)
%     title('Real signal vs. signal predicted by ell-1 norm minimization')
%     xlabel('Discrete time')
%     ylabel('Signal')
%     legend('Real signal','Predicted signal')
%     figure(6);
%     stem(error3)
%     title('Error of prediction, ell-1 norm minimization')
%     xlabel('Discrete time')
%     ylabel('Error (signal-predicted signal)')
% end
% end
% 
% NAN=isnan(error3);
% notnan=(num-sum(NAN))*100/num%%%number of non-NAN values recovered 
% [h1,h2]=find(NAN==0);%%%find the non-NAN indices
% flag=0; %%%if flag=1 it means that all the values (all num vectors) are NAN
% if length(h1)~=0
% mean_val=mean(error3(h1))%%%mean value of the non-NANs
% else
%     flag=1;
% end
% 
% 

