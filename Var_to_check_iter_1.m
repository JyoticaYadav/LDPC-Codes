function [var_to_check_iter1]= Var_to_check_iter_1(num_var, gamma, var_conn, rx_signal, No, num_check)
    
    var_to_check_iter1 = zeros(num_var, 2*gamma);                 % Matrix to store variable to check nodes
    Eb = 1;
    vector1 = zeros(num_check,1);                          % 260*1  % This loop is for variabe node to be '0'
    for var1 = 1:num_var                                   % This loop will run from 1-260
        for var2 = 1:gamma                                  % This for loop will run till 3 because that many check nodes are connected to a single bit
            index = var_conn(var1, var2);
            vector1(index,1)= vector1(index,1)+1;
            var_to_check_iter1(var1,2*var2-1) =(1+exp(4*sqrt(Eb)*rx_signal(1,var1)/No))^-1;
        end
    end

    vector1 = zeros(num_check,1);                          % This loop will be for variable node '1'
    for var1 = 1:num_var                                   % This loop will run from 1-260
        for var2 = 1:gamma                                  % This for loop will run from 1 to 3
            index = var_conn(var1, var2);
            vector1(index,1)= vector1(index,1)+1;
            var_to_check_iter1(var1,2*var2)= 1- var_to_check_iter1(var1,2*var2-1);
        end
    end
    
end
