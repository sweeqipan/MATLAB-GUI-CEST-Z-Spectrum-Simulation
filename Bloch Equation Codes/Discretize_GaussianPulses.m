% Generate the Gaussian Pulses following the method in Sun et al. (2011) -
% Simulation & optimization of pulsed radio frequency ....

% Inputs
% n = no. of sampling points (64 intervals onwards should be fine)
% FA = flip angle (in degree) 
% Tpd = pulse duration (irradiation pulse + delay) (s)
% dc = duty cycle (0 to 1)

% Outputs
% B1 = saturation power (T)
% t = saturation intervals (s)
% AP = average power (use this to approximate continuous CEST) (T)
% AF = average field (old metric for continuous approximation - not useful
% anymore (T)
%
% exp:  
%   Discretize_GaussianPulses(64, 180, 40e-3, 0.8)
% -------------------------------------------------------------------------
% 29 June 2011
% Modified on 19 Sep 2011 
% -------------------------------------------------------------------------

function [B, t, AP, AF] = Discretize_GaussianPulses(n, FA, Tpd, dc)

    if dc > 1 || dc <= 0
        errordlg('Duty cycle input is wrong! [0 to 1, exclusive]', 'DC Error', 'modal');
        return
    end

    Tp = Tpd*dc;    % Tp = positive pulse cycle; 
    tl = 0.014;      % truncation level
    c = Tp/2/sqrt(-log(tl));

    TotalB = sum(exp(-((1:n).*Tp/n-Tp/2).^2./c^2).*(Tp/n));
    FA_rad = FA*2*pi/360;   % flip angle in radian

    B = zeros(1,n+1);
    t = [Tp/(n):Tp/(n):Tp Tpd];

    for i = 1:n
       B (i) = FA_rad/267.513e6*exp(-(i*Tp/n-Tp/2)^2/c^2)/TotalB;
    end
    B(n+1) = 0;

%     figure (100)
%     plot(t,B,'b*')
    %   The formula is taken from Zu et al. (2011) - Optimizing Pulsed-CEST
    %   AP = average power; AF = average field
    AP = sqrt(trapz(t,B.^2)/Tpd);
    AF = trapz(t,B)/Tpd;
%     title(sprintf('Equivalent B_{avg power} = %.2e T\nEquivalent B_{avg field} = %.2e T',AP,AF));
%     figure (2)
%     plot(T,B1p,'b*-')
end
