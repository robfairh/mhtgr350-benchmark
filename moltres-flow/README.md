* cg-advec1:
	- Pseudo 1D problem
	- uses continues galerkin methods

* dg-advec1:
	- Pseudo 1D problem
	- uses discontinuous galerkin methods

* fv-advection:
	- solves advection equation in 1D
	- uses finite volume kernels

* fv-burguers:
	- solves burgers in 1D
	- uses finite volume kernels

* fv-tempadvection:
	- solves advection equation for the temperature in 1D
	- uses finite volume kernels
	- uses a volumetric source

* fv-tempadvection2D:
	- solves advection equation for the temperature in pseudo-1D
	- uses finite volume kernels
	- works until the volumetric source
	- if I change it by the neumann function: segfault

* fv-tempdiffusion2D:
	- solves diffusion equation for the temperature in 2D.
	- uses finite volume kernels

* fv-temp2D:
	- solves advection equation for the temperature in 2D for 2 materials.
	- one material diffuses and the other one advects.
	- uses finite volume kernels

* fv-temp2DC:
	- solves advection equation for the temperature in 2D for 2 materials.
	- uses finite volume kernels and cg
	- segfault

Compressible flow
* cns-notes: Tries to break down CNS Action
* cg-cns: tries to implement CNS Action
* cg-cns2: tries to implement CNS Action using kernels
* fv-euler1: tries to implement euler equations

SQUIRREL:
---------
euler2, euler3:
* fv_euler2.i, fv_euler3.i
* These all can be deleted eventually
* ADCoupledVelocityMaterial: copied from MooseTestApp
* FVEnergy: d/dx (ue + up)
* FVEnergyOutflowBC: d/dx (ue + up)
* ADMomentumMaterial:
	- calcualtes vel, rho*u, p = 0.01 (\gamma-1) (e - rho u^2/2)

euler4, ..., euler9:
* FVMomentum: d/dx \rho u^2 + coef * p
* FVMomentumOutflowBC: d/dx \rho u^2 + coef * p
* FVPressDrop: coef * \rho u^2

* MatFVTemperature: d/dx (cp * rho * T  * u)
* MatFVTemperatureOutflowBC: d/dx (cp * rho * T  * u)

* ADEulerMaterial:
	- calculates: vel, rho*u, rho*T, p=\rho R T
