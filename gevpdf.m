function GEV_pdf = gevpdf(x, k, mu, sigma)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   pdf = gev_pdf(x, k, mu, sigma) evaluates the probability density 
%   function (pdf) of the generalized extreme value (GEV) distribution.
%   
%   x:      stochastic input
%   k:      shape
%           k=0 => Type I extreme value distribution (Gumbel),
%           k>0 => Type II extreme value distribution (Fréchet),
%           k<0 => Type III extreme value distribution (reversed Weibull)
%   mu:     location
%   sigma:  scale, sigma > 0 per def.
%   
%   Example:
%   x = linspace(0, 10, 1000);
%   plot(x, gev_pdf(x, 1, 1, 1)); 
%   
%
%   (c) 2021, stefan.goetz@duke.edu, boshuo.wang@duke.edu


if (sigma == 0)
    sigma = sqrt(eps);
    warning('sigma == 0')
end

s = (x-mu)/sigma ; 

if (k == 0)
    GEV_pdf = 1/sigma * exp( -exp(-s) -s );
else
    GEV_pdf = 1/sigma * exp( -1 * (1 + k*s).^(-1/k) ) .* (1 + k*s).^(-1-1/k);
end

end
