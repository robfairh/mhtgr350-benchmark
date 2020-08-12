vel = 2.657e3

[Mesh]
  [./gen_mesh]
    type = GeneratedMeshGenerator
    dim = 1
    xmin = 0
    xmax = 793
    nx = 100
    # elem_type = EDGE2
  [../]
[]

[Problem]
  kernel_coverage_check = off
[]

[Variables]
  [./temp]
    family = MONOMIAL
    order = CONSTANT
    fv = true
    initial_condition = 490
  [../]
[]

[FVKernels]
  [./advection]
    type = MatFVAdvection
    variable = temp
    velocity = '${vel} 0 0'
    rho = 4.37e-6
    cp = 5.188e3
  [../]
  [force]
    type = FVBodyForce
    variable = temp
    function = 'heat_source'
  []
[]

[Functions]
  [./heat_source]
    type = ParsedFunction
    value = '56.03 * sin( pi/793 * x)'
  [../]
[]

[FVBCs]
  [left]
    type = FVDirichletBC
    variable = temp
    boundary = left
    value = 490
  []
  [./fv_outflow]
    type = MatFVConstantScalarOutflowBC
    velocity = '${vel} 0 0'
    variable = temp
    boundary = 'right'
    rho = 4.37e-6
    cp = 5.188e3
  [../]
[]

[Executioner]
  type = Steady

  petsc_options_iname = '-pc_type'
  petsc_options_value = 'lu'
  petsc_options = '-snes_converged_reason'
  nl_abs_tol = 1e-7
  nl_rel_tol = 1e-8
[]

[Outputs]
  exodus = true
[]
