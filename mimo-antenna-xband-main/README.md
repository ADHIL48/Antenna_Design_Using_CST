# mimo-antenna-xband
Designed, simulated, and tested a MIMO antenna to enhance bandwidth and reduce mutual coupling for X-band applications.  Tools: CST, HFSS, MATLAB, VNA, PCB tools.

## Overview
This project focuses on the design, simulation, fabrication, and testing of a Multiple-Input Multiple-Output (MIMO) antenna for X-band applications (8–12 GHz). The primary objective is to enhance bandwidth, reduce mutual coupling between antenna elements, and improve overall communication reliability. The project combines electromagnetic simulation, prototype fabrication, and experimental validation.

## My Role
Led the end-to-end development of the MIMO antenna, from initial concept to final testing.

Performed literature review to understand current advancements and challenges in X-band MIMO antennas.

Designed the antenna structure, optimized geometry, and element spacing to ensure wide bandwidth and minimal mutual coupling.

Conducted 3D electromagnetic simulations to analyze S-parameters, gain, VSWR, and envelope correlation coefficient (ECC).

Fabricated the optimized antenna prototype using PCB manufacturing techniques.

Executed experimental measurements using a Vector Network Analyzer (VNA) to validate simulation results.

Analyzed and interpreted data to compare simulated and measured performance.

## Tools & Technologies
CST Microwave Studio: For 3D electromagnetic simulation and antenna optimization.

HFSS (Ansys): Alternative simulation environment for design validation.

MATLAB: For post-processing simulation data and calculating performance metrics (e.g., ECC, VSWR).

Vector Network Analyzer (VNA): For measuring S-parameters and validating antenna performance.

PCB Fabrication Tools: Used for prototyping the antenna based on the optimized design.

## How it Works
Simulation:

Download the CST or HFSS project files from the repository.

Open the files in CST Microwave Studio or HFSS (Ansys).

Run the simulations to analyze antenna parameters such as S-parameters, gain, and radiation patterns.

Data Analysis:

Use provided MATLAB scripts for further post-processing, such as calculating ECC and plotting results.

Scripts can be run directly in MATLAB; update the paths to the exported simulation data as needed.

Fabrication & Testing (optional):

Fabricate the antenna using standard PCB manufacturing based on provided Gerber files.

Use a Vector Network Analyzer to measure the fabricated antenna’s S-parameters and validate performance.

## Results
Achieved wide bandwidth coverage (8–12 GHz) suitable for X-band communication.

Successfully reduced mutual coupling between MIMO elements (e.g., S21 < -20 dB across the band).

Attained high radiation efficiency and stable gain throughout the operating frequency range.

Validated simulation results with physical measurements, confirming the accuracy of the design process.

The developed antenna design can be adapted for various advanced wireless applications requiring robust X-band performance.

