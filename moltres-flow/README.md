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
* cg-cns: tries to implement CNS Action
* cg-cns2: tries to implement CNS Action using kernels

* fv-euler1: tries to implement euler equations
