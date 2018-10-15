function myf = gev_pdf(x, k, mu, sigma)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   pdf = gev_pdf(x, k, mu, sigma) evaluates the probability
%   density function of the generalized extreme value
%   distribution.
%
%   x:      stochastic input
%   k:      shape
%           (k=0 => Gumbel-type distribution,
%            k>0 => Weibull-type distribution,
%            k<0 => Frechet-type (inverse Weibull) distribution)
%   mu:     location
%   sigma:  scale, sigma > 0 per def.
%
%   
%   Example:
%   x = linspace(0, 10, 1000);
%   plot(x, gev_pdf(x, 1, 1, 1)); 
%   
%
%   (c) 2017, stefan.goetz@duke.edu


    if (sigma == 0)
        sigma = sqrt(eps);
        warning('sigma == 0')
    end


    if (k == 0)
        myf = 1/sigma * exp( -1* exp(-1* (x-mu)/sigma) - (x-mu)/sigma );
    else
        myf = 1/sigma * exp( -1* (1 + k*(x-mu)/sigma).^(-1/k) ) .* (1 + k*(x-mu)/sigma).^(-1-1/k);
    end



end