scale = 6e-5

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
    scaling = 1e7
  [../]
  [./u]
    family = MONOMIAL
    order = CONSTANT
    fv = true
    initial_condition = 2.657e3
    scaling = 1e-2
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
  [adv_u] # d/dx (rho*u * u + p)
    type = FVMomentum
    variable = u

    advected_quantity = 'rho_u'
    vel = 'vel'
    p = 'pres'
    coef = ${scale}
  []
  [./friction_u] # c1 * rho * u * u
    type = FVPressDrop
    variable = u
    rho = rho
    #coef = 2.9e-2
    coef = 1e-4
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
    rgas = 2.077e7 # cm2/s2/K

    velocity = 'vel'
    rho_u = 'rho_u'
    rho_T = 'rho_T'
    pressure = 'pres'
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
    type = FVMomentumOutflowBC
    variable = u
    boundary = right

    advected_quantity = 'rho_u'
    vel = 'vel'
    p = 'pres'
    coef = ${scale}
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
  solve_type = 'NEWTON'

  #petsc_options_iname = '-pc_type'
  #petsc_options_value = 'lu'
  #petsc_options = '-snes_converged_reason'

  petsc_options = '-snes_converged_reason -ksp_converged_reason -snes_linesearch_monitor'
  petsc_options_iname = '-pc_type -sub_pc_type -pc_asm_overlap -sub_ksp_type -snes_linesearch_minlambda'
  petsc_options_value = 'asm      lu           1               preonly       1e-3'

  nl_abs_tol = 1e-7
  nl_rel_tol = 1e-8
[]

[Preconditioning]
  [./SMP]
    type = SMP
    full = true
  [../]
[]

[Outputs]
  exodus = true
[]
