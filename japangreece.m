close all
clear all
clc

f = fred
startdate = '01/01/2011';
enddate = '01/01/2022';

%%
realGDPj = fetch(f,'NGDPRXDCJPA',startdate,enddate)      %Real Gross Domestic Product
%annual=NGDPRXDCJPA,season=JPNRGDPEXP
yearj = realGDPj.Data(:,1);
yj = realGDPj.Data(:,2);

% load y.mat
% year = linspace(1, 261, 261);

figure
plot(yearj, log(yj))
datetick('x', 'yyyy')
ylabel('Log of real GDP (billions of chained 2015 Yen)')
xlabel('')
grid on

%[trend, cycle] = hpfilter(log(y), 1600);
[cyclej,trendj] = qmacro_hpfilter(log(yj), 6.25);

% compute sd(y) (from detrended series)
ysdj = std(cyclej)*100;

disp(['Percent standard deviation of detrended log real GDP: ', num2str(ysdj),'.']); disp(' ')

figure
subplot(2,1,1);
plot(yearj, trendj,'b')
datetick('x', 'yyyy')
xlabel('Time')
title('Trend components')
grid on

subplot(2,1,2);
plot(yearj, cyclej,'r')
datetick('x', 'yyyy')
xlabel('Time')
title('Cyclical components')
grid on;

%%
realGDP = fetch(f,'NGDPRXDCCNA',startdate,enddate)      %Real Gross Domestic Product
% grc=CLVMNACSCAB1GQEL1995,arg=NGDPRSAXDCARQ2004,chi=NGDPRXDCCNA2011
year = realGDP.Data(:,1);
y = realGDP.Data(:,2);

% load y.mat
% year = linspace(1, 261, 261);

figure
plot(year, log(y))
datetick('x', 'yyyy')
ylabel('Log of real GDP (Domestic currency)')
xlabel('')
grid on

%[trend, cycle] = hpfilter(log(y), 1600);
[cycle,trend] = qmacro_hpfilter(log(y), 6.25);

% compute sd(y) (from detrended series)
ysd = std(cycle)*100;

disp(['Percent standard deviation of detrended log real GDP: ', num2str(ysd),'.']); disp(' ')

figure
subplot(2,1,1);
plot(year, trend,'b')
datetick('x', 'yyyy')
xlabel('Time')
title('Trend components')
grid on

subplot(2,1,2);
plot(year, cycle,'r')
datetick('x', 'yyyy')
xlabel('Time')
title('Cyclical components')
grid on;

figure
plot(yearj, cyclej,'r')
hold on
plot(year, cycle,'b')
datetick('x', 'yyyy')
xlabel('Time')
title('Cyclical components r:japan,b:greece')
grid on;

%標準偏差を計算
disp(['日本の標準偏差：',num2str(std(cyclej)*100),'中国の標準偏差：',num2str(std(cycle)*100)]);



% 相関係数を計算
corr = corrcoef(cycle, cyclej);
disp(['相関係数：',num2str(corr(1,2))]);