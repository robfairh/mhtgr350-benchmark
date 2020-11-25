References:
-----------
[1] Kang et al. Thermo-mechanical analysis of the prismatic fuel assembly of VHTR in normal operational condition. 2012.
[2] Lejeail and Cabrillat. CALCULATION OF THERMAL STRESSES IN GRAPHITE FUEL BLOCKS. 2005.

[2]:
- The fuel elements are included for the thermal calculation but are excluded for the mechanical part.
- generalized plane strain condition: assumes that each cross section will remain a plane cross section.

The axial force is zero, which means that the axial displacement of the whole section should follow the thermal expansion and irradiation shrinkage without stress, in case of uniform temperature loading.

Not sure what they used. They say they used the generalized plane strains condition, but they say that epsilon_zz != 0 and sigma_zz = 0.

I think I should use the real generalized plane strain condition, in which epsilon_zz = 0 amd sigma_zz != 0.
Which is the case if the assembly is constrained in the z-direc.

Geometries:
-----------
* mech1.geo: triangle
* mech2.geo: triangular prism
* case1.geo:
    - central hole has coolant in it
    - no LBPs
* case4.geo:
    - central hole has coolant in it
    - 1 LBP

Case 1:
    - No LBPs
    - z = 2 * L/5

Case 4:
    - LBPs
    - z = 0

Input:
------
* ms01.i:
	- displacements caused by gravity
	- calculates thermal strains

* ms02.i:
	- same as before but uses tensor mechanics action

* ms03.i:
	- derived from ms01
	- mech1.geo: triangle
		- requires setting order 2
	- uses inclined BC

* ms04.i:
	- derived from ms02
	- mech2.geo: triangular prism
		- requires setting order 2
		- no recombination should be used (not sure)
	- uses inclined BC

* input.i: case4 thermal fluids
* input2.i: mechanics + steady
* input2B.i: mechanics + transient = generalized plane strain
* input3.i: case4 thermal fluids + mechanics

moose has a generalized_plane_strain_finite example, but it requires a transient executioner, don't know why

For the report:
---------------
# Equations

* Constitutive relations:
    - $\epsilon_x = \frac{1}{E}[\sigma_x - \nu(\sigma_y + \sigma_z)]$
    - $\epsilon_y = \frac{1}{E}[\sigma_y - \nu(\sigma_x + \sigma_z)]$
    - $\epsilon_z = \frac{1}{E}[\sigma_z - \nu(\sigma_x + \sigma_y)]$
    - $\gamma_{xy} = \frac{1}{G}\tau_{xy}$
    - $\gamma_{xz} = \frac{1}{G}\tau_{xz}$
    - $\gamma_{yz} = \frac{1}{G}\tau_{yz}$

* Equilibrium equations:
    - $\frac{\partial}{\partial x} \sigma_x + \frac{\partial}{\partial y} \tau_{xy} + \frac{\partial}{\partial z} \tau_{xz} + \rho g_x = 0$
    - $\frac{\partial}{\partial x} \tau_{xy} + \frac{\partial}{\partial y} \sigma_y + \frac{\partial}{\partial z} \tau_{yz} + \rho g_y = 0$
    - $\frac{\partial}{\partial x} \tau_{xz} + \frac{\partial}{\partial y} \tau_{yz} + \frac{\partial}{\partial z} \sigma_z + \rho g_z = 0$

* Deformation equations:
    - $\epsilon_x = \frac{\partial u}{\partial x}$
    - $\epsilon_y = \frac{\partial v}{\partial y}$
    - $\epsilon_z = \frac{\partial w}{\partial z}$
    - $\gamma_{xy} = \frac{\partial v}{\partial x} + \frac{\partial u}{\partial y}$
    - $\gamma_{yz} = \frac{\partial w}{\partial y} + \frac{\partial v}{\partial z}$
    - $\gamma_{xz} = \frac{\partial w}{\partial x} + \frac{\partial u}{\partial z}$
