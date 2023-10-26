clear all
clc

%% Define Parameters
% a = water
% b = Amide
% c = MT
% d = NOE(-3.5ppm)
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


%% Simulation 2uT
% Continuous wave
B1 = 2e-6;
t = tsat;

Z = woessner_method_4_pool(par,omega,B1,t);
Znorm_ap = Z/M0a;

% Discretization pulse
discretization = 128;
Tp = 0.050;
dc = 1;
Tpd = Tp/dc;
FA = 1190;
[B1,t,AP]= Discretize_GaussianPulses(discretization,FA,Tpd,dc);

Z = woessner_method_4_pool(par,omega,B1,t);
Znorm_dp = Z/M0a;

%% Absolute difference
AD = abs(Znorm_ap - Znorm_dp);

%% Plot Results

subplot(1,3,1);
hold on
% Plot Z-spectra
plot(omega, Znorm_ap,'-k',omega, Znorm_dp,'-.r','LineWidth',2.5)
% Plot Absolute Different
plot(omega, AD,'-b','LineWidth',1.75)

xlabel('Frequency Offset (ppm)'); ylabel('M_w/M_{w0}'); ylim([0 1])
set(gca,"XDir","reverse");

RMSE = sqrt(mean((Znorm_ap-Znorm_dp).^2));
RMSE_information = string("RMSE high power" + "=" + RMSE);
text(-2,0.1, RMSE_information);
hold off

% MTRasym

ppm_half = omega(end:-1:(length(omega)+1)/2);
MTRasym_ap_hp  = Znorm_ap(1:(length(Znorm_ap)+1)/2) - Znorm_ap(end:-1:(length(Znorm_ap)+1)/2);
MTRasym_dp_hp  = Znorm_dp(1:(length(Znorm_dp)+1)/2) - Znorm_dp(end:-1:(length(Znorm_dp)+1)/2);
RMSE_MTRasym_2 = sqrt(mean((MTRasym_ap_hp - MTRasym_dp_hp).^2));

set(gca,"XDir","reverse");
hold on

clear Znorm_ap
clear Znorm_dp

%% Simulation 0.5uT
% Continuous wave
B1 = 0.5e-6;
t = tsat;
Z = woessner_method_4_pool(par,omega,B1,t);
Znorm_ap = Z/M0a;

% Discretization pulse
discretization = 128;
Tp = 0.050;
dc = 1;
Tpd = Tp/dc;
FA = 300;
[B1,t,AP]= Discretize_GaussianPulses(discretization,FA,Tpd,dc);

Z = woessner_method_4_pool(par,omega,B1,t);
Znorm_dp = Z/M0a;

%% Absolute difference
AD = abs(Znorm_ap - Znorm_dp);

%% Plot Results
% hold on
%figure(3)
subplot(1,3,2 );
hold on
plot(omega, Znorm_ap,'-k',omega, Znorm_dp,'-.r','LineWidth',2.5)
plot(omega, AD,'-b','LineWidth',1.75)
RMSE = sqrt(mean((Znorm_ap-Znorm_dp).^2));
RMSE_information = string("RMSE low power" + "=" + RMSE);
xlabel('Frequency Offset (ppm)'); ylabel('M_w/M_{w0}'); ylim([0 1])
text(-1, 0.1, RMSE_information);
legend("AP Cont. Approximation", "Discretization","Absolute Difference")

set(gca,"XDir","reverse");
hold off
%% MTRasym

subplot(1,3,3);
hold on
% high power
plot(ppm_half, MTRasym_ap_hp,'b','LineWidth',2);
plot(ppm_half, MTRasym_dp_hp,'-.r','LineWidth',2);
%pd_hp = ((MTRasym_ap_hp(1,11)-MTRasym_dp_hp(1,11))/MTRasym_dp_hp(1,11))*100;
pd_hp = ((MTRasym_ap_hp-MTRasym_dp_hp)/MTRasym_dp_hp)*100;
pd_information_hp = string("Δ% high power" + "=" + pd_hp + "%");
% text(2.5,0.01,pd_information_hp)

% low power
MTRasym_ap_lp  = Znorm_ap(1:(length(Znorm_ap)+1)/2) - Znorm_ap(end:-1:(length(Znorm_ap)+1)/2);
plot(ppm_half, MTRasym_ap_lp,'b','LineWidth',2);
MTRasym_dp_lp  = Znorm_dp(1:(length(Znorm_dp)+1)/2) - Znorm_dp(end:-1:(length(Znorm_dp)+1)/2);
plot(ppm_half, MTRasym_dp_lp,'-.c','LineWidth',2);

RMSE_MTRasym_05 = sqrt(mean((MTRasym_ap_lp-MTRasym_dp_lp).^2));
%pd_lp = ((MTRasym_ap_lp(1,11)-MTRasym_dp_lp(1,11))/MTRasym_dp_lp(1,11))*100;
pd_lp = ((MTRasym_ap_lp-MTRasym_dp_lp)/MTRasym_dp_lp)*100;
pd_information_lp = string("Δ% low power" + "=" + pd_lp + "%");
% text(2.5,0.018,pd_information_lp)

xlabel('Frequency Offset (ppm)'); ylabel('MTR_a_s_y_m');
legend("AP Cont. Approximation 2.0uT", "Discretization 2.0uT", "AP Cont. Approximation 0.5uT", "Discretization 0.5uT",'Location','NorthOutside')
set(gca,"XDir","reverse");

hold off


%% Detailed design of figure, please refer to Figure1.fig %% 




