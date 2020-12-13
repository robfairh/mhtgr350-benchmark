* 1D-fuel.geo:
	- Fuel. 
	* 1D-fuel.msh

* 1D-fuel-reflec.geo: 
	- Fuel, bottom, and top reflectors. 
	- Bottom and top reflector are different materials.
	* 1D-fuel-reflec.msh


* 1D-fuel.i
	- 1D-fuel.msh
	- Transient problem.

* 1D-fuel-action.i
	- generated mesh in libmesh
	- kernels defined using actions

* 1D-fuel-reflec.i
	- 1D-fuel-reflec.msh
	- Transient problem.