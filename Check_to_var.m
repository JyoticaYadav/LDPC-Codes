function [check_to_var]= Check_to_var(num_check, rho, num_var, link, var_to_check) 
    
    perm_bin = dec2bin(0:1:2^5-1)-'0';                 % Generated all permutations of 5 binary bits
    [x, y]= size(perm_bin);                            % Order of the matrix 
    for i=1:x
        sum = 0;                                       % Sum of each row of permutations matrix
        for j=1:y
            sum = perm_bin(i,j)+sum;
        end
        total_ones(i,1)=sum;
    end

    e=1;   f=1;
    for i = 1:32
        if rem(total_ones(i,1),2) == 0                   % Permutations having even number of 1's
           even_perm(e,:) = perm_bin(i,:);
           e = e + 1;
        else
           odd_perm(f,:) = perm_bin(i,:);               % Permutations having odd number of 1's
           f = f + 1;
        end
    end

    check_to_var = zeros(num_check,2*rho);                      % check_to_var = 130*12 matrix
    vector_inter = zeros(num_var,1);                            % vector_inter = 260*1

    for var1 = 1: num_check
        vector1 = link(var1,:);                                % Row of link matrix extracted
        var5 = 1;
        for var_inter=1:rho
            vector_inter(vector1(1,var_inter)+1,1)= vector_inter(vector1(1,var_inter)+1,1)+1;
        end 
        for var2 = 1 : rho
            sum = 0;
            vector2 = link(var1,[1:var2-1 var2+1:end]);           % Combinations of all the links
            for var3 = 1:16
               vector3 = times(vector2, even_perm(var3,:));         % var 1 role === row_variable
               product = 1;
               for var4 = 1:5
                   if vector3(1, var4) == 0
                      row_variable = vector2(1,var4)+1;
                      product = var_to_check(row_variable, (2*vector_inter(row_variable,1))-1)*product;
                   else
                      row_variable = vector2(1,var4)+1;
                      product = var_to_check(row_variable, 2*vector_inter(row_variable,1))*product;
                   end
               end
               sum = sum + product;
            end
            check_to_var(var1, var5)=sum;
            var5 = var5 + 2;
        end
    end

    for var1= 1: num_check
        for var2= 1:2:11
            check_to_var(var1,var2+1) = 1- check_to_var(var1, var2);
        end
    end
    
end
