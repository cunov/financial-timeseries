function BIC = calculateBIC(n,p,q,var,X)
    left = (n - (p-q)) .* log( (n.*var) ./ (n-p-q) );
    middle = n * (1 + log(2*pi));
    right = (p+q) .* log(sum(X.^2 - n.*var)) ./ (p+q);
    
    BIC = left + middle + right;
end

