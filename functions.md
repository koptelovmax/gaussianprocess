# List of tools used in the original code
## Preprocessing:
- Open a video file
- Extract frames (images)
- Resize frames (images)

## Processing:
- Convert image to grayscale
- PCA
- Matrix multiplacation
- Kernels: linear, RBF (Radial Basis Function), Polynomial, RATQUAD, MLP (Multilayer Perceptron), Matern32
- Creation of a kernel
- Function initKernWeight for combined kernels defenition
- Function weightsConstrain for hyperparameters initialization
- Function kernExpandParam for combined kernel structure definition
- Function updateKernWeight
- Hyperparameters optimization function gpdm
- Prediction and sample reconstruction
- floor, ceil
- reshape an array into the matrix
- Save data back to video file