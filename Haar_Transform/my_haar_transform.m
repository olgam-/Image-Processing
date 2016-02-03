function H = my_haar_transform(N)

H = zeros(N,N);

H(1,1:N) = 1 / sqrt(N);

% k = 2^p = q - 1;
% k einai oi seires
for k = 1 : (N - 1)
    
    p = fix(log(k) / log(2));
    q = k - (2^p) + 1;

    for i = 0 : (N - 1)
        
        z = (i) / N;
        
        if (((q - 1) / (2 ^ p)) <= z) && (z < ((q - 0.5) / (2 ^ p)))
            H(k+1,i+1) =   (1 / sqrt(N)) * (2 ^ (p/2));
        elseif (((q - 0.5) / (2 ^ p)) <= z) && (z < (q / (2 ^ p)))
            H(k+1,i+1) = - (1 / sqrt(N)) * (2 ^ (p/2));
        end
        
    end
    
end

