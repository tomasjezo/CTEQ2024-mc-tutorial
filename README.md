# CTEQ2024 Monte Carlo Tutorial, August 2024

The purpose of this tutorial is to introduce essential tools for making predictions at the Large Hadron Collider (LHC). Through a series of simple examples, you will learn the basics of Monte Carlo (MC) event generators, including how to generate events, store them, and analyse the results using a standard analysis toolchain. 

## Lecture 1 - Thursday, 22.08.2024

After a brief recap on the purpose and basic components of MC event generators, we will introduce an essential technical prerequisite: `Docker`. Since installing the software required for this tutorial can be challenging and time-consuming, we have prepared a `Docker` image that includes all the necessary prerequisites and can be easily downloaded onto any computer capable of running `Docker`. Notes on how to obtain the image and work with it can be found [here](docker_notes.md). At the end, we will verify that everyone can use the image and provide assistance to those who experience difficulties.

## Hands-on session 1 - Friday, 23.08.2024

We begin by generating events with `Pythia8`, analysing them, and comparing its predictions to experimental data using `Rivet3`. We then improve our predictions by upgrading the hard scattering component with the help of `MG5_aMC@NLO`. The learning materials for this session can be found [here](session1_examples.md). This document contains basic instructions along with several examples. We will go through the material together; the examples will be discussed and demonstrated at the same time. You are encouraged to try the examples immediately, but don't worry if you fall behind. We have allocated ample time for everyone to work through the exercises.

## Lecture 2 - Sunday, 25.08.2024

We introduce yet another hard event generator, `POWHEG BOX`, and discuss how events at next-to-leading order (NLO) accuracy can be consistently _showered_ with `Pythia8`. We will also explain how to write and build a custom analysis in `Rivet3`. The learning materials can be found [here](session2_examples.md). This time, I will explain the examples during the lecture, and you will have the opportunity to try them out in the hands-on session that will follow immediately afterwards.

## Hands-on session 2 - Sunday, 25.08.2024

This hands-on session will be reserved for independent work. Feel free to go back to examples from [Friday](session1_examples.md) or [earlier today](session2_examples.md). For those who want to reinforce what they have learned, we’ve also prepared an extra [assignment](assignment.md).

## Docker image build files

The container build files can be found here:
- [mc-tutorial](mc-tutorial.Dockerfile)
- [mc-tutorial-powheg](mc-tutorial-powheg.Dockerfile)
