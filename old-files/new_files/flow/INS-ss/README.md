Input files:
------------

* ns00.i:
	- Generated mesh 2D: one cooling channel
	- I specify the Delta P and that determines the velocity
	- rho=mu=1

* ns01.i:
	- Generated mesh 2D: one cooling channel
	- imposes the velocity BC

	- uses pspg, supg, first order
	rho=mu=v=1

Comments:
- The vel in x decreases at the entry and grows at the outlet
- There is a component in the y-direction near the inlet and the outlet
- This is caused by using first order basis functions

	rho=4.3679e-6, mu=3.8236e-7, vel=2865

xmax=5, nx=20, ny=20, in=-2865, out=2867
xmax=5, nx=40, ny=20, in=-2865, out=2867
xmax=50, nx=200, ny=20, in=-2865, out=2865
xmax=500, nx=1000, ny=20, in=-2865, out=2865
xmax=500, nx=2000, ny=20, in=-2865, out=2865
xmax=1000, nx=500, ny=20, it didn't converge
xmax=1000, nx=800, ny=20, it didn't converge
xmax=1000, nx=1000, ny=20, in=-2865, out=2865
xmax=1000, nx=2000, ny=20, in=-2865, out=2865, memory=1.624e3

	No scaling: 9 nl iterations
vel_x: 2.08487e-12, vel_y: 2.47419e-13, p:     9.46522e-10
xmax=1000, nx=1000, ny=20, in=-2865, out=2865
	scaling = 1e-2: 8 nl iterations
vel_x: 3.41018e-09, vel_y: 2.99076e-10, p:     1.14844e-08
xmax=1000, nx=1000, ny=20, in=-2865, out=2865

Comments:
- The vel in x decreases at the entry and grows at the outlet

	- uses pspg, supg, second order
	rho=4.3679e-6, mu=3.8236e-7, vel=2865

xmax=1000, nx=2000, ny=20, in=-2865, out=2865, memory=2.427e3

* ns01-3.i:
	- generated mesh 3D: one channel
	- uses pspg, supg, first order
	- rho=mu=vel=1

case1: zmax=5, nz=40, nx=ny=10, in=-9.801000e-01, out=9.096429e-01, memory=1.268000e+03
case4: zmax=1000, nz=1000, nx=ny=10, in=-9.801000e-01, out=3.062132e-01, memory=9.837000e+03
case5: zmax=1000, nz=2000, nx=ny=10, in=-9.801000e-01, out=6.193130e-01, memory=1.853900e+04

	- uses pspg, supg, first order, integrating by parts = true

petsc_options_iname = '-pc_type -sub_ksp_type -snes_linesearch_minlambda'
petsc_options_value = 'lu       preonly       1e-3'

zmax=5, nz=40, in=-9.801000e-01, out=-9.801000e-01, memory=1.273000e+03
the outflow rate is equal but the velocity is not ...

zmax=5, nz=40, nx=ny=10, memory=1535
zmax=100, nz=200, nx=ny=10, memory=3229
zmax=1000, nz=2000, nx=ny=10, memory=20173

	petsc_options_iname = '-pc_type -sub_pc_type -sub_pc_factor_shift_type'
	petsc_options_value = 'asm         lu                    NONZERO'

zmax=5, nz=40, in=-9.801000e-01, out=-9.801000e-01, memory=1.077000e+03
zmax=1000, nz=2000, nx=ny=10, in=-9.801000e-01, out=9.801000e-01, memory=2.221900e+04

the linear solver doesn't converge on BW ... I think it is because of the high number of CPUs
it does on my computer (10 CPUs)

	petsc_options_iname = '-pc_type -sub_pc_type -sub_pc_factor_shift_type'
	petsc_options_value = 'asm         lu                    NONZERO'
	line_search = 'none'

zmax=5, nz=40, nx=ny=10, memory=1293
zmax=100, nz=200, nx=ny=10, memory=2963
zmax=1000, nz=2000, nx=ny=10, memory=23138

	petsc_options_iname = '-pc_type -pc_hypre_type -ksp_gmres_restart'
	petsc_options_value = 'hypre  euclid  200'

The linear solver didn't converge

	petsc_options_iname = '-pc_type -sub_pc_type -pc_factor_shift_type'
	petsc_options_value = 'lu       lu           NONZERO'
	line_search = 'none'

zmax=5, nz=40, nx=ny=10, memory=1539
zmax=1000, nz=2000, nx=ny=10, memory=20194


* ns01-3B.i:
	- mesh 3D: prism.msh, one channel
	- uses pspg, supg
	- rho=mu=vel=1

first order
memory = 1640
flow_inlet = -0.98567616025212
flow_L1 = -1.8548500798881
flow_L4 = -1.8548361768448
flow_outlet = -0.98567616025212

second order
memory = 5645
flow_inlet = -0.99997452626997
flow_L1 = -1.9977618406688
flow_L4 = -1.9977681023096
flow_outlet = -0.99997452626997

it seems that the SideIntegralVariablePostprocessor integrates on both normals of the surface and adds them together, then I get the double of the flow_inlet and flow_outlet.
And also that's why I can't use the VolumetricFlowRate postprocessor on those surfaces, cause it gives 0, as it sums what comes in and what comes out.

* ns02.i:
	- mesh 2D: test1.msh (uses second order elements), plenum and two cooling channels
	- I specify the Delta P and that determines the velocity
	- rho=mu=1

* ns03.i:
	- mesh 2D: test1.msh (uses second order elements), plenum and two cooling channels
	- imposes the velocity BC
	- rho=mu=1

1) second order, no stabilization
2) second order, stabilization
3) first order, stabilization
4) first order, stabilization, integration_by_parts

No much diff between 1) and 2)
4) is better than 3)
and 4) is slightly worse than 2), a good discretization helps, I think this is expected

* ns04.i:
	- mesh 3D: test2-1.msh, one cooling channel
	- I specify the Delta P and that determines the velocity
	- 28731 dofs (used refine splitting once): works
	- rho=mu=1

* ns04B.i:
	- mesh 2D - RZ: test2B.msh, one cooling channel
	- I specify the Delta P and that determines the velocity
	- rho=mu=1

* ns05.i:
	- mesh 3D: test2.msh, one cooling channel
	- imposes a quadratic velocity profile
	- rho=mu=v=1

* ns05B.i:
	- mesh 3D: test2.msh, one cooling channel

	- uses PSPG, SUPG, first order

rho=mu=v=1:
H=5, nz=20, in=0.9766, out=0.9020

Comments:
- The vel in z decreases at the entry and grows at the outlet

rho=4.3679e-6, mu=3.8236e-7, v=2865:
H=5, nz=20, in=2798, out=2797
H=100, nz=200, in=2781, out=2780
H=1000, nz=2000, in=-2.780672e+03, out=2.779859e+03

* ns06.i:
	- mesh 3D: test3.msh, 3D version of test1
	- imposes a quadratic velocity profile
	- uses PSPG, SUPG, first order
	- rho=mu=1
	- H1=H2=5, nz1=nz2=20

- rho=4.3679e-6, mu=3.8236e-7, v=1
- h = 5/25, converged

- rho=4.3679e-6, mu=3.8236e-7, v=100
- h = 5/25, converged


* ns06B.i:
	- mesh 3D: test4.msh, square plenum and two cooling channels
	- imposes a quadratic velocity profile
	- uses PSPG, SUPG, first order

rho=mu=v=1:
H1=H2=5, nz1=nz2=20, in=1, out=0.7021

rho=4.3679e-6, mu=3.8236e-7, v=2865:
H1=H2=5, nz1=nz2=20, in=2865, out=2801

	- uses PSPG, SUPG, first order, integration_by_parts = true
rho=4.3679e-6, mu=3.8236e-7, v=2865:
H1=H2=5, nz1=nz2=20, in=2865, out=2865

* ns06C.i:
	- mesh 3D: test5.msh, square plenum and two cooling channels
	- imposes a quadratic velocity profile
	- uses PSPG, SUPG, first order, integration_by_parts = true

rho=4.3679e-6, mu=3.8236e-7, v=2865/18, converged
rho=4.3679e-6, mu=3.8236e-7, v=630, converged






Needs reviewing:

* ns07.i:
	- mesh 3D: test6.msh, square plenum and three cooling channels

H1=H2=5, nz1=nz2=40
uses PSPG, SUPG, first order, integrate_by_parts = false
- looks fine (besides the first order issue)

uses PSPG, SUPG, first order, integrate_by_parts = true
- looks fine

uses PSPG, SUPG, second order, integrate_by_parts = false
- looks fine
11631424.bw

flow_in:, flow_out

uses PSPG, SUPG, second order, integrate_by_parts = true
- looks almost fine (in the very end, the velocity increases slightly)

* ns07B.i:
	- mesh 3D: test6B.msh, square plenum and three half cooling channels

H1=H2=5, nz1=nz2=40
uses PSPG, SUPG, first order, integrate_by_parts = false
- looks fine (besides the first order issue)

uses PSPG, SUPG, first order, integrate_by_parts = true
- fine if I add the vx=vy=0 bc on the flat 'wall' of the cooling channel

uses PSPG, SUPG, second order, integrate_by_parts = false
- looks fine

uses PSPG, SUPG, second order, integrate_by_parts = true
- fine if I add the vx=vy=0 bc on the flat 'wall' of the cooling channel

uses PSPG, SUPG, second order, integrate_by_parts = false
ns07.i
uses PSPG, SUPG, first order, integrate_by_parts = true
ns07-2.i
uses PSPG, SUPG, second order, integrate_by_parts = false
ns07B-2.i
uses PSPG, SUPG, first order, integrate_by_parts = true
ns07B.i
The inflow rates kinda suck, so I changed them for the outflow rates.
first order, integration_by_parts=true look good if I use the outflow rates

* ns08.i:
	- mesh 3D: test7.msh, fuel assembly
	- uses PSPG, SUPG, first order