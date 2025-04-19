This folder contains the main MATLAB code of the model simulation. 
The m files are:

ModelSolver.m:	The main function for solving the model equation
    |
    |---|--parameter.m: The file to define the parameter values
	|--control.m: The control parameter for solving the ODE model
	|--funs.m: Definition of the right-hand side of the model equation
	|--initialization.m: Initialize the CAR-T cells

fingPFS.m: 	Find the PFS through the tumor cell count dynamics
GlobalSensitivityAnalysis.m: 	Perform global sensitivity analysis of the model
Optimization.m: 	Find the optimized CAR-T cell doses for varying the initial tumor cell count
VariedInitialCells.m: 	Solve the model equation with varying initial CAR-T cell counts

