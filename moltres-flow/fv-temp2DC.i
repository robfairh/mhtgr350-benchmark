[Mesh]
  file = 2D-2mat.msh
[../]

[Problem]
  kernel_coverage_check = off
[]

[Variables]
  [./temp]
    family = LAGRANGE
    order = FIRST
    initial_condition = 930
    block = 'fuel'
  [../]
  [./tempfv]
    family = MONOMIAL
    order = CONSTANT
    initial_condition = 930
    fv = true
    block = 'coolant'
  [../]
[]

[Kernels]
  [./temp_time_derivative]
    type = MatINSTemperatureTimeDerivative
    variable = temp
    block = 'fuel'
  [../]
  [./diffusion]
    type = MatDiffusion
    diffusivity = 'k'
    variable = temp
    block = 'fuel'
  [../]
  [./source]
    type = BodyForce
    variable = temp
    function = heat_source
    block = 'fuel'
  [../]
[]

[Materials]
  [./solids]
    type = GenericConstantMaterial
    prop_names = 'k  cp rho'
    prop_values = '1  1   1' # [J/kg/K] [kg/cm3]
    # block = 'fuel'
  [../]
[]

[FVKernels]
  [./time]
    type = MatFVTimeKernel
    variable = tempfv
    rho = 1e-2
    cp = 2e3
    block = 'coolant'
  [../]
  [./advection]
    type = MatFVAdvection
    variable = tempfv
    velocity = '0 0.5 0'
    rho = 1e-2
    cp = 2e3
    block = 'coolant'
  [../]
[]

[FVBCs]
  [./fv_outflow]
    type = MatFVConstantScalarOutflowBC
    velocity = '0 0.5 0'
    variable = tempfv
    boundary = cool_top
    rho = 1e-2
    cp = 2e3
  [../]
  [left]
    type = FVDirichletBC
    variable = tempfv
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
  num_steps = 250
  dt = 1
[]

[Outputs]
  exodus = true
[]
