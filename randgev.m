function rand_GEV = randgev(N, k, mu, sigma)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   rand_gev(N, k, mu, sigma) generates random numbers following a
%   generalized extreme value disitrbution with parameters k, mu, and
%   sigma. The return value is a matrix of size(N) independent values.
%
%   N:      size of matrix to be generated, scalar or vector
%   k:      shape
%           k=0 => Type I extreme value distribution (Gumbel),
%           k>0 => Type II extreme value distribution (Fréchet),
%           k<0 => Type III extreme value distribution (reversed Weibull)
%   mu:     location
%   sigma:  scale, sigma > 0 per definition
%
%   N.B.: do not forget to initialize the random number generator with rng
%
%
%   Example:
%   rng('shuffle')
%   x = rand_gev(100, 1, 1, 1);
%   hist(x(:))
%
%   (c) 2017, stefan.goetz@duke.edu, 
%   2021, update by boshuo.wang@duke.edu

if (sigma == 0)
    sigma = sqrt(eps);
    warning('sigma == 0')
end

x_num = 200000;

% Support
if (k == 0)
    x_vec = mu + linspace(-150*sigma, 150*sigma, x_num);
elseif (k < 0)
    x_vec = mu + linspace(-150*sigma, -1.0*sigma/k-eps, x_num);
elseif (k > 0)
    x_vec = mu + linspace(-1.0*sigma/k+eps, +150*sigma, x_num);
end
 
% % %% for now, generate pdf for test values and integrate numerically
% % pdf_vec = gevpdf(x_vec, k, mu, sigma);
% % % eliminate any complex entries:
% % ind_imag = (imag(pdf_vec)~=0);
% % pdf_vec = pdf_vec(~ind_imag);
% % x_vec = x_vec(~ind_imag);
% % cdf_vec = cumsum([0, diff(x_vec)] .* pdf_vec);

% Generate cdf directly (2021 update)
cdf_vec = gevcdf(x_vec, k, mu, sigma);

% Convert equally distributed number GEV random numbers using cdf
rnd_num_eq = rand(N);
rand_GEV = zeros(N);

for i_cnt = 1 : numel(rnd_num_eq)
    [~, cdf_ind] = min( abs( cdf_vec - rnd_num_eq(i_cnt) ) );
    rand_GEV(i_cnt) = x_vec( cdf_ind );
end

end
