# HumanL5NeuronModel
Code associated with the publication, "A novel human neuron model reveals the influence of inter-species h-channel kinetic differences on resonant responses"

Here you will find Matlab code associated with various plotting and "post-hoc" analysis performed in our study.

A majority of the included code is "supplementary", i.e. necessary for plotting functions, parameter definitions etc.

The three major pieces of code are the following:
  
  PlotImpedanceFromZap_0523: this is the code used to generate the impedance plots in response to a ZAP stimulus, like those seen in Figure 7 (the bottom row). You will need to input a time series, corresponding voltage trace, and corresponding current trace (i.e. ZAP current), by changing the early code which "fetches" these files (the various "csvread" calls).
  
  run_freqDepGain_0924: this is the code used to generate the frequency-dependent gain plots seen in Figure 11. This code calls the "freqDepGain" file in making th eactual calculation. Note that the file included here is formatted for averaging multiple runs, but can be adjusted to plot individual frequency-dependent gain outputs simply by changing the loops and the "fetch" commands.
  
  run_MakeNoise_0425: this is the code that generates the Gaussian white noise used in frequency-dependent gain analysis. It makes use of the "makeNoise" command (see that code for details on the input parameters, etc.).
 
