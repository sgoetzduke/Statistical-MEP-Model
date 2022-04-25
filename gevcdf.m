function GEV_cdf = gevcdf(x, k, mu, sigma)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   cdf = gev_cdf(x, k, mu, sigma) evaluates the cumulative distribution 
%   function (cdf) of the generalized extreme value (GEV) distribution.
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
%   (c) 2017, stefan.goetz@duke.edu, 
%   2021, update by boshuo.wang@duke.edu

if (sigma == 0)
    sigma = sqrt(eps);
    warning('sigma == 0')
end

s = (x-mu)/sigma ; 

if (k == 0)
    GEV_cdf = exp( -exp(-s) );
else
    GEV_cdf = exp( -1 * (1 + k*s).^(-1/k) );
end

end
