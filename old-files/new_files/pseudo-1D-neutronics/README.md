* 2D-fuel.geo:
	- Fuel channel, H = 793.

* 2D-fuel-reflec.geo:
	- Fuel, bottom, and top reflectors.
	- Both reflectors are the same material.


* 2D-fuel-action.i
	- 2D-fuel.msh
	- Transient problem.
	- Uses NT action instead of kernels.

* 2D-fuel-reflec-action.i
	- 2D-fuel-reflec.msh
	- Transient problem.
	- Uses NT action instead of kernels.

* 2D-fuel-reflec-action-delayed.i
	- 2D-fuel-reflec.msh
	- Transient problem.
	- Uses NT and Precursors actions instead of kernels.
	- Uses homogenized cross sections

* 2D-fuel-reflec-action-eig.i
	- 2D-fuel-reflec.msh
	- Eigenvalue problem.
	- Uses NT action instead of kernels.
	- It doesn't work ??