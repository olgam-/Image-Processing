function [Im, partition, codebook] = grayscale_red_Lloyd(Im,N)

[m, n] = size(Im);
mn = m * n;
Delta = 256 / (N + 1);
d = zeros(N,1);
initcodebook = d;

% Initialization of initicodebook
for i = 1:N+1
    d(i)= (i-1) * Delta; 
end

for i = 1:N
    initcodebook(i) = (d(i) + d(i+1)) / 2;
end

training_set = reshape(Im,1,mn);

[partition, codebook] = lloyds(training_set,initcodebook);

Im2 = Im;

for i = 1 : N-1
    a = find(Im2 < partition(i)); 
    Im(a) = round(codebook(i)); 
    Im2(a) = 300;
end

a = Im > partition(N-1); 
Im(a) = round(codebook(N));

end
