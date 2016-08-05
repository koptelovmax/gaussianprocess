# README
## Multi-kernel Gaussian Process Dynamic Model
This repository is about internship on the following topic:
http://www.sciencedirect.com/science/article/pii/S0165168415003680

# Repository content
- *report_master.pdf* - final paper in the report format describing the context of the internship, giving theoretical introduction to the main aspects used in this work and providing and explaining some results obtained
- *presentation.pdf* - presentation has been shown during the defence in Jean Monnet University on 30 June 2016

## Python/
- **Gaussian.ipynb** - example of Gaussian normal distribution and joint distribution of two independant events
- **Multivariate_Gaussian.ipynb** - examples of multivariate Gaussian distribution with different input data and with conditions using library function and own implementation
- **Preprocessing.ipynb** - preprocessing of input video to grayscale format with 120x90 resolution. In addition, some instructions how to install OpenCV for Jupyter Notebook
- **GPLVM.ipynb** - GPLVM model implementation using GPy library. Use this version to generate any number of frames
- **GPLVM_meanpred.ipynb** - mean prediction version (for observed texture Y) of GPLVM with mean square error evaluation. Use this version to generate the same number of frames as in the input sample and to compare them using mean sqare error
- **GPLVM_mislastframes.ipynb** - missing frames estimation version of GPLVM. The input texture Y with N frames splits into two parts: training set N-Nmis frames and test set of Nmis frames. It uses the training set to learn the model and synthesises N new frames then using mean prediction method. After it compares last Nmis frames of the new texture Ysynt with the last Nmis frames of original texture Y using mean square error
- **GPLVM_interactive.ipynb** - interactive version of GPLVM for 2 dimensions in the latent space
- **Processing.ipynb** - MK-GPDM Python reimplementation (not finished due to gradients test fails and necessity to define a model to perform optimization using GPy library)
- **Gradient_test.ipynb** - module for testing gradients used in MK-GPDM implementation
- **Video_generator.ipynb** - generates artificial videos of rotated rectangle

### data/
- *straw.avi* and *sunshade.avi* - input video samples from Dyntex batabase: http://refhub.elsevier.com/S0165-1684(15)00368-0/sbref34
- *samplevideo.npy* and *samplevideo2.npy* - preprocessed versions of straw and sunshade

### examples/
- examples of generated videos using samples from data/ and GPLVM with mean prediction method

## Matlab/
### gaussian/
- **gaussian.m** - example of Gaussian normal distribution in Matlab
- **gaussian3d.m** - example of joint distribution of two independant events

#### multivariate/
- **multigaussian.m** - example of multivariate Gaussian distribution with conditions and without using library function
- **onefunctionplot.m** - example of multivariate Gaussian distribution with conditions and without using my own implementation
- **mykernel.m** - kernel function used in the examples
- **getkernmatrix.m**, **getkernmatrix2.m**, **multvarcondens.m** - supporting files

### MK-GPDM/
This folder contains fixes and additions for MK-GPDM implementation taken from here: https://github.com/zhuziqi/Dynamic_Texture_Modeling_using_MKGPDM
To use these updates clone the original repository first and follow the instructions provided below
- **DEMO_FOR_MKGPDM.m** - replace in the original repository. There is a problem with sunshade video, if you want to use it do not use the normalization of the input data (otherwise quite a big error of the synthesised texture will be obtained).
- **preprocess.m** - preprocessing of input video to 120x90 resolution. Add to the original repository
- **postprocessing.m** - saving the results to the output avi video
- **postpreprocessing.m** - saving the preprocessed video into avi format (sometimes it is usefull to check the preprocessing stage)

#### meanpred/
Mean prediction version (for observed texture Y) of MK-GPDM model with mean square error evaluation. Use this version to generate the same number of frames as in the input sample and to compare them using mean sqare error
- **DEMO_FOR_MKGPDM.m** - replace in the original repository

#### misframe/
Missing frames estimation version of MK-GPDM. Predicts any frame in the middle of the input sequence Y and then compares it with original one using MSE and abs mean. The basic idea of this approach is to skip missing frame everywhere it is used. The first optimization function was changed to be able to work with N-1 observed frames of texture Y. Moreover, the gradients for were changed to make it possible to match dimensionalities and perform optimization
- **mk_gpdm1.m**, **mk_gradient1.m**, **mk_likelihood1.m**, **mk_prediction1.m** - supporting files, add to the original repository (changed version of the optimization function along with its gradients)
- **DEMO_FOR_MKGPDM.m** - replace in the original repository

#### mislastframes/
Missing frames estimation version of MK-GPDM. In this version the input texture Y with N frames splits into two parts: training set N-Nmis frames and test set of Nmis frames. It uses the training set to learn the model and synthesises N new frames then using mean prediction method. After it compares last Nmis frames of the new texture Ysynt with the last Nmis frames of original texture Y using mean square error
- **DEMO_FOR_MKGPDM.m** - replace in the original repository

### data/
- *1.mat* and *2.mat* - preprocessed versions of straw and sunshade samples from Dyntex batabase: http://refhub.elsevier.com/S0165-1684(15)00368-0/sbref34

### examples/
- examples of generated videos using samples from data/ and MK-GPDM with mean prediction method

### VGPDS/
Variational Gaussian Process Dynamical Systems model described in the paper: https://arxiv.org/pdf/1107.4985.pdf

The main difference with two previous models - it is a temporal latent model. It is based on the assumption that X is a multivariate Gaussian process indexed by time T. Another optimization approach is used as well to obtain a better performance (see *report_master.pdf* for the details).

This folder contains fixes and additions for VGPDS model implementation taken from here: https://github.com/SheffieldML/vargplvm

To be able to use this model some dependencies must be installed:
- GPmat - Neil Lawrence's GP matlab toolbox: https://github.com/SheffieldML/GPmat

- Netlab v.3.3: http://www1.aston.ac.uk/ncrg/

- Isomap.m: http://web.mit.edu/cocosci/isomap/code/Isomap.m

- L2_distance.m: http://web.mit.edu/cocosci/isomap/code/L2_distance.m

To use the fixes and updates clone the original repository first and follow the instructions provided below
- **preprocess.m** - preprocessing of input video to 120x90 resolution. Add to the original repository
- **postprocessing.m** - saving the results to the output avi video
- **vargplvmOptimise.m** - one warning fixed, replace in the original repository
- **VARGPLVM.m** - missing frames estimation version of VGPDS. Replace in the original repository. In this version the input texture Y with N frames splits into two parts: training set N-Nmis frames and test set of Nmis frames. It uses the training set to learn the model and synthesises N new frames then using mean prediction method. After it compares last Nmis frames of the new texture Ysynt with the last Nmis frames of original texture Y using mean square error. If you want to use classical version without missing frames estimation approach just use Nmis = 0

### data/
- *1.mat* and *2.mat* - preprocessed versions of straw and sunshade samples from Dyntex batabase: http://refhub.elsevier.com/S0165-1684(15)00368-0/sbref34

### examples/
- examples of generated videos using samples from data/ and VGPDS with mean prediction method