## Independent work: Off-shell effects in top pair production

The examples above should provide you with sufficient knowledge to now undertake an independent project. The topic of this project top quark production at the LHC. The dominant mode of production is the QCD-induced production of top-antitop pairs. Top quarks, being unstable, decay into $b$ quarks and $W$ bosons, which further decay either leptonically (lepton + neutrino) or hadronically (a pair of quarks). 

Given that the top quark is a relatively narrow resonance, it is often sufficient to perform simulations with stable top quarks or with approximate decay treatments. However, as LHC measurements are reaching very high precision, there are cases where it becomes or soon become necessary to include exact off-shell effects. Examples include measurements of the top quark mass based on the kinematic distributions of top decay products, or more recently, the measurement of quantum entanglement in top-antitop pairs.

Accounting for off-shell effects exactly is equivalent to performing calculations with the top decay products in the final state, rather than the top quarks themselves. The simplest channel to study from a theoretical perspective is the dilepton channel, where both $W$ bosons decay leptonically: i.e., the process $p p \to l^+ \nu_l l^- \bar{\nu}_l b \bar{b}$, where $l \in {e, \mu}$. In this project, we will focus exclusively on this channel.

The goal is to develop an intuition for the importance of off-shell effects in existing measurements. Specifically, we will examine the angular distribution of the two leptons and the transverse momentum of the $e^+ \mu^-$ system.

For that, you will compare predictions from a top-pair sample with approximate decay treatment to predictions from a sample in which the off-shell effects are exactly accounted for. Finally, you will also compare both predictions to experimental data to assess the significance of off-shell effects.

### Objective
Compare predictions from two different samples to each other and to data 
1. **Pythia8 Sample:** This sample will be generated using `Pythia8`, which includes parton showers, multiple parton interactions (MPI), hadronization, etc., but the top quark decay is treated only approximatively.
2. **MG5_aMC@NLO + Pythia8 Sample:** This sample will be generated using `MG5_aMC@NLO` for the hard scattering process, followed by `Pythia8` for showers and other effects. This approach accounts for off-shell effects exactly.
3. Data included in the `Rivet` analysis `CMS_2016_I1413748` and in particular for the distribution of cosine angle between the two leptons ($\cos \phi$, `d05-x01-y01`).


### Checklist

Carefully consider the following points:

1. **Select Appropriate Beam Energies:**
   We have already discussed how to set the beam energies in `Pythia8`. In `MG5_aMC@NLO`, this can be done by modifying the run card (`run_param.dat`). Note that different analyses may require different beam energies, so choose them accordingly.

2. **Select the Right Process:**
   Ensure that both the $gg$ and $q\bar{q}$ channels are enabled in `Pythia8`, and restrict the $W$ boson decays to leptons from the first two families (dilepton channel). In `MG5_aMC@NLO`, specify the final state after the top decay: `p p > e+ ve mu- vm~ b b~`. For simplicity, let's require the two $W$ bosons to decay into different lepton families. Upon inspecting the Feynman diagrams, you'll notice that not only topologies with two top quarks but also those with one or no top quarks contribute. These additional topologies contribute to off-shell effects and are not included in `Pythia8`.

3. **Generate Event Samples:**
   First, generate an event sample using `Pythia8` and analyse it using `Rivet` analyses spelled out above. Next, generate a sample with `MG5_aMC@NLO`, load the resulting `.lhe` file into `Pythia8`, _shower_ it, and analyse it using the same analyses.

4. **Ensure Sufficient Statistics:**
   Make sure each of your samples contains at least 10k events to ensure sufficient statistical accuracy; 100k events would be even better. Generating 100k events took about 30 minutes per sample on my laptop.

5. **Compare Predictions:**
   Use `rivet-mkhtml` to plot the predictions from both event samples. Compare the results with each other and with experimental data.


### Expected results 

Let us focus on the distributions of the $\cos \phi$ angle of the two leptons.

<img alt="A screenshot of a single Rivet plot of cos(phi) distribution" src="pics/result1.png" width="400">

We note that the `Pythia8` prediction is flat, so each angle is equaly likely. It seems like the spin-correlations are not taken into account and this is at odds with the data. In `MG5_aMC@NLO` the spin-correlations are taken into account by construction by considering the final state with top quark decay products.`MG5_aMC@NLO` describes the data well already at leading order accuracy. 