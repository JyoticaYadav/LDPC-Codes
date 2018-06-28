function [rx_signal, tx_signal, No]= sig_gen(u,n, SNR_dB) 

    for i = 1:n                                     % BPSK Modulation
       if u(1,i)==0
          tx_signal(1,i) = -1;
       else
          tx_signal(1,i) = +1;
       end
    end
    
    %% Adding AWGN noise to the signal 

    Eb = 1;                                       % Signal power = 1
                                                  % Decibels to linear scale conversion
    SNR = 10^(SNR_dB/10);
                                                    % Noise Powers
    No = Eb/SNR;
                                                    % Variance of the AWGN noise is No/2   
    std_dev = sqrt(No/2);
                                                     % Standard deviation and variance of AWGN noise 
                                                     % is calculated for different values of SNR

    
    rx_signal = tx_signal+ (std_dev^2)*randn(1,n);