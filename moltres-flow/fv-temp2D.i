[Mesh]
  file = 2D-2mat.msh
[../]

[Problem]
  kernel_coverage_check = off
[]

[Variables]
  [./temp]
    family = MONOMIAL
    order = CONSTANT
    initial_condition = 930
    fv = true
  [../]
[]

[FVKernels]
  [./time]
    type = MatFVTimeKernel
    variable = temp
    rho = 1e-2
    cp = 2e3
  [../]
  [./advection]
    type = MatFVAdvection
    variable = temp
    velocity = '0 0.5 0'
    rho = 1e-2
    cp = 2e3
    block = 'coolant'
  [../]

  [diff]
    type = FVDiffusion
    variable = temp
    coeff = coeff
    block = 'fuel'
  []
  [force]
   type = FVBodyForce
   variable = temp
   function = 'heat_source'
   block = 'fuel'
  []
[]

[Materials]
  [diff]
    type = ADGenericConstantMaterial
    prop_names = 'coeff'
    prop_values = '1'
  []
[]

[FVBCs]
  [./fv_outflow]
    type = MatFVConstantScalarOutflowBC
    velocity = '0 0.5 0'
    variable = temp
    boundary = cool_top
    rho = 1e-2
    cp = 2e3
  [../]
  [left]
    type = FVDirichletBC
    variable = temp
    boundary = cool_bottom
    value = 930
  []
[]

[Functions]
  [./heat_source]
    type = ParsedFunction
    value = '10 * sin( pi/10 * y)'
    # value = '35' # W/cm3
  [../]
[]

[Executioner]
  type = Transient
  petsc_options_iname = '-pc_type'
  petsc_options_value = 'lu'
  petsc_options = '-snes_converged_reason'
  nl_abs_tol = 1e-7
  nl_rel_tol = 1e-8
  num_steps = 200
  dt = 1
[]

[Outputs]
  exodus = true
[]
