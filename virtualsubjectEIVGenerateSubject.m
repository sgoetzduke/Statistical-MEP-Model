function model_parameters = virtualsubjectEIVGenerateSubject()
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Simulation Test Bed
%   virtualsubjectEIVGenerateSubject() generates a virtual subject
%   described by a number of parameters based on population statistics of 
%   those parameters. With these parameters virtstimulate can generate 
%   stimulus-response pairs for those specific subjects.
%   The underlying statistical distributions are described in the 
%   literature. doi: 10.1101/406777 
%
%   model_parameters = [ <p1=µaddvary>, <p2>, <p3>, <p4>, <p5>,...
%                        <multvary_mu>, <multvary_sigma>, ...
%                        <addvarx_mu>, <addvary_sigma>, ...
%                        <addvary_sigma>, <k> ];
%
%   2010-06-23, r0.5 (c) smg
%   2015-11-12, r1.0 (c) smg
%   2017-08-18, r2.0 (c) smg
%   2021-03-01, r2.1 update by boshuo.wang@duke.edu, p2 includes -7 from
%   virtstimulate.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

aposteriori_mu = ...
    [-5.081764824125,	4.532264929,        3.646550162125,     0.426390035500,     1.666487134750      ]; % p1, p2, p3, p4, p5
                  
aposteriori_covmtrx = [ ...
    [ 0.003570541967,	0,                  0,                  0,                  0                   ];...
    [ 0,                0.126168431583,     0,                  0,                  0                   ];...
    [ 0,                0,                  7.202738820058,     0.569742608764,    -0.197461987887      ];...
    [ 0,                0,                  0.569742608764,     0.047425817251,    -0.015113039713	    ];...
    [ 0,                0,                 -0.197461987887,    -0.015113039713,     0.007107112788		];...
                        ];                  % Correlation only between p3, p4, p5 

% multvary, addvarx
var_mu =    [-0.964533460250,	0.688273244000 ]; 
var_sigma =	[ 0.022758778017,	0.023671071119 ];...

%%%%%%%%%%%%
%   Generate params for this subject, all necessary params for EI

valid_IO = false;
stim_vec = linspace(0.2, 1.2, 300);
    
while ~(valid_IO)
    % Multidumensional Gaussian including correlation based on cholesky decomposition of covariance matrix
    rand_normal_vec = mvnrnd(aposteriori_mu, aposteriori_covmtrx, 1);	% generate one parameter set for next run
    model_parameters(1:2) = rand_normal_vec(1:2);
    model_parameters(3:5) = 10.^(rand_normal_vec(3:5)); % p3 to p5 log-normal
   
    % Parameters for multiplicative y and additive x variability
    model_parameters(6:7) = 10.^(var_mu + var_sigma .* randn([1,2]));
   
    % Parameters for additive y variability (not correlated):
    model_parameters(8) = 1.55e-6 * 1.5^(randn(1));
    model_parameters(9) = 0.14 * 2^(randn(1));
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %   Spot-check parameters/validate:
    %   Should include both saturation and low side in interval from 20% to
    %   120%; furthermore, no outliers outside meaningful range;
    %   Ostherwise, regenerate
    y_vec = virtstimulate(stim_vec, model_parameters);
    if (any(y_vec < 30e-6)) && (any(y_vec >  1e-3)) && ...	% Cover range of no response to saturation: from less than 30 µV to more than 1 mV)
       (all(y_vec >  1e-7)) && (all(y_vec < 30e-3))         % No outliers: less than 0.1 µV and more than 30 mV)
        valid_IO = true;
    end
    
end
        
end
