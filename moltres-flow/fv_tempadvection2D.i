[Mesh]
  type = GeneratedMesh
  dim = 2
  nx = 1
  ny = 100
  xmax = 2
  ymax = 100
  elem_type = QUAD4
[../]

[Problem]
  kernel_coverage_check = off
[]

[Variables]
  [./v]
    family = MONOMIAL
    order = CONSTANT
    initial_condition = 930
    fv = true
  [../]
[]

[FVKernels]
  [./time]
    type = MatFVTimeKernel
    variable = v
    rho = 1e-2
    cp = 2e3
  [../]
  [./advection]
    type = MatFVAdvection
    variable = v
    velocity = '0 0.5 0'
    rho = 1e-2
    cp = 2e3
  [../]
  [force]
   type = FVBodyForce
   variable = v
   function = 'heat_source'
  []
[]

[FVBCs]
  [./fv_outflow]
    type = MatFVConstantScalarOutflowBC
    velocity = '0 0.5 0'
    variable = v
    boundary = top
    rho = 1e-2
    cp = 2e3
  [../]
  [left]
    type = FVDirichletBC
    variable = v
    boundary = bottom
    value = 930
  []
[]

# [BCs]
#   [./heat_wall]
#     boundary = right
#     type = FunctionNeumannBC
#     variable = v
#     function = 'heat_source'
#   [../]
# []

[Functions]
  [./heat_source]
    type = ParsedFunction
    value = '10 * sin( pi/100 * y)'
  [../]
[]

[Executioner]
  type = Transient
  petsc_options_iname = '-pc_type'
  petsc_options_value = 'lu'
  petsc_options = '-snes_converged_reason'
  nl_abs_tol = 1e-7
  nl_rel_tol = 1e-8
  num_steps = 250
  dt = 1
[]

[Outputs]
  exodus = true
[]
