function s=SL0(A, x, sigma_min, sigma_decrease_factor, mu_0, L, A_pinv, true_s)
% SL0(A, x, sigma_min, sigma_decrease_factor, mu_0, L, A_pinv, true_s)
    if nargin < 4
        sigma_decrease_factor = 0.5;
        A_pinv = pinv(A);
        mu_0 = 2;
        L = 3;
        ShowProgress = logical(0);
    elseif nargin == 4
        A_pinv = pinv(A);
        mu_0 = 2;
        L = 3;
        ShowProgress = logical(0);
    elseif nargin == 5
        A_pinv = pinv(A);
        L = 3;
        ShowProgress = logical(0);
    elseif nargin == 6
        A_pinv = pinv(A);
        ShowProgress = logical(0);
    elseif nargin == 7
        ShowProgress = logical(0);
    elseif nargin == 8
        ShowProgress = logical(1);
    else
        error('Error in calling SL0 function');
    end
    s = A_pinv*x;                                                                                                                 % Initialization
    sigma = 2*max(abs(s));      
    while sigma > sigma_min                                                                                                       % Main Loop
        for i = 1 : L
            delta = OurDelta(s,sigma);
            s = s - mu_0*delta;
            s = s - A_pinv*(A*s-x);                                                                                               % Projection
        end
        if ShowProgress
            fprintf('sigma=%f, SNR=%f\n',sigma,estimate_SNR(s,true_s))
        end
        sigma = sigma * sigma_decrease_factor;
    end
end
    
function delta = OurDelta(s,sigma)
    delta = s.*exp(-abs(s).^2/sigma^2);
end

function SNR = estimate_SNR(estim_s,true_s)
    err = true_s - estim_s;
    SNR = 10*log10(sum(abs(true_s).^2)/sum(abs(err).^2));
end