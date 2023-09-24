%   Inputs
%   T = [T1a T2a T1b T2b T1c T2c ... Tsat];  W = [Wa Wb Wc ...]; 
%   Conc = [M_a0 M_b0 M_c0 ...]; C = [Ca Cb Cc ...]; w - freq offset; 
%   W1 - B1 in rad/s; time = time of the corresponding B1 values

%   The simulated magnetization is arranged as below:
%   Mzt = [Mxa Mya Mza Mxb Myb Mzb Mxc Myc Mzc ...]'; The plotted z-spectrum is
%   the simulated signal of Mza at different frequency offsets.

function [Mz] = BlochEquations_nPools(T, W, Conc, C, w, W1, time,dimension) 

    % Initialization    
    n = length(W1);
    loop = T(end)/time(end);
    Mz=zeros(1,length(w));
    t = [time(1) diff(time)];
    
    npools = length(Conc);
    B = zeros(npools*3,1);
    B((1:npools).*3) =  Conc./T(1:2:end-1);
    CrusherGradient = zeros(npools*3,1);
    CrusherGradient((1:npools).*3) = ones(npools,1);
    
    for l = 1:length(w)
        % The difference between 2 & 3D is the initial magnetization. The
        % TR in 2D is long; thus, it has time to return to the initial
        % value. That is not the case for 3D acquisition which has a very
        % short TR. The saturated magnetization is used as the initial
        % magnetization of the next investigated offset.
        if(strcmp(dimension,'2D') || l == 1)
            M0 = zeros(npools*3,1);
            M0((1:npools).*3) =  Conc;
        elseif(strcmp(dimension,'3D'))
            M0 = MO_3D;
        end
        A = zeros(npools*3,npools*3,n);
        InvAB = zeros(length(B),n);
        ExpmAT= zeros(npools*3,npools*3,n);
        Once = 1;
                    
        for j = 1:loop
            for i = 1:n
                if(Once)
                    % The A matrix for each discretized segment just needs 
                    % to be calculated for one pulse cycle per frequency offset. They are the
                    % same for the subsequent cycles.
                    for k = 1:npools
                        % Constructing matrix D in Chappell (2013) MRM,
                        % 556-567. Arrangement is different  from the appendix or it is wrong in the paper.
                        A((k-1)*3+1:(k-1)*3+3,(k-1)*3+1:(k-1)*3+3,i) = ...
                            -[1/T(2*(k-1)+2) + C(k)     (W(k)-w(l))                 0                   ; ...
                              -(W(k)-w(l))              1/T(2*(k-1)+2) + C(k)     W1(i)                 ; ...
                              0                         -W1(i)                    1/T(2*(k-1)+1) + C(k)];
                        if(k~=1)
                            % Construct matrix O
                            A(sub2ind(size(A),[(k-1)*3+1 (k-1)*3+2 (k-1)*3+3],[1 2 3],ones(1,3).*i)) = ...
                               ones(1,3).*(Conc(k)/Conc(1)*C(k));
                            A(sub2ind(size(A),[1 2 3],[(k-1)*3+1 (k-1)*3+2 (k-1)*3+3],ones(1,3).*i)) = ...
                               ones(1,3).*C(k);
                        end  
                    end
                    InvAB(:,i) = A(:,:,i)\B;
                    ExpmAT(:,:,i) = expm(A(:,:,i)*t(i));
                    Mzt = ExpmAT(:,:,i)*(M0+InvAB(:,i))-InvAB(:,i);
                    M0 = Mzt;
                else
                    Mzt = ExpmAT(:,:,i)*(M0+InvAB(:,i))-InvAB(:,i);
                    M0 = Mzt;
                end
            end
            Once = 0;
            % Assuming crusher gradient is applied to kill the transverse
            % signal (x & y) after each saturation pulse.
            M0 = M0.*CrusherGradient;
        end
        Mz(l) = Mzt(3);   
        
        % Assuming the 3D method is generated following Jones (2012) MRM
        % 1579-89, where there is minimize TR between frequency offsets.
        MO_3D = Mzt;
    end
end