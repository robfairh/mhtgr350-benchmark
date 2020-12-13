* 1D-fuel.geo:
	- Fuel. 
	* 1D-fuel.msh

* 1D-fuel-reflec.geo: 
	- Fuel, bottom, and top reflectors. 
	- Bottom and top reflector are different materials.
	* 1D-fuel-reflec.msh


* 1D-assembly-eig.i
	- 1D-fuel-reflec.msh
	- Eigenvalue problem: InversePowerMethod
	- Fuel column cross sections.

* 1D-fuel-eig.i
	- 1D-fuel.msh
	- Eigenvalue problem: InversePowerMethod

* 1D-fuel-refleci-eig1.i
	- 1D-fuel-reflec.msh
	- Eigenvalue problem: InversePowerMethod

* 1D-fuel-reflec-eig2.i
	- 1D-fuel-reflec.msh
	- Eigenvalue problem: NonlinearEigen


* FDM-1D.ipynb
	* solves 1D-fuel-eig
	* solves 1D-fuel-reflec-eig
	* solves 1D-assembly-eig