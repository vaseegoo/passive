%% FDA pattern

% author ： SUN_MiKo
% e-Mail :  vaseegoo@gmail.com
% @ matlab 2016b or later

%%
clear;
close all;
clc;

%%

alpha = (-80:0.5:80)*pi/180;       % 方位角
deg30 = alpha(221);

range = 0:100:20e3;                % 距离

f0 = 10e9;                         % 第一阵元载频
c = 3e8;                           % 电磁传播速度
d = c/(2*f0);                      % 阵元间距
% d = 2;

M = 12;                            % 阵元个数
dlt_f = 30e3;                      % 阵元频偏

[X,Y] = meshgrid(alpha,range);


%% t=0时刻的方向图
t = 0;                             % 时间
F = abs(sin(M*pi*(f0*d*sin(X)/c - dlt_f*Y/c + dlt_f*t)) ./ sin(pi*(f0*d*sin(X)/c - dlt_f*Y/c + dlt_f*t)) );
F = F/max(max(F));
figure('name','t=0 时的方向图')
mesh(X*180/pi,Y,10*log10(F));
xlabel('Phase(^。)')
ylabel('Range(m)')
zlabel('amplitude(dB)')
colormap(jet)

figure('Name','方位30度')
plot(range,10*log10(F(:,221)))

% figure(335)
% imagesc(alpha*180/pi,range,10*log10(F));
% colormap(jet)


%% t=2e-5时刻的方向图
t = 2e-5;
F = abs(sin(M*pi*(f0*d*sin(X)/c - dlt_f*Y/c + dlt_f*t)) ./ sin(pi*(f0*d*sin(X)/c - dlt_f*Y/c + dlt_f*t)) );
F = F/max(max(F));
% figure(2)
% mesh(Y,X*180/pi,10*log10(F));
% colormap(jet)



%% 方向图-时间

% tt = 0:1e-6:20e-6;
% Len = length(tt);
% 
% for k=1:Len
%     t = tt(k)
%     F = abs(sin(M*pi*(f0*d*sin(X)/c - dlt_f*Y/c + dlt_f*t)) ./ sin(pi*(f0*d*sin(X)/c - dlt_f*Y/c + dlt_f*t)) );
%     F = F/max(max(F));
%     figure(3)
%     mesh(Y,X,log(F));
%     colormap(jet)
%     m(k) = getframe(gca);
%     
% end
% movie(m,100);

%%  方向图--频偏
t = 2e-5;
dlt_FF = 0:10e3:300e3;
for k = 1:length(dlt_FF)
    dlt_f = dlt_FF(k)
    F = abs(sin(M*pi*(f0*d*sin(X)/c - dlt_f*Y/c + dlt_f*t)) ./ sin(pi*(f0*d*sin(X)/c - dlt_f*Y/c + dlt_f*t)) );
    F = F/max(max(F));
    figure(3)
%     mesh(X*180/pi,Y,10*log10(F));
imagesc(alpha*180/pi,range,10*log10(F))
    colormap(jet)
%     axis off
    m(k) = getframe(gca);
end
movie(m(1:10))
