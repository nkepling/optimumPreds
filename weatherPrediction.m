% Here we use optimum linear filters to predict temperature data
clear
close all
weather_data = readtable("austin_weather.csv");

dates = weather_data.Date;
temps = weather_data.TempAvgF;


% Create white noise







%% Date avetemp plot
figure
plot(dates,temps)
title("Average Daily Temperature in Austin, Texas")
xlabel("Date")
ylabel("Temperature [F]")

%% AR order estimation

figure
for k = 1:4
    subplot(2,2,k)
    plot(temps(1:end-k),temps(k+1:end),'*')
    xlabel('temps_1')
    ylabel(['temps_' int2str(k+1)])
    grid
end


[xc,lags] = xcorr(temps,50,'coeff');

figure
stem(lags(51:end),xc(51:end),'filled')
xlabel('Lag')
ylabel('ACF')
title('Sample Autocorrelation Sequence')
grid

% Plot the partial auto correlation with 95 percent confidence interval

[arcoefs,E,K] = aryule(temps,15);
pacf = -K;

figure
stem(pacf,'filled')
xlabel('Lag')
ylabel('Partial ACF')
title('Partial Autocorrelation Sequence')
xlim([1 15])

conf = sqrt(2)*erfinv(0.95)/sqrt(1000);
hold on
plot(xlim,[1 1]'*[-conf conf],'r')
hold off
grid


%% ARYule
figure
plot(10*log10(abs(fft(temps))))
modelOrder = 4;
% 
[a1,e1,k1] = aryule(temps,modelOrder); 

a = rc2poly(k1);

x_est  = filter(a, 1,temps);


%% LPC
lenTemps = length(temps);
N = floor(0.75*lenTemps);



[a,p2] = lpc(temps,modelOrder);

xh = filter(-a(2:end),1,temps);
plot(dates,temps,LineWidth=1)
hold on 
plot(dates,xh,"--",LineWidth=1)
xlabel('Date')
ylabel('Temperature [F]')
legend('Original temperature signal','Signal estimate from linear predictor')
title("Average Daily Temperature Versus One Day Forward Signal Estimate'")


prederr = norm(temps(2:end)-xh(1:end-1),2)^2/(length(temps)-1);

% est_x2 = filter([0 -a(2:end)],1,xtest);


% create 
% rng(123)
% u = sqrt(p0)*randn(length(xtest),1);
% 
% est = filter(a,1,u);
% 
% figure
% plot(dates(N+1:end),est)
% hold on 
% plot(dates(N+1:end),xtest)



%% funcs


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

