# STPO 

## Overview

STPO (Multi-strategy Enhanced Parrot Optimization Algorithm) is an improved version of the Parrot Optimization Algorithm (PO), with the following core optimization strategies:

- **Sparrow Algorithm's Vigilance Mechanism**: When an individual is in an unfavorable state, it automatically heightens alertness and deviates from the current extreme value region. This enhances local search capabilities while maintaining the ability to escape local optima, thereby improving the balance between exploration and exploitation.
  
- **Experience Exchange and Multi-Source Learning**: This approach enhances population diversity and accelerates knowledge propagation, thereby facilitating cross-basin search in high-dimensional multi-peak problems.

- **Worst-Case Guidance Differential Scale Perturbation**: By adjusting particle positions, it promotes population diversity, thereby enhancing global search capabilities and accelerating convergence.

## Environment

- **Computer**: LAPTOP-PE1C6HJJ
- **Software**: MATLAB R2025a [link]
- **Git** for version control (if you plan to clone the repository)

## Experimental Testing

The STPO algorithm has been tested on benchmark function datasets including CEC2017 and CEC2022. All experiments were conducted using Optimization Algorithm Application v6.0, which can be accessed by obtaining a verification code through the WeChat public account.

- **WeChat Public Account**: Get a code
- **App Version**: 6.0 (Optimization Algorithm Testing Platform)

The source files for the STPO code and a simple test function are provided below to help you conduct preliminary performance testing.
- The STPO compressed package is provided for download.
