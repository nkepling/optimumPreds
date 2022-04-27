
% Mathworks LPC example

noise = randn(50000,1);
x = filter(1,[1 1/2 1/3 1/4],noise);
x = x(end-4096+1:end);

[a ,g]= lpc(x,3);
est_x = filter([0 -a(2:end)],1,x);

figure()
plot(1:100,x(end-100+1:end),1:100,est_x(end-100+1:end),'--')
grid
xlabel('Sample Number')
ylabel('Amplitude')
legend('Original signal','LPC estimate')

e = x-est_x;
[acs,lags] = xcorr(e,'coeff');


figure()
plot(lags,acs)
grid
xlabel('Lags')
ylabel('Normalized Autocorrelation')
ylim([-0.1 1.1])