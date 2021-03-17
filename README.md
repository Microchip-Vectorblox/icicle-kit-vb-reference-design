# PolarFire SoC Icicle Kit Reference Design Generation Tcl Scripts for Vectorblox - Libero v12.6

> **WARNING** This project is in alpha and is subject to sudden and dramatic changes

This design is based on the [icicle-kit-reference-design](https://github.com/polarfire-soc/icicle-kit-reference-design). Most of the usage is the same, and that repository should referenced for documentation regarding most of the system. 

The differences is the addition of the Vectorblox_ss subsystem. 

The project can be built from the command line simply by running `make`.

Alternatively from a system where GNU Make is unavailable, you can simply clone the reference design into this repository: 

    git clone -b2020.12  "https://github.com/polarfire-soc/icicle-kit-reference-design.git"
    
And then from the libero gui click **File** ➞ **Execute Script** and
select `icicle_kit.tcl` as the Script file. 

