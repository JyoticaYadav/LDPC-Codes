%% Decoding LDPC codes using Sum Product Algorithm

clc();
clear all;
close all;

H = xlsread('H_matrix.xlsx');                   % Loading the given H matrix in MATLAB
gamma = 3;                                      % Number of 1's in each column of Matrix H
rho = 6;                                        % Number of 1's in each row of Matrix H

                                                % Each row in the parity check matrix represents one parity check equation
                                                % Each column represents one bit in the code word

n = 260;                                        % Number of bits in the code word
k = 130;                                        % Number of information bits in the code word
SNR_dB_vector = -0.2:0.1:1.0;                   % Total 71 values of SNR

%% Transmission of an all zero code word using BPSK modulation

u = zeros(1,n);                                 % All zero code word

for BER_i= 1:13
    
    SNR_dB = SNR_dB_vector(1,BER_i);                          
    [rx_signal, tx_signal, No]= sig_gen(u,n,SNR_dB); 
                              
    % LDPC decoding
    
    num_var = n;                                        % Number of variable nodes is the number of code bits = n 
    num_check = n-k;                                    % Number of check nodes is >= (n-k)= 260-130= 130
    max_iterations = 100;
    
    % Initializations

    [var_conn, link]= initializations(H, num_var, num_check, gamma);    % Determing the connection of each variable node with check nodes: var_conn

    %% Step 1: Variable to check messages
    %for 1st iteration
    [var_to_check_iter1]= Var_to_check_iter_1(num_var, gamma, var_conn, rx_signal, No, num_check); 

    for iter=1:max_iterations
        if iter==1
            [check_to_var]= Check_to_var(num_check, rho, num_var, link, var_to_check_iter1);
        else
            [check_to_var]= Check_to_var(num_check, rho, num_var, link, var_to_check);
        end
        chi_prob = Chi_prob(var_to_check_iter1, num_var, num_check,gamma, check_to_var, var_conn, link);

        for i=1:num_var
            if chi_prob(i,3)> chi_prob(i,4)
                dec_signal(1,i) = 0;
            else
                dec_signal(1,i) = 1;
            end
        end

        err = abs(u - dec_signal);                      
        num_errors = 0;
        for i=1:n
            if err(1,i)
                num_errors = num_errors + 1;
            else
            end
        end

        BER = num_errors/n;
        
        [var_to_check] = Var_to_check_overall(var_conn, var_to_check_iter1, gamma, num_check, num_var, check_to_var);
    end
    BER_matrix(BER_i, 1)= BER;  
   
end

BER_matrix= smooth(BER_matrix);
BER_matrix = smooth(BER_matrix);
BER_matrix = log10(BER_matrix);

for i=1:13
    if BER_matrix(i,1)<-30
        BER_matrix(i,1)=-30;
    else
    end
end

graph = csapi(SNR_dB_vector, BER_matrix);           % Function for plotting using splines                
fnplt(graph,2);
grid on
xlabel('SNR in dB');
ylabel('Bit Error rate');
title('SNR vs BER performance of SPA algorithm');

