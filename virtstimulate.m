function myresponse = virtstimulate(amplitudeSI, ActSubjectParameters)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   virtstimulate(amplitudeSI, ActSubjectParameters)
%   stimulates a subject with parameters ActSubjectParameters,
%   e.g., generated with virtualsubjectEIVGenerateSubject,
%   with amplitude(s) amplitudeSI. The return value is a
%   peak-to-peak amplitude value in Volts.
%
%
%   amplitudeSI:           amplitude value,
%                          typically between 0 and 1
%   ActSubjectParameters:  subject, represented by its
%                          parameters   
%
%   (c) 2017, stefan.goetz@duke.edu



	myamplitude = amplitudeSI * 100;

	RandNumx = ActSubjectParameters(7) *randn(size(amplitudeSI));
	RandNumy = ActSubjectParameters(6) *randn(size(amplitudeSI));
	RandNumFloor = 0;





        %% only positive x values (despite p5 and x noise):
	CorrectedxArgument = eps + (myamplitude - ActSubjectParameters(5) + RandNumx) .*(myamplitude - ActSubjectParameters(5) + RandNumx > 0);
	add_yvar = rand_gev(size(amplitudeSI), ActSubjectParameters(9), 10.^ActSubjectParameters(1), ActSubjectParameters(8));
	fullresponse = RandNumFloor + add_yvar + exp( log(10)* (RandNumy + -7 + (ActSubjectParameters(2) - (-7)) ./(1 + ActSubjectParameters(3)./(CorrectedxArgument).^ActSubjectParameters(4))) );
	myresponse = real( fullresponse );    
  
        
end
