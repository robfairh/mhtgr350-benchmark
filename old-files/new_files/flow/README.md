Notes on MOOSE: INS
-------------------
* INSAction: /home/roberto/projects/moose/modules/navier_stokes/test/tests/ins/pressure_channel/open_BC_action.i

* PSPG and SUPG introduce a lot of dissipation when using first order, the simulations run a lot faster though

* If using 'INSMomentumTractionForm', laplace = false

* BCs:

No outlet BC:
Outlier Variable Residual Norms:
  vel_y: 2.670122e-15
-3.926991e-01 |   3.926991e-01

Outlet BC:
Outlier Variable Residual Norms:
  vel_y: 2.735074e-15
-3.926991e-01 |   3.926993e-01

It would seem that the outflow BC doesn't do anything

Notes on PETSC:
---------------

1)
petsc_options_iname = '-pc_type -sub_pc_type -sub_pc_factor_levels'
petsc_options_value = 'bjacobi  ilu          4'
line_search = 'none'

2)
petsc_options_iname = '-ksp_gmres_restart -pc_type -sub_pc_type -sub_pc_factor_levels'
petsc_options_value = '300                bjacobi  ilu          4'
line_search = 'none'

2) uses less linear iterations than 1.


PC:
preconditioners, including multigrid, block solvers, and sparse direct solvers

pc_type:
bjacobi vs lu: lu makes the linear solver converge much faster

Notes on MOOSE: MeshModifiers
-----------------------------
[MeshModifiers]
  [./middle_node]
    type = AddExtraNodeset
    new_boundary = 'righ_bottom'
    coord = '5 0'
  [../]
[]

More notes on PetSc:
--------------------
* ksp: linear solver

* snes: newton based nonlinear solver