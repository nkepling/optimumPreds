%% create ar process

% TODO: how to use reflection coefficients to make preds??
% after getting this to work with synthetic data, find real world data set
modelOrder = 7;

%This just generates our AR signal on our behalf
b = fir1(1024, .5);
[d,p0] = lpc(b,modelOrder);

rng(123)
x = filter(1,d,randn(1000,1));

figure()
periodogram(x)

[r,lg] = xcorr(x,'biased');



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


%% schutr

% The input here is r the auto correlation sequence
[k3,e3] = schurrc(r);
a3 = rc2poly(k3);



% plot(w1/pi,20*log10(abs(H1)))
% xlabel("Normalized Frequency(\times \pi rad/sample")
% ylabel("Magnitude [dB]")
% title("Frequency response of AR process")





