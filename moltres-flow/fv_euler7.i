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
  [./adv_rho] # d/dx (rho * u)
    type = FVMatAdvection
    variable = rho

    vel = 'vel'
  [../]

  # u
  [./adv_u] # d/dx (rho*u * u)
    type = FVMatAdvection
    variable = u

    advected_quantity = 'rho_u'
    vel = 'vel'
  [../]

  # temp
  [./adv_temp] # d/dx (cp * rho*T  * u)
    type = MatFVTemperature
    variable = temp

    advected_quantity = 'rho_T'
    vel = 'vel'
    cp = 5.188e3
  [../]
  [./force] # q'''
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
  [./rho_o]
    type = FVMatAdvectionOutflowBC
    variable = rho
    boundary = right

    vel = 'vel'
  [../]

  # u
  [./u_i]
    type = FVDirichletBC
    variable = u
    boundary = left
    value = 2.657e3
  [../]
  [./u_o]
    type = FVMatAdvectionOutflowBC
    variable = u
    boundary = right

    advected_quantity = 'rho_u'
    vel = 'vel'
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
