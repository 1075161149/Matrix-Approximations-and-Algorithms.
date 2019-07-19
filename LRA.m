M = randi([0 100], 8971, 8971);
M = M - 80;
M(M < 0) = 0;
lengthsq = sum((M').^2);
total = sum(lengthsq);
scaling  = sqrt(lengthsq/total);
Y = zeros(1, 25);
for r = 1 : 25
    R = zeros(r, size(M, 1));
    for i = 1 : r
        j = 1;
        x = rand()*total;
        while (x > 0)
            x = x - lengthsq(j);
            j = j + 1;
        end
        j = j - 1;
        R(i, :) = M(j, :)/(scaling(j)*sqrt(r));
    end
    temp = R*R';
    [V,~] = eig(temp); %columns of V are eigen vectors of R*R'
    size(V);
    result = V'*R; %the rows of result are right singular vectors of R
    final = result'*result;
    approx = M*final;
    normdiff = norm(approx - M, 'fro');
    Y(r) = normdiff;
end
plot(Y);
