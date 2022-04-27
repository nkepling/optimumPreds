%% create ar process
A = [1 1.5 0.75];
rng(123)
x = filter(1,A,randn(1000,1));

figure()
periodogram(x)

figure()
% plot(w1/pi,20*log10(abs(H1)))
% xlabel("Normalized Frequency(\times \pi rad/sample")
% ylabel("Magnitude [dB]")
% title("Frequency response of AR process")





