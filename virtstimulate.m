function response = virtstimulate(amplitude_SI, subject_parameters)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   virtstimulate(amplitude_SI, subject_parameters)
%   Stimulates a subject with parameters subject_parameters,
%   e.g., generated with virtualsubjectEIVGenerateSubject,
%   with amplitude(s) amplitude_SI. The return value is a
%   peak-to-peak amplitude value in Volts.
%
%   amplitude_SI:	amplitude value, typically between 0 and 1
%   subject_parameters:	subject, represented by its parameters
%
%   (c) 2017, stefan.goetz@duke.edu, 
%   2021, update by boshuo.wang@duke.edu

amplitude = amplitude_SI * 100;    % convert from [0, 1] to [0%, 100%]

rand_num_x = subject_parameters(7) * randn(size(amplitude_SI));
rand_num_y = subject_parameters(6) * randn(size(amplitude_SI));

rand_num_floor = 1e-8;  % 10 nV

% Only positive x values (despite p5 and x noise):
x_corrected = max( (amplitude - subject_parameters(5) + rand_num_x), eps);

add_y_var = randgev(size(amplitude_SI), subject_parameters(9), 10.^subject_parameters(1), subject_parameters(8));
%                   x,                  k,                     mu,                        sigma

response = max(rand_num_floor, real( add_y_var + ...
                 1e-7 * exp( log(10) * ( rand_num_y + (subject_parameters(2)) ./ ...    
                             ( 1 + subject_parameters(3) ./ ( x_corrected.^subject_parameters(4) ) ) ) ) ) );
% First -7 in original code moved out of exp as 1e-7. Second -7 included in
% subject_parameters(2).
end
