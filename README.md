<h1 align="center">AWESOME OCIM v1.3</h1>

<p align="center">
  <img src="https://user-images.githubusercontent.com/4486578/79958051-d2e70280-84c5-11ea-8a05-2f2b2f948e8d.jpg" width=50%>
</p>


***A Working Environment for Simulating Ocean Movement and Elemental cycling in an Ocean Circulation Inverse Model framework***

This repository contains the MATLAB code and some data for the AWESOME OCIM, developed by Prof. Seth John (<sethjohn@usc.edu>) and Ph.D. student Hengdi Liang (<hengdili@usc.edu>) at the University of Southern California.


## Usage

There are two ways to run a model using the AWESOME OCIM:
  - **Using the graphical user interface (GUI)**:
    Set model inputs and plot composite maps/profiles/sections from observational data or model outputs. For this, just run
    
    ```matlab
    >> launchGUI
    ```
    
    (If it's your first time using the AWESOME OCIM, you should start there.)

  - **Writing code**: Simply run
  
    ```matlab
    >> SetupSingle
    ```
    
    And chose your model parameters by modifying the `do` structure.

## Reference

If you use the AWESOME OCIM in your research, you should cite

> John, S. G., Liang, H., Weber, T., Devries, T., Primeau, F., Moore, K., Holzer, M., Mahowald, N., Gardner, W., Mishonov, A., Richardson, M., J., Faugere, Y., and Taburet, G. (2020). *AWESOME OCIM: A simple, flexible, and powerful tool for modeling elemental cycling in the oceans*. Chemical Geology, 533, 119403. doi: 10.1016/j.chemgeo.2019.119403](https://doi.org/10.1016/j.chemgeo.2019.119403

(Or you can export the citation by clicking on the [doi: 10.1016/j.chemgeo.2019.119403](https://doi.org/10.1016/j.chemgeo.2019.119403) and then on the "Export" button)

