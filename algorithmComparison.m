%% create ar process

% TODO: how to use reflection coefficients to make preds??
% after getting this to work with synthetic data, find real world data set
clear
close all
modelOrder = 7;

%This just generates our AR signal on our behalf
b = fir1(1024, .5);
[d,p0] = lpc(b,modelOrder);

rng(123)
u = sqrt(p0)*randn(1000,1);
x = filter(1,d,u);

figure()
periodogram(x)

r = xcorr(x,x);



%% yuelwalkerfunc



% uses levinson durbin recursion to compute params
% aryule estimates the auto corelation funtio of x

[a1,e1,k1] = aryule(x,modelOrder); 
[h1,w1] = freqz(sqrt(e1),a1); 

figure()
periodogram(x)
hold on
hp = plot(w1/pi,20*log10(2*abs(h1)/(2*pi)),'r'); %scale to onesied pds
hp.LineWidth = 2;
xlabel('Normalized frequency (\times \pi rad/sample)')
ylabel('One-sided PSD (dB/rad/sample)')
legend('PSD estimate of x','PSD of model output')



%% levisonAlgo

[a,e,k] = levinson(r,modelOrder);

[h2,w1] = freqz(sqrt(e),a);

a2 = ac2poly(a);


pred = filter(sqrt(e),a,u); 
figure()
stem(pred)
figure()
periodogram(x)
hold on
hp = plot(w1/pi,20*log10(2*abs(h2)/(2*pi)),'r'); %scale to onesied pds
hp.LineWidth = 2;
xlabel('Normalized frequency (\times \pi rad/sample)')
ylabel('One-sided PSD (dB/rad/sample)')
legend('PSD estimate of x','PSD of model output')



%% schutr

% The input here is r the auto correlation sequence
% [k3,e3] = schurrc(x);
% [a3,efinal] = rc2poly(k3,0.01);
% 
% [h3,w3] = freqz(sqrt(efinal),a3);
% 
% figure()
% periodogram(x)
% hold on
% hp = plot(w3/pi,20*log10(2*abs(h3)/(2*pi)),'r'); %scale to onesied pds
% hp.LineWidth = 2;
% xlabel('Normalized frequency (\times \pi rad/sample)')
% ylabel('One-sided PSD (dB/rad/sample)')
% legend('PSD estimate of x','PSD of model output')


% plot(w1/pi,20*log10(abs(H1)))
% xlabel("Normalized Frequency(\times \pi rad/sample")
% ylabel("Magnitude [dB]")
% title("Frequency response of AR process")


