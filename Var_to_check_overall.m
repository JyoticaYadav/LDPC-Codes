function [var_to_check_new]= Var_to_check_overall(var_conn, var_to_check_iter1, gamma, num_check, num_var, check_to_var)

    vector_inter2 = zeros(num_check,1);
    for var1 = 1:num_var                                    % This loop will run from 1-260
        vector_inter3 = var_conn(var1,:);
        for var_inter=1:gamma
            vector_inter2(vector_inter3(1,var_inter),1)= vector_inter2(vector_inter3(1,var_inter),1)+1;
        end
        for var2 = 1:gamma
            product = 1;
            vector2 = var_conn(var1,[1:var2-1 var2+1:end]);
            i=1;
            for var9 = 1:2
                product = check_to_var(vector2(1,var9), (2*vector_inter2(vector2(1,var9),1))-1)*product;
            end
%             var_to_check_new(vector_inter3(1, i),2*vector_inter2() = var_to_check(vector_inter3(1, i), 2*var2-1)*product;
            var_to_check_new(var1,2*var2-1) = var_to_check_iter1(vector_inter3(1, i), 2*var2-1)*product;
        end
    
    end

    vector1 = zeros(num_check,1);

    for var1 = 1:num_var                                    % This loop will run from 1-260
        for var2 = 1:gamma                                  % This for loop will run from 1 to 3
            index = var_conn(var1, var2);
            vector1(index,1)= vector1(index,1)+1;
            var_to_check_new(var1,2*var2)= 1- var_to_check_new(var1,2*var2-1);
        end
    end
end