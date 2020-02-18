# HumanL5NeuronModel
Code associated with the publication, "A novel human neuron model reveals the influence of inter-species h-channel kinetic differences on resonant responses"

This code can be used to implement the model presented by Kalmbach et. al. 2018 and apply the relevant in silico experiments performed in our research.

To run the model in NEURON, simply run the Kalmbach.hoc command. To investigate the Kalmbach model with the novel human h-current model replacing the currently implemented rodent-motivated h-current model, swap the comments in the Kalmbach_biophys.hoc file (i.e. comment out the first "forall" loop, not the second) and rerun the Kalmbach.hoc command fresh.

Various procedures to run current clamp and ZAP current experiments are found in the Kalmbach_setup.hoc file. 

The model can also be found as part of  https://github.com/AllenInstitute/human_neuron_Ih
