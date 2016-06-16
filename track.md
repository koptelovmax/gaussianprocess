# Internship track

## 27.04.16
### What has done
- Meeting with supervisers
- Implementation of conditionals multivariate distribution
- Creation of git repository

### Why
- To discuss directions I should follow and getting answers to my questions
- I need to share what I've done

### What has learned
- Different kernels
- Matrix inverse by Cholesky factorization
- Conditional Multivariate Gaussian distribution with noise and without

### What next
- Understand the model
- Learn MAP
- Learn optimization processes
- Learn Python
- Create iPython notebook
- Reimplement what I've done in Python

## 28.04.16
### What has done
- Familiarity with Jupyter Notebook
- Attending PhD seminar about Learning over unbalanced data 
- Starting the Python course on Software carpentry

### Why
- Jupyter Notebook is nice and easy to share what I've done
- I should use Python to rewrite the Matlab code

### What has learned
- Getting used to Jupyter Notebook
- First impression of how work of PhD student look like
- Basics of Python: loading data, statistical tools, loops and nested lists

### What next
- Finish Python course
- Reimplement what I've done in Python
- Understand the model
- Learn MAP
- Learn optimization processes

## 29.04.16
### What has done
- Finished Python course on Software carpentry
- Read the rules of procedure of LHC

### Why
- I should use Python to rewrite the Matlab code

### What has learned
- Basics of Python: multiple files operations, conditions, functions, errors and exceptions, defensive programming 
- I can not attend laboratory after 19:00

### What next
- Reimplement what I've done in Python
- Understand the model
- Learn MAP
- Learn optimization processes

## 02.05.16
### What has done
- Start of reimplementation in Python of what I made in Matlab

### Why
- I should use Python to rewrite the Matlab code

### What has learned
- How to use Gaussian distribution in Python
- How to install and use seaborn library

### What next
- Continue the reimplementation in Python of what I made in Matlab
- Understand the model
- Learn MAP
- Learn optimization processes

## 03.05.16
### What has done
- Reimplementation of Multivariate Gaussian distribution in Python using build-in pdf function

### Why
- I should use Python to rewrite the Matlab code

### What has learned
- Array operations in Python using Numpy
- How to use build-in function for Multivariate Gaussian distribution

### What next
- Multivariate Gaussian distribution in Python using my own pdf function
- Understand the model
- Learn MAP
- Learn optimization processes

## 04.05.16
### What has done
- Got access to the lab
- Added some comments to Jyputer about multivariate Gaussian distribution
- Multivariate Gaussian distribution function implementation

### Why
- I should use Python to rewrite the Matlab code

### What has learned
- How to scale plots in Python
- How to write equations in LaTeX

### What next
- Finish the reimplementation in Python of what I made in Matlab
- Understand the model
- Learn MAP
- Learn optimization processes

## 05.05.16
### What has done
- Finished multivariate Gaussian distribution function implementation

### Why
- I should use Python to rewrite the Matlab code

### What has learned
- Be careful with array indexes in Python
- Cholesky factorization in Python

### What next
- Understand the model
- Learn MAP
- Learn optimization processes

## 09.05.16
### What has done
- Example with non-stochastic kernel and noisy covariance matrix
- Conditional version used my multivariate distribution function

### Why
- I should use Python to rewrite the Matlab code

### What has learned
- Difference between lists and arrays and how to convert one to another
- Some new array operations (diag, reshape, eye)
- Be careful with variables names when run different cells with code

### What next
- Understand the model
- Learn MAP
- Learn optimization processes

## 10.05.16
### What has done
- General understanding of the model

### Why
- I'm supposed to understand what I need to do

### What has learned
- There are two main steps: DT modelling and DT syntesis
- DT modelling consists of two steps: Dimensionality reduction and Dynamical modeling
- Gaussian Process is used during all the steps: to infer the reduction function, to model DT and to generate new data

### What next
- Try to understand the code
- Learn first-order Markov model
- Learn MAP
- Learn optimization processes

## 11.05.16
### What has done
- Deeper understanding of the model
- Little review of the model in Jupyter notebook

### Why
- I'm supposed to understand what I need to do

### What has learned
- To achive nonlinear mapping in dimensionality reduction step special covariance function is used
- In dynamic texture modeling step the kernel matrix of latent mapping constructed by multi-kernel function
- Dynamic texture syntesis can be done by estimating necessary parameters and then by predicting new sequence of dynamic texture

### What next
- Try to understand the code
- Learn first-order Markov model
- Learn MAP
- Learn optimization processes

## 12.05.16
### What has done
- Undestanding of the preprocessing part of the code
- Preprocessing of input video (resize, b&w an save as an flat array) using OpenCV

### Why
- It is essential to make preprocessing of input video

### What has learned
- How to install OpenCV to use with Jupyter Notebook
- How to open and display video in Jupyter Notebook
- How to resize and grayscale video using OpenCV
- How to convert video to a flatten array

### What next
- Try to understand the code next
- Learn first-order Markov model
- Learn MAP
- Learn optimization processes

## 13.05.16
### What has done
- Meeting with supervisers

### Why
- To discuss directions I should follow and to get answers to my questions

### What has learned
- Stationary process - correlation depends on distance between two points only
- There is no dependency between original frames
- First order Markov model is Markov process depending on previous state only
- Which parameters we need to estimate first (X, Theta and labda)
- Function we must optimize (equations 11 and 12 in the paper)
- Some Python tricks (how to do matrix operations)

### What next
- Use Matlab to understand synthesis procedure
- Understand what to estimate and how
- Try to estimate some missing frames
- Evaluation of the model by prediction and interpolation
- Find the limit of the model
- If have time find good Gaussian process library for Python and try to reimplement code

## 16.05.16
### What has done
- Multivariate Gaussian distribution using matrix notations
- General learning algorithm understanding, making little review with steps

### Why
- I still want to reimplement the code in Python
- It is important to understand the algorithm

### What has learned
- We use PCA to do initialization
- First fix W and find maximum values of X, theta, lambda, only then optimize W

### What next
- Use Matlab to understand synthesis procedure
- Try to estimate some missing frames
- Evaluation of the model by prediction and interpolation
- Find the limit of the model
- If have time find good Gaussian process library for Python and try to reimplement code

## 17.05.16
### What has done
- Little review about code understanding
- Preprocessing function to make a video from rendered set of frames

### Why
- It is important to understand the algorithm
- I want to see the result of some test syntesises

### What has learned
- It is necessary to limit the size of frames, otherwise Out of memory problem can be faced

### What next
- Understand optimization functions used in code
- Missing frames estimation
- Model evaluation

## 18.05.16
### What has done
- Little help about functions used in original code

### Why
- It is important to understand the algorithm

### What has learned
- As first optimization the library function is used, for the second - own implementation
- How to write text in color in Markdown

### What next
- Think how to represent missing frame in original set Y
- Missing frames estimation
- Model evaluation
- Look for functions and libraries for Python

## 19.05.16
### What has done
- Some ideas how to represent missing frames in original dataset Y
- Understanding of how SCG function in Matlab works 

### Why
- It is required to make an evaluation of the model
- I can't do frame estimation without understanding of optimization

### What has learned
- For both optimizations SCG function is used which is different from the algorithm
- We can put 0 in the frames which we want to miss and it still works
- PCA with 0 frames works fine for the initialization

### What next
- Which functions exactly do we need to optimize?
- Functions and libraries for Python
- Model evaluation

## 20.05.16
### What has done
- Understanding of which functions exactly do I need to optimize
- Little review about it
- Starting of reimplementation code in Python

### Why
- It is important to understand the algorithm
- It is a good way to unerstand how it works throw reimplementation

### What has learned
- Dimensionalities of all variables used in functions I need to optimize
- How to perform PCA in Python

### What next
- Continue to reimplement the code
- Model evaluation

## 23.05.16
### What has done
- Implementation of mk_likelihood, weight_likelihood functions
- Understanding of gradient of L with respect to X and Theta, Lambda
- Templates for mk_gradient, weight_gradient functions

### Why
- It is a good way to unerstand how the code works throw reimplementation

### What has learned
- Some approaches of how to compute gradients

### What next
- Write functions to compute Kx and Ky
- Search for kern gradients
- Finish functions weight_gradient, mk_gradient
- Find SCG optimization function and perform it

## 24.05.16
### What has done
- K_x, K_y, mk_gradient functions

### Why
- It is a good way to unerstand how the code works throw reimplementation

### What has learned
- They compute K and K^(-1) in the function at the same time
- Kronecker delta

### What next
- Recheck dimensionalities of all optimization function parameters
- Search for kern functions and kern gradients libraries
- Find SCG optimization function and perform it

## 25.05.16
### What has done
- Recheck and fix of dimensionalities of functions and gradients

### Why
- Without this information I cannot get proper algorithm understanding

### What has learned
- Ky is NxN, while Kx is (N-1)x(N-1), where N - number of artificial frames
- Both functions we need to optimize are 1x1, because they are probabilities
- All the gradients have different dimensionalities (see review)
- Inverse of non-square matrix can be conputed throw singular value decomposition

### What next
- Update the review
- Search for kern functions and kern gradients libraries
- Find proper SCG optimization function and perform it

## 26.05.16
### What has done
- Update of the review
- Ky function reimplementation
- GPy framework installation

### Why
- I must understand how it works

### What has learned
- How to import kernels from GPy

### What next
- Use kern functions and kern gradients from GPy
- Find proper SCG optimization function and perform it

## 27.05.16
### What has done
- Meeting with superviser

### Why
- To discuss directions I should follow and to get answers to my questions

### What has learned
- Gradient of a function with one parameter is vector, with more parameters is matrix
- To check a gradient function I can use gradient checking module
- To estimate a missing frame I need N frames in X and N-1 frames in Y

### What next
- Store values mean and standard deviation
- Function to plot a frame
- Finish implementation of Kx, Ky, likelihood functions and gradients
- Program to generate a video and to track a motion of X in 2D case
- Find proper SCG optimization function and perform it
- Missing frame estimation using Matlab

## 30.05.16
### What has done
- Store values mean and standard deviation, function to plot a frame
- Implementation of Kx, Ky, likelihood functions and tests

### Why
- It is a good way to unerstand how the code works throw reimplementation

### What has learned
- How to use kernel functions from GP library

### What next
- Solve the problem with Kronecker delta (try on paper)
- Finish gradients functions and perform tests
- Program to generate a video and to track a motion of X in 2D case
- Find proper SCG optimization function and perform it
- Missing frame estimation using Matlab

## 31.05.16
### What has done
- Gradient test module to check gradients

### Why
- I need to use gradients and to test it somehow

### What has learned
- Lambda function is an anonymous function (that are not bound to a name)
- How to compute gradient of a kernel function using GPy
- How to use GPy.models.GradientChecker

### What next
- Finish gradients functions and perform tests
- Program to generate a video and to track a motion of X in 2D case
- Find proper SCG optimization function and perform it
- Missing frame estimation using Matlab

## 1.06.16
### What has done
- Function 1 gradient wrt X dimensionality analysis and code implementation
- Video generator implementation starting

### Why
- It is necessary to use gradients
- I want to perform a test of the given model

### What has learned
- How to check gradient of any function in lambda mode
- How to sum up kernels and compute gradient afterwards

### What next
- Function 2 gradient wrt W - find similarly analiticaly
- Find SCG optimization function and perform on function 2 first
- Finish Video generator implementation
- Missing frame estimation using Matlab

## 6.06.16
### What has done
- Function 2 gradient wrt W derivative and implementation

### Why
- It is necessary to use gradients

### What has learned
- How to derive gradients analiticaly

### What next
- Function 2 gradient test
- Find SCG optimization function and perform on function 2 first
- Finish Video generator implementation
- Missing frame estimation using Matlab

## 7.06.16
### What has done
- Function 2 gradient test

### Why
- It is necessary to use gradients

### What has learned
- Gaussian process models in GPy Python library
- How to draw rectangle in Python using matplotlib

### What next
- Finish video generator
- Missing frame estimation using Matlab
- Try to perform optimization

## 8.06.16
### What has done
- Meeting with superviser

### Why
- To discuss directions I should follow and to get answers to my questions

### What has learned
- Matrix gradients dimensionalities
- I can remove kernel I don't like and try another one
- Dinamic texture can be represented in different ways, not necessary with frames
- There is another approach to learn dinamic texture is to use wavelets
- I should try Special temporal Gaussian field as well

### What next
- Finish video generator and perform tests with 2D latent space
- Find the limit of the model by missing frame estimation
- Write report and send draft to check
- If have time try GPLVM model and find difference between the models

## 9.06.16
### What has done
- Video generator application
- Generated one test video

### Why
- I should test the model before using it

### What has learned
- How to plot rectangle, make rotations, crop of the image in OpenCV

### What next
- Perform tests with 2D latent space
- Find the limit of the model by missing frame estimation
- Write report and send draft to check

## 10.06.16
### What has done
- Performed the series of tests in 2D and 1D latent spaces

### Why
- I should test the model before using it

### What has learned
- In 1D the result is better than in 2D

### What next
- Try to understand GPLVM model
- Start writting the report
- Limit of the model by missing frame estimation

## 13.06.16
### What has done
- GPLVM model understanding
- Meeting with superviser

### Why
- To get answers to my questions
- GPLVM is another model not so far from our model

### What has learned
- How to use GPLVM model in GPy
- How to predict new X and Y based on learned dynamic texture
- One possible approach to perform missing frame estimation
- Without random generator initialization everytime I get the the same values

### What next
- Check is there initialization of a random generator in the code
- Try to use all the kernels separately and compare weights and latent variables
- Plot X wrt to time and try to see some dependancies (like loop etc)
- Missing frames estimation trow conditions (if it is not possible why?)
- Implement GPLVM model in a separate file and try to perform frames generation

## 14.06.16
### What has done
- Latent frames prediction and Y reconstruction
- GPLVM model implementation

### Why
- GPLVM is very similar to our model

### What has learned
- How to perform optimization with steps limit
- How to use equations for frames prediction and Y reconstruction

### What next
- Check is there initialization of a random generator in the code
- Try to use all the kernels separately and compare weights and latent variables
- Plot X wrt to time and try to see some dependancies (like loop etc)
- Missing frames estimation trow conditions (if it is not possible why?)

## 15.06.16
### What has done
- Different sample reconstruction techinics
- Video generation using GPLVM in Python

### Why
- GPLVM is very similar to our model

### What has learned
- Reconstruction can be performed by using multivariate gaussian or in matrix forms
- There is something wrong with this dynamic texture, it doesn't have dinamic at all
- They don't generate X randomly, that's why texture repeats everytime

### What next
- Check is there initialization of a random generator in the code
- Try to use all the kernels separately and compare weights and latent variables
- Plot X wrt to time and try to see some dependancies (like loop etc)
- Missing frames estimation trow conditions (if it is not possible why?)

## 16.06.16
### What has done
- Performed series of tests to check is it a random process or not
- Added random initialization

### Why
- The model is suppose to be about random processes

### What has learned
- They don't generate X randomly at all
- They don't use random numbers generator initialization

### What next
- Try to use all the kernels separately and compare weights and latent variables
- Plot X wrt to time and try to see some dependancies (like loop etc)
- Missing frames estimation trow conditions (if it is not possible why?)