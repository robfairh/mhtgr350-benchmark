* 3D-assembly-30deg-reflec.geo:
	- geometry of 1/6 of the fuel assembly.
	- coolant channels don't go through the reflector

* 3D-unitcell.geo:
	- Unit cell.
	- No reflectors.

* 3D-unitcell-reflec.geo:
	- Unit cell.
	- Moderator and reflectors are 3 different materials.
	- Reflector does not include coolant holes.

* 3D-unitcell-reflecB.geo:
	- Unit cell.
	- Moderator and reflectors are 3 different materials.
	- Coolant channel goes across the reflector.


* 3D-assembly-action.i:
	- Transient problem.
	- Defines Nt action instead of kernels.

* 3D-assembly-homo-action.i:
	- Transient problem.
	- Defines Nt action instead of kernels.
	- Fuel, moderator, and coolant are homogenized.

* 3D-unitcell.i
	- 3D-unitcell.msh
	- Transient problem.
	- Defines Nt action instead of kernels.

* 3D-unitcell-reflec.i:
	- 3D-unitcell-reflec.msh
	- Transient problem.
	- Defines Nt action instead of kernels.

* 3D-unitcell-reflec-homo.i:
	- 3D-unitcell-reflec.msh
	- Transient problem.
	- Defines Nt action instead of kernels.
