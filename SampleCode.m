%% Generate random 100 subjects and plot IO curves

rng('shuffle')
stimamps = linspace(0, 1, 300);
	
figure('Color', 'w', 'Units', 'Normalized', 'Position', [0.1,0.1,0.7,0.7]);
axes;
ylim([1e-6, 1e-2]);
xlim([0,100]);
set(gca, 'XScale', 'lin', 'YScale', 'log', 'Box', 'On', 'LineWidth', 1, ...
         'TickLabelInterpreter', 'Latex', 'FontSize', 14 , 'NextPlot', 'Add');
grid(gca, 'on');
xlabel('Stimulation strength: percentage of maximum stimulator output (MSO)', 'Interpreter', 'Latex', 'FontSize', 16);
ylabel('MEP: $V_{\mathrm{PP}} \ (\mathrm{V})$','Interpreter', 'Latex', 'FontSize', 16);

for icnt = 100 : -1 : 1
    
    subject(icnt).parameters = virtualsubjectEIVGenerateSubject;

	% Generate and plot IO curve for respective subject
	MEPVpp = virtstimulate(stimamps, subject(icnt).parameters);
        
    cla;
    plot(stimamps*100, MEPVpp, 'ok', 'MarkerFaceColor', 'w', 'MarkerSize', 6, 'LineWidth', 1)
    title(sprintf('Subject %d', 101-icnt), 'Interpreter', 'Latex', 'FontSize', 18)
    pause(0.5)
end

% generate 5 additional MEPs at 50% machine output for subject No. 10:
for icnt = 5 : -1 : 1
    MEPVpp = virtstimulate(0.5, subject(10).parameters);
end
