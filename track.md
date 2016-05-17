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
- To discuss directions I should follow and getting answers to my questions

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