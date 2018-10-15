

%% Generate random 100 subjects and plot IO curves

rng('shuffle')

figure

for icnt=1:100
    
    subject(icnt).parameters = virtualsubjectEIVGenerateSubject;

	% generate and plot IO curve for respective subject
	stimamps = linspace(0, 1, 300);
	MEPVpp = virtstimulate(stimamps, subject(icnt).parameters);
	
        
    cla
        plot(stimamps, MEPVpp, 'sk')
        set(gca, 'XScale', 'lin', 'YScale', 'log')
        title(num2str(icnt))
        ylim([1e-6, 1e-2])
        box on
        grid on
        pause(0.25)
end



% generate several additional MEPs at 50% machine output for subject 10:
	MEPVpp(1) = virtstimulate(0.5, subject(10).parameters);
	MEPVpp(2) = virtstimulate(0.5, subject(10).parameters);
	MEPVpp(3) = virtstimulate(0.5, subject(10).parameters);
	MEPVpp(4) = virtstimulate(0.5, subject(10).parameters);
	MEPVpp(5) = virtstimulate(0.5, subject(10).parameters);