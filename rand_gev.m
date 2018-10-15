function myrandnums = rand_gev(N, k, mu, sigma)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   rand_gev(N, k, mu, sigma) generates random numbers
%   following a generalized extreme value disitrbution
%   with parameters k, mu, and sigma. The return value
%   is a matrix of NxN independent values.
%
%
%   N:      size of matrix to be generated
%   k:      shape
%           (k=0 => Gumbel-type distribution,
%            k>0 => Weibull-type distribution,
%            k<0 => Frechet-type (inverse Weibull) distribution)
%   mu:     location
%   sigma:  scale, sigma > 0 per def.
%
%   N.B.: do not forget to initialize the random number
%         generator with rng
%
%   
%   Example:
%   rng('shuffle')
%   x = rand_gev(100, 1, 1, 1);
%   hist(x(:))
%   
%
%   (c) 2017, stefan.goetz@duke.edu


    if (sigma == 0)
        sigma = sqrt(eps);
        warning('sigma == 0')
    end


    %% for now, generate pdf for test values and integrate numerically
    if (k == 0)
        tmpx = linspace(mu-150*sigma, mu+150*sigma, 200000);
    elseif (k<0)
        tmpx = linspace(mu-150*sigma, -1.0*sigma/k+mu-eps, 200000);
    elseif (k>0)
        tmpx = linspace(-1.0*sigma/k+mu+eps, mu+150*sigma, 200000);
    end

    tmp_pdf = gev_pdf(tmpx, k, mu, sigma);
        % eliminate any complex entries:
        tmp_pdf( imag(tmp_pdf)~=0 ) = 0;
    tmp_cdf = cumsum([0 diff(tmpx)] .* tmp_pdf);

    %% now integrate to convert equally distributed number

    myrndnumeq = rand(N);
    myrandnums = 0*myrndnumeq;

    for icnt=1:length(myrndnumeq(:))
        [tmpval, tmpind] = min( abs(tmp_cdf-myrndnumeq(icnt)) );
        myrandnums(icnt) = tmpx( tmpind ); 
    end

    


end