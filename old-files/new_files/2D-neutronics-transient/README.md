* 2D-fullcore.geo:
	- Full core 2D-axisymmetric.
	- Inner and outer reflectors.
	- Both reflectors are part of the moderator.
	- No bottom or top reflector.

* 2D-fullcore-reflec.geo:
	- Full core 2D axisymmetric.
	- Moderator and reflectors are defined as 5 different materials.
	- Reflector does not include coolant holes.

* 2D-fullcore-reflecB.geo:
	- Full core 2D axisymmetric.
	- Moderator and reflectors are defined as 5 different materials.
	- Coolant channel goes across the reflector.

* 2D-unitcell.geo:
	- Unit cell 2D axisymmetric.
	- No reflectors.

* 2D-unitcell-reflec.geo:
	- Unit cell 2D axisymmetric.
	- Moderator and reflector are 3 different materials.
	- Reflector does not include coolant holes.

* 2D-unitcell-reflecB.geo:
	- Unit cell 2D axisymmetric.
	- Moderator and reflector are 3 different materials.
	- Coolant channel goes across the reflector.


* 2D-fullcore-reflec-action.i:
	- 2D-fullcore-reflec.msh
	- Transient problem.
	- Uses NT action instead of kernels.

* 2D-fullcore-reflecB-action.i:
	- 2D-fullcore-reflecB.msh
	- Transient problem.
	- Uses NT action instead of kernels.

* 2D-fullcore-reflec-homo-action.i:
	- 2D-fullcore-reflec.msh
	- Transient problem.
	- Uses NT action instead of kernels.
	- Uses homogenized cross sections.

* 2D-unitcell-reflec-action.i
	- 2D-unitcell-reflec.geo
	- Transient problem.
	- Uses NT action instead of kernels.

* 2D-unitcell-reflecB-action.i
	- 2D-unitcell-reflecB.geo
	- Transient problem.
	- Uses NT action instead of kernels.