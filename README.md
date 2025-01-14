# Senior-Project---MATLAB-and-Simulink-scripts
MATLAB and Simulink codes that are used in the ongoing senior project.
I'd like to express my gratitude to my advisor, Professor Suchin Arunsawatwong, for his insightful feedback and invaluable guidance. 
and special thanks to Marwin Vanitchanon, for his collaboration and dedication.

## The objective of this post.
This senior project aims to design the controller (or regulator) for load frequency control (LFC) in an isolated grid with high penetration of renewable energy.

In short, the main problem is that the classic controller design methods, widely studied in coursework, only consider the case with the step input signals that remain constant over time.

However, in practical scenarios, load demand and renewable energy are uncertain and vary persistently for a long period of time.
Also, Conventional approaches such as LQR and Model Predict Control (MPC) are often ineffective due to the difficulty in defining sufficient objective functions.

To achieve the senior project's goal. We validate that the 'method of inequality' can be applied to load frequency control, which is considered a conditional linear control system due to generation rate constraints.
This post shows the validation process. For more information, please look up **"Senior_Project_Proposal_Edited.pdf"**.

**The magnitude and slope of the load demand persistently change over time.**
![figure3](https://github.com/user-attachments/assets/fc23f840-0b9d-43bd-ad90-4ce902e29b99)
**The frequency deviations and the generation rate constraint are bounded within defined limits**
![figure4](https://github.com/user-attachments/assets/76f21766-3a4e-47bd-baaf-44fef9565d16)

## File descriptions:
This folder doesn't contain the MBP algorithm.
1. Algorithm to determine the abscissa of stability and the approximate peak output of the signal from a consistent input (load demand) that varies over time.
2. Simulink model of the Load Frequency Control (LFC) system. Run "for_simulink_model.m" first to set parameter values.
3. Senior_Project_Proposal_Edited.pdf - Shows that the designed regulator reduces the frequency deviation's peak to 50% from regulation limits under very high demand changes up to 8.4% pu/min while operating a reheat steam turbine with a ramp rate of up to 10% pu/min.
4. call_Algorithm1_TChuman_turbine.m - Used to compute the parameters of the regulator by calling the "Algorithm1_TChuman.m" function with the MBP Algorithm.
5. for_simulink_model.m - Script to initialize parameters for the LFC Simulink model.
