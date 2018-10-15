function modelparameters = virtualsubjectEIVGenerateSubject()
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Simulation Test Bed
%   virtualsubjectEIVGenerateSubject() generates
%   a virtual subject described by a number of
%   parameters based on population statistics
%   of those parameters. With these parameters
%   virtstimulate can generate stimulus-response
%   pairs for those specific subjects.
%   The underlying statistical distributions are
%   described in the literature.
%   doi: 10.1101/406777 
%
%   modelparameters
%   = [<p1=µaddvary>, <p2>, <p3>, <p4>, <p5>,...
%      <multvary>, <addvarx>, <addvary>, <k>]
%
%   2010-06-23, r0.5 (c) smg
%   2015-11-12, r1.0 (c) smg
%   2017-08-18, r2.0 (c) smg
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %   Generate params for this subject
        %   all necessary params for EIV

            validIO = false;
            validIO_counter = 0;
        while not(validIO)
                validIO_counter = validIO_counter + 1;
                

                % correlation only between p3, p4, p5 significant => others described as stochastically independent

		aposteriori_mu = [-5.081764824125,	-2.467735071000,	3.646550162125,	0.426390035500,	1.666487134750,	-0.964533460250,	0.688273244000];                

                aposteriori_covmtrx = zeros(7, 7);
		aposteriori_covmtrx(1,:) = [0.003570541967,		0,		0,		0,		0,		0,		0];
		aposteriori_covmtrx(2,:) = [0,		0.126168431583,		0,		0,		0,		0,		0];
		aposteriori_covmtrx(3,:) = [0,		0,	7.202738820058,	0.569742608764,	-0.197461987887,		0,		0];
		aposteriori_covmtrx(4,:) = [0,		0,	0.569742608764,	0.047425817251,	-0.015113039713,		0,		0];
		aposteriori_covmtrx(5,:) = [0,		0,	-0.197461987887,	-0.015113039713,	0.007107112788,		0,		0];
		aposteriori_covmtrx(6,:) = [0,		0,		0,		0,		0,	0.022758778017,		0];
		aposteriori_covmtrx(7,:) = [0,		0,		0,		0,		0,		0,	0.023671071119];


                % multidumensional Gaussian including correlation based on cholesky decomposition of covariance matrix:
                tmp_randvector = mvnrnd(aposteriori_mu, aposteriori_covmtrx, 1);        % generate one parameter set for next run
                modelparameters(1:2) = tmp_randvector(1:2);
                modelparameters(3:7) = 10.^(tmp_randvector(3:7));

                
                % add parameters for additive variability (not correlated):
                modelparameters(8) = 1.55e-6 * 1.5^(randn);
                modelparameters(9) = 0.14 * 2^(randn);


            

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %   Spot-check parameters/validate:
            %   should include both
            %   saturation and low side in
            %   interval from 20% to 120%;
            %   furthermore, no outliers outside
            %   meaningful range;
            %   otherwise, regenerate
            tmp_xvec = linspace(0.2, 1.2, 300);
            tmp_yvec = virtstimulate(tmp_xvec, modelparameters);
            if (any(tmp_yvec < 30e-6)) && (any(tmp_yvec > 1e-3)) && (all(tmp_yvec < 30e-3)) && (all(tmp_yvec > 1e-7)) && (all(imag(tmp_yvec) < 1e-7))
                validIO = true;
            end
                
        end
        
end

