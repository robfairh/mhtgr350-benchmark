Input files:
------------

* nsad00.i
	- generated mesh 2D: one channel
	- uses pspg, supg, first order

rho=mu=vel=1

Uses:
petsc_options_iname = '-pc_type -sub_pc_type -sub_pc_factor_levels'
petsc_options_value = 'bjacobi  ilu          4'

xmax=5, nx=40, ny=20, in=1.0, out=0.9814
xmax=20, nx=40, ny=20, in=1.0, out=0.7770
xmax=20, nx=40, ny=40, in=1.0, out=0.7787, and it takes more iterations to converge
xmax=20, nx=80, ny=20, in=1.0, out=0.9345
xmax=100, nx=40, ny=20, it doesn't converge
xmax=100, nx=80, ny=20, it doesn't converge
xmax=100, nx=100, ny=20, in=1.0, out=0.4586
xmax=100, nx=160, ny=20, in=1.0, out=0.6876
xmax=100, nx=300, ny=20, in=1.0, out=0.8888, memory = 4.380000e+02
xmax=100, nx=500, ny=20, it doesn't converge
xmax=200, nx=300, ny=20, in=1.0, out=0.6585, memory = 4.370000e+02
xmax=800, nx=2400, ny=20, it doesn't converge

Uses:
petsc_options_iname = '-pc_type -sub_ksp_type -snes_linesearch_minlambda'
petsc_options_value = 'lu       preonly       1e-3'

xmax=100, nx=300, ny=20, in=1.0, out=0.8888, memory = 4.560000e+02
xmax=100, nx=500, ny=20, in=1.0, out=0.9567
xmax=800, nx=1000, ny=20, it doesn't converge
xmax=800, nx=1600, ny=20, it doesn't converge
xmax=800, nx=2400, ny=20, in=1.0, out=0.8888, memory=1.087000e+03, converges in 3 nl iterations
xmax=800, nx=3200, ny=20, in=1.0, out=0.9345, memory=1.324000e+03, converges in 3 nl iterations

Uses:
petsc_options_iname = '-pc_type -pc_factor_shift_type'
petsc_options_value = 'lu       NONZERO'
line_search = 'none'

xmax=800, nx=2400, ny=20, in=1.0, out=0.8888, memory=1.092000e+03, converges in 3 nl iterations

Uses:
petsc_options_iname = '-pc_type -sub_pc_type -pc_factor_shift_type'
petsc_options_value = 'lu       lu           NONZERO'
line_search = 'none'

xmax=800, nx=2400, ny=20, in=1.0, out=0.8888, memory=1.092000e+03, converges in 3 nl iterations

Comments:
- The vel in x decreases at the entry and grows at the outlet
- There is a component in the y-direction near the inlet and the outlet
- This is caused by using first order basis functions

	- rho=4.3679e-6, mu=3.8236e-7, vel=2865

xmax=5, nx=40, ny=20, in=2865, out=2832, memory = 3.780000e+02

With
petsc_options_iname = '-pc_type -sub_pc_type -sub_pc_factor_levels'
petsc_options_value = 'bjacobi  ilu          4'
the linear solver fails to converge

With
petsc_options_iname = '-pc_type -sub_ksp_type -snes_linesearch_minlambda'
petsc_options_value = 'lu       preonly       1e-3'
it works

xmax=1000, nx=2000, ny=20

With
petsc_options_iname = '-pc_type -sub_ksp_type -snes_linesearch_minlambda'
petsc_options_value = 'lu       preonly       1e-3'
it doesn't converge

With
petsc_options_iname = '-pc_type -pc_factor_shift_type'
petsc_options_value = 'lu       NONZERO'
line_search = 'none'
it doesn't converge

xmax=1000, nx=3000, ny=20, in=2865, out=2830

With
petsc_options_iname = '-pc_type -sub_ksp_type -snes_linesearch_minlambda'
petsc_options_value = 'lu       preonly       1e-3'
it converged in 11 nl iterations, memory=1.261000e+03

petsc_options_iname = '-pc_type -pc_factor_shift_type'
petsc_options_value = 'lu       NONZERO'
line_search = 'none'
it converged in 10 nl iterations, memory=1.265000e+03

xmax=1000, nx=3000, ny=10, in=2865, out=2821

With
petsc_options_iname = '-pc_type -sub_ksp_type -snes_linesearch_minlambda'
petsc_options_value = 'lu       preonly       1e-3'
it converged in 8 nl iterations, memory=8.440000e+02

xmax=1000, nx=2000, ny=10, in=2865, out=2817

With
petsc_options_iname = '-pc_type -sub_ksp_type -snes_linesearch_minlambda'
petsc_options_value = 'lu       preonly       1e-3'
it converged in 7 nl iterations, memory=6.990000e+02

xmax=1000, nx=1000, ny=10, it didn't converge
xmax=1000, nx=1500, ny=10, in=2865, out=2817

With
petsc_options_iname = '-pc_type -sub_ksp_type -snes_linesearch_minlambda'
petsc_options_value = 'lu       preonly       1e-3'
it converged in 9 nl iterations, memory=5.820000e+02

* nsad01.i
	- generated mesh 3D: one channel
	- uses pspg, supg, first order

rho=mu=vel=1
zmax=10, nz=40, nx=ny=10, in=-1, out=0.8451, memory=1.321000e+03
zmax=1000, nz=400, nx=ny=10, in=-1, out=0.0659, memory=4.792000e+03
zmax=1000, nz=1000, nx=ny=10, in=-1, out=0.3129, memory=7.942000e+03, 4 nl iterations
zmax=1000, nz=1500, nx=ny=10, in=-1, out=0.5015, memory=1.190000e+04, 4 nl iterations
zmax=1000, nz=2000, nx=ny=15, OOM

rho=4.3679e-6, mu=3.8236e-7, vel=2865
zmax=5, nz=20, nx=ny=10, in=-2865, out=2864, memory=1.075000e+0e3, 8 nl iterations
zmax=100, nz=200, nx=ny=10, in=-2865, out=2863, memory=2.895000e+0e3, 7 nl iterations
zmax=1000, nz=200, nx=ny=10, in=-2865, out=2864, memory=1.880000e+0e4, 7 nl iterations

* nsad02.i
	- mesh 3D: cooling channel
	- uses pspg, supg, first order

rho=mu=vel=1
H=5, nz=20, - , in=0.9766, out=0.9092
H=1000, nz=2000, circlepoints=10, CharacteristicLengthFactor=0.8, in=0.8026, out=0.5241, memory=1.679000e+03
H=1000, nz=3000, circlepoints=10, CharacteristicLengthFactor=0.8, in=0.8026, out=0.5241, memory=2.080000e+03
H=1000, nz=2000, circlepoints=15, CharacteristicLengthFactor=0.6, in=0.9291, out=0.7297, memory=3.526000e+03
H=1000, nz=2000, circlepoints=20, CharacteristicLengthFactor=0.6, in=0.9532, out=0.7698, memory=4.910000e+03

Comments:
- The vel in x decreases at the entry and grows at the outlet
- There is a component in the y-direction near the inlet and the outlet
- This is caused by using first order basis functions

rho=4.3679e-6, mu=3.8236e-7, vel=2865
H=1000, nz=2000, circlepoints=20, CharacteristicLengthFactor=0.6, in=2730,out=2730, memory=4.931000e+03
H=1000, nz=2000, circlepoints=30, CharacteristicLengthFactor=0.8, in=2808,out=2807, memory=1.314300e+04

* nsad03.i
	- mesh 3D: test6.msh: 3 cooling channels
	- uses pspg, supg, first order
	- rho=mu=vel=1
	- H=5, nz=20





Needs reviewing:

* nsad04.i
	- mesh 3D: test7.msh, assembly geometry
	- uses pspg, supg, first order

rho=mu=vel=1
H1=H2=5, n1=n2=20, circlepoints=10, CharacteristicLengthFactor=1, in=93.53, in2=96.28, out=74.06, memory=2.426000e+03
H1=20, H2=5, n1=80, n2=20, circlepoints=10, CharacteristicLengthFactor=1, in=93.53, in2=96.32, out=74.05, memory=2.839000e+03
H1=100, H2=5, n1=200, n2=20, circlepoints=10, CharacteristicLengthFactor=1, in=93.53, in2=82.72, out=66.33, memory=3.543000e+03
H1=1000, H2=5, n1=2000, n2=20, circlepoints=10, CharacteristicLengthFactor=1, in=93.53, in2=82.72, out=66.33, memory=3.543000e+03

rho=4.3679e-6, mu=3.8236e-7, vel=366
A) H1=1000, H2=5, n1=2000, n2=20, nl_rel_tol=1e-9, memory=, it didn't converge 
B) H1=1000, H2=5, n1=2500, n2=20, nl_rel_tol=1e-10, memory=, it didn't converge
