%25/5/2023
%Simulation of z-spectrum for Guassian pulsed CEST and continuous
%approximation
%close all
clear all

%Variable
dc = 1.0;
B1_RMSE = zeros(11,2);
count = 0;

%% Define Parameters
% This example uses 3 pools: a,b,c
% No of pools
n = 4;        

% Magnetic field strength in T
B0 = 3;

% Longitudinal relaxation times in s
T1a = 1.4;
T1b = 1.4;
T1c = 1.4;
T1d = 1.4;

% Transverse relaxation times in s
T2a = 100e-3;
T2b = 50e-3;
T2c = 0.02e-3;
T2d = 0.4e-3;

% Concentrations in mM
M0a = 112;
M0b = 1/1000*M0a;
M0c = 1/25*M0a;
M0d = 1/300*M0a;

% Chemical shifts in ppm
wa = 0;     
wb = 3.5;
wc = 0;
wd = -3.5;

% Exchange rates in Hz
Cb = 30;    % Ca can be calculated
Cc = 20;
Cd = 20;

% Saturation offsets in ppm
omega = -4.5:0.1:4.5;

% Saturation time in s
tsat = 2;

%parameter
par = [n, tsat, B0, wa, wb, wc,wd...
T1a, T2a, T1b, T2b, T1c, T2c, T1d, T2d...
Cb, Cc, Cd...
M0a, M0b, M0c, M0d ];

%% Brute force
figure

hold on

FA = 1190;
n = 128;
Tp = 0.050;
Tpd = Tp/dc;

[B1,t,AP]= Discretize_GaussianPulses(n,FA,Tpd,dc);
time = t;
Z_dp = woessner_method_4_pool(par,omega,B1,t);
Znorm_dp = Z_dp/M0a;
subplot(1,2,1)
p1 = plot(omega, Znorm_dp,'k','LineWidth',3,'DisplayName','Pulsed');
%set(findall(hfig,'-property','Box'),'Box','off')
hold on
set(gca,"XDir","reverse");
%Continuous approximation
B1xx = 1.5e-6 : 0.05e-6 : 2.5e-6; 

for xx = 1:length(B1xx)
    time = tsat;
    B1 = B1xx(xx);
    Z_ca = woessner_method_4_pool(par,omega,B1,tsat);
    Znorm_ca = Z_ca/M0a;
    
    RMSE = sqrt(mean((Znorm_dp-Znorm_ca).^2));
    rms_smallest = RMSE;
    B1_RMSE(xx,1) = B1xx(xx);
    Znorm_ca_smallest = Znorm_ca;
    B1_RMSE(xx,2) = RMSE;
    
    
    if xx == 8
        best_match_z = Znorm_ca_smallest;
        p2 = plot(omega, Znorm_ca_smallest,'color', 'r','LineWidth',2,'DisplayName','Best match');
    elseif xx == 11
        p3 = plot(omega, Znorm_ca_smallest,'color','b','LineWidth',2,'DisplayName','AP');
    else
        plot(omega, Znorm_ca_smallest,'color', [.5 .5 .5 .6]);
        %text(omega(end)+1.5, Znorm_ca_smallest(end),string(B1), 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle');
        legend ('off')
    end
    
end

%% RMSE vs B1
subplot(1,2,2)
plot(B1_RMSE(:,1)*10e5,B1_RMSE(:,2),'k','LineWidth',2.5')
xlabel('B_1 Power(µT)')
ylabel('RMSE')
hold on
h2 = plot(2,0.04061,'x','LineWidth', 3,'DisplayName', 'AP');
legend(h2)

%% Detailed design of figure, please refer to Figure2.fig %% 




