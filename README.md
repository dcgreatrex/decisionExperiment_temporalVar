# decisionExpt_temporalVar
# Experiment investigating the effects of temporal variability on reaction times during perceptual decision-making (2016)
*Author: David Greatrex, University of Cambridge.  
*Date: 18/08/2016 -- Language: MATLAB. -- Modifications:

## Summary:
This package runs an original reaction-time experiment designed and run at the University of Cambridge. 

## Requirements:
MATLAB (MathWorks) - the program was build in version R2015b.
Psychtoolbox3 (http://psychtoolbox.org/) - version 3.0.13 - Flavor: beta - Corresponds to SVN Revision 8038.

## Installation:
Clone the respository to a local folder and set MATLABs current directory to the selected folder.
Enter 'temporal_variability' into the MATLAB terminal to start the experiment.

## Experimental overview:
Previous experiments in the timing literature have shown that decision latencies during complex averaging decisions are sensitive to temporal variance in the structure of an acoustic stimulus (Greatrex 2015, 2016). It remains unknown whether this sensitivity was the result of cognitive processes specific to complex choice, or motor preparation in general. This is an important distinction to make as it will determine whether or not rhythmic variability should be incorporated into models of complex choice.

The current experiment tests whether speeded reaction times to the onset of a probe tone are sensitive to IOI variance in a precursor rhythmic sequence. As this is a simple task and does not require higher-order judgement, it allows for the distinction between complex choice and motor preparation to be made. If reaction times are sensitive, then the previous findings reported by Greatrex (2016, 2016) are likely to have been caused by processes separate from complex decision-making.

## Questions being investigated:
1. Are reaction times sensitive to IOI variance in a precursor rhythmic stimulus during a simple speeded reaction time task?
2. Does the foreperiod between the onset of the precursor stimulus and response tone impact participants' sensitivity towards rhythmic variance in the precursor stimulus?

## Task:
On each trial participants hear a rhythmic acoustic sequence comprising short bursts of noise followed by a high pitched probe tone. 
Each burst of noise and probe tone is centrally located and delivered using the same phase and intensity in both ears.
Upon hearing the probe tone (which always occurs after a fixed inter-onset interval (IOI) following the final noise burst), participants are to press a response key as fast as possible. 

The precursor sequence varies by the number of noise bursts it contains and can have between four and ten bursts in each sequence.
Rhythmic variability is manipulated by using either a periodic precursor rhythm (zero IOI variability) or aperiodic rhythms divided into two groups of low and high rhythmic variability. 
All sounds are digitally generated in Matlab (The MathWorks) at a sampling rate of 48.8 kHz and should be presented over studio-grade headphones in a sound attenuated recording booth. 

## References
* [Brainard, D. H. (1997). The psychophysics toolbox. Spatial vision, 10, 433-436.](http://bbs.bioguider.com/images/upfile/2006-4/200641014348.pdf)
* Greatrex, D. (2015). The effect of rhythmic expectation on complex averaging decisions. PhD Thesis. University of Cambridge.
* Greatrex, D. (2016). Accounting for stimulus rate and complexity during complex decision-making. PhD Thesis. University of Cambridge.
* [The MathWorks](http://uk.mathworks.com/) 