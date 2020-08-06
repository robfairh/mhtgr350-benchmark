* cg-advec1:
	- Pseudo 1D problem
	- uses continues galerkin methods

* dg-advec1:
	- Pseudo 1D problem
	- uses discontinuous galerkin methods

* fv-burguers:
	- solves burgers in 1D
	- uses finite volume kernels

* fv-advection:
	- solves advection equation in 1D
	- uses finite volume kernels

* fv-tempadvection:
	- solves advection equation for the temperature in 1D
	- uses finite volume kernels
	- uses a volumetric source

* fv-tempadvection2D:
	- solves advection equation for the temperature in pseudo-1D
	- uses finite volume kernels
	- uses a neumann function: segfault

* fv-tempadvection2DB:
	- solves advection equation for the temperature in 2D for 3 materials.
	- uses finite volume kernels and cg
