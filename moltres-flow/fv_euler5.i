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
  [./rho]
    family = MONOMIAL
    order = CONSTANT
    fv = true
    initial_condition = 4.37e-6
  [../]
  [./u]
    family = MONOMIAL
    order = CONSTANT
    fv = true
    initial_condition = 2.657e3
  [../]
  [./temp]
    family = MONOMIAL
    order = CONSTANT
    fv = true
    initial_condition = 490
  [../]
[]

[FVKernels]
  # rho
  [./adv_rho] # d/dx (1 * rho)
    type = FVAdvection
    variable = rho
    velocity = '1 0 0'
  [../]

  # u
  [./adv_u] # d/dx (1 * u)
    type = FVAdvection
    variable = u
    velocity = '1 0 0'
  [../]

  # temp
  [./adv_temp]
    type = MatFVTemperature
    variable = temp

    advected_quantity = 'rho_T'
    vel = 'vel'
    cp = 5.188e3
  [../]
  [./force]
    type = FVBodyForce
    variable = temp
    function = 'heat_source'
  [../]
[]

[Functions]
  [./heat_source]
    type = ParsedFunction
    value = '56.03 * sin( pi/793 * x)'
  [../]
[]

[Materials]
  [euler_material]
    type = ADEulerMaterial
    rho = rho
    vel_x = u
    temp = temp

    velocity = 'vel'
    rho_u = 'rho_u'
    rho_T = 'rho_T'
  []
[]

[FVBCs]
  # rho
  [./rho_i]
    type = FVDirichletBC
    variable = rho
    boundary = left
    value = 4.37e-6
  [../]
  [./fv_outflow]
    type = FVConstantScalarOutflowBC
    variable = rho
    velocity = '1 0 0'
    boundary = right
  [../]

  # u
  [./u_i]
    type = FVDirichletBC
    variable = u
    boundary = left
    value = 2.657e3
  [../]
  [./u_o]
    type = FVConstantScalarOutflowBC
    velocity = '1 0 0'
    variable = u
    boundary = right
  [../]

  # temp
  [./temp_i]
    type = FVDirichletBC
    variable = temp
    boundary = left
    value = 490
  [../]
  [./temp_o]
    type = MatFVTemperatureOutflowBC
    variable = temp
    boundary = right

    advected_quantity = 'rho_T'
    vel = 'vel'
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
