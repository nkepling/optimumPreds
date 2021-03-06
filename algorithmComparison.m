%% create ar process

% TODO: how to use reflection coefficients to make preds??
% after getting this to work with synthetic data, find real world data set
clear
close all
modelOrder = 7;

%This just generates our AR signal on our behalf
b = fir1(1024, [0.35 0.65]);
[d,p0] = lpc(b,modelOrder);

rng(123)
u = sqrt(p0)*randn(1000,1);
x = filter(1,d,u);

% figure()
% periodogram(x)

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
title("PSD Estimate of True AR signal vs PSD of Model Output")
pxx = periodogram(x);
est = 20*log10(2*abs(h1)/(2*pi));
mse = norm(pxx(2:end)-est,2)^2/(length(pxx)-1);

% hold off 
% figure()
% 
% 
% [h2,w2] = freqz(e1,a1,"whole");
% 
% plot(w2/pi,20*log10(abs(h2)))
% hold on
% plot(20*log10(abs(Y)))
% 
% xlabel('Normalized Frequency (\times\pi rad/sample)')
% ylabel('Magnitude (dB)')
% 
% Y = fft(x);



%% levisonAlgo
% 
% [a,e,k] = levinson(r,modelOrder);
% 
% [h2,w1] = freqz(sqrt(e),a);
% 
% a2 = ac2poly(a);
% 
% 
% pred = filter(sqrt(e),a,u); 
% figure()
% stem(pred)
% figure()
% periodogram(x)
% hold on
% hp = plot(w1/pi,20*log10(2*abs(h2)/(2*pi)),'r'); %scale to onesied pds
% hp.LineWidth = 2;
% xlabel('Normalized frequency (\times \pi rad/sample)')
% ylabel('One-sided PSD (dB/rad/sample)')
% legend('PSD estimate of x','PSD of model output')



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

function fqs = freqgen(fftsz,Ts) 
    % this function is taken from the FFT Handbook Slides
    N = fix((fftsz-1)/2)+1; %Num points fft
    sN = -1*fix((fftsz)/2);

    fqs = zeros(1,fftsz);
    
    p1 = [0:N-1];
    p2 = [sN:-1];
    fqs(1:N) = p1;
    fqs(N+1:end)=p2;

    fqs = fqs/(fftsz*Ts);
end


