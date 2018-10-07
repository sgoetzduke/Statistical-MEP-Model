# Statistical-MEP-Model
Statistical model of motor evoked potentials in brain stimulation

## Summary
The code implements a detailed realistic model that can generate motor evoked potentials (MEP) for individual virtual subjects and for larger subject populations with their characteristic trial-to-trial variability. The model shows features previously described in the literature, such as bimodal amplitude distributions of MEPs and it meant to provide a development and test bench for mathematicians, statisticians, and theoreticians in brain stimulation technology to design needed new analysis and biomarker extraction methods, to avoid expensive experimental procedures during early design phases, or perform testing at scales that are not possible experimentally.

The model generates motor evoked potentials (MEP) in response to brain stimulation with intra-individual and inter-individual variability as well as amplifier noise extracted from experimental data. 
The underlying model is described in detail in S. M. Goetz, S. M. Mahdi Alavi, Z.-D. Deng, and A. V. Peterchev. Statistical Model of Motor Evoked Potentials for Simulation of Transcranial Magnetic and Electric Stimulation. https://doi.org/10.1101/406777

## Background Information
MEPs are among the few directly measurable responses to suprathreshold transcranial stimulation and ubiquitously used as a metric for individualized dosing of stimulation strength. The large variability of MEPs requires sophisticated methods of analysis to extract information fast and correctly. However, the development of such methods requires large quantities of test data, to which theoreticians have no access or which exceed typical experimental studies. Realistic detailed models for MEP generation are not available yet.

The code implements a quantitative model that can generate long sequences MEPs with the properties observed in experiments to mimic actual human subjects. It also generates virtual subject data from a large population statistics. The model should fill a void by providing a tool to stimulate the development and testing of new methods for brain stimulation.

The MEP model includes three sources of trial-to-trial variability to mimic excitability fluctuations, variability on the neural and muscular pathway, and physiological and measurement noise. All parameters are extracted as statistical distributions from experimental data from the literature.
The model shows MEP features that were previously described in the literature and can generate long sequences of test data for individual subjects or for subjects from a larger virtual population.








## Files
virtstimulate(myamplitudeSI, ActSubjectParameters)

virtualsubjectEIVGenerateSubject()

gev_pdf(x, k, mu, sigma)

rand_gev(N, k, mu, sigma)
