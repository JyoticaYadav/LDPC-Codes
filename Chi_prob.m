function [chi_prob]= Chi_prob(var_to_check, num_var, num_check,gamma, check_to_var, var_conn, link)

    vector1 = zeros(num_check,1);
    for var1 = 1:num_var                                % This for loop is for zero bit calculation
        product = 1;
        for var2 = 1:gamma
            index = var_conn(var1, var2);
            vector1(index,1)= vector1(index,1)+1;
            product = check_to_var(index,2*vector1(index,1)-1)*product;
        end
        chi_prob(var1,1) = var_to_check(var1,1)*product;
    end
        
    vector1 = zeros(num_check,1);
    for var1 = 1:num_var
        product = 1;
        for var2 = 1:gamma
            index = var_conn(var1, var2);
            vector1(index,1)= vector1(index,1)+1;
            product = check_to_var(index,2*vector1(index,1))*product;
        end
        chi_prob(var1,2) = var_to_check(var1,2)*product;
    end
    
    for i=1:num_var
        chi_prob(i,3)=chi_prob(i,1)/(chi_prob(i,1)+chi_prob(i,2));
        chi_prob(i,4)=chi_prob(i,2)/(chi_prob(i,1)+chi_prob(i,2));
    end

end
            