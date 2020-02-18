# HumanL5NeuronModel
Code associated with the publication, "A novel human neuron model reveals the influence of inter-species h-channel kinetic differences on resonant responses"

In this subfolder, you will find relevant NEURON code to implement the model of Hay et. al. 2011, as well as apply the in silico experiments performed in this work.

These pieces of code should be used in concert with the full presentation of the Hay model, which can be found on ModelDB (Accession:139653)

The init_me.hoc file can be used, once the remaining elements of the model are downloaded from ModelDB, to initialize the baseline model used in this work (i.e. the Hay et. al. model with no alterations). To investigate the Hay et. al. model with the rodent h-current model replaced by a human h-current model, simply change line 25 in this file to "L5PCbiophys3_swap.hoc", ensuring that you have the Ih_me.mod file in your working directory and included when you run nrnivmodl (or the equivalent command to "compile" the various mod files).
