[GlobalParams]
  integrate_p_by_parts = true
  laplace = true
  gravity = '0 0 0'
  supg = true
  pspg = true
  order = FIRST
[]

[Mesh]
 file = test7F-1.msh
[]

[Variables]
  [./vel_x]
    # order = SECOND
    # family = LAGRANGE
  [../]
  [./vel_y]
    # order = SECOND
    # family = LAGRANGE
  [../]
  [./vel_z]
    # order = SECOND
    # family = LAGRANGE
  [../]
  [./p]
    # order = FIRST
    # family = LAGRANGE
  [../]
[]

[Kernels]
  [./mass]
    type = INSMass
    variable = p
    u = vel_x
    v = vel_y
    w = vel_z
    p = p
  [../]
  [./x_momentum_space]
    type = INSMomentumLaplaceForm
    variable = vel_x
    u = vel_x
    v = vel_y
    w = vel_z
    p = p
    component = 0
  [../]
  [./y_momentum_space]
    type = INSMomentumLaplaceForm
    variable = vel_y
    u = vel_x
    v = vel_y
    w = vel_z
    p = p
    component = 1
  [../]
  [./z_momentum_space]
    type = INSMomentumLaplaceForm
    variable = vel_z
    u = vel_x
    v = vel_y
    w = vel_z
    p = p
    component = 2
  [../]
[]

[BCs]
  [./vel_x_null]
    type = DirichletBC
    preset = true
    variable = vel_x
    boundary = 'cool_top channel_wall plenum_wall plenum channel_flat'
    value = 0
  [../]
  [./vel_y_null]
    type = DirichletBC
    preset = true
    variable = vel_y
    boundary = 'cool_top channel_wall plenum_wall plenum channel_flat'
    value = 0
  [../]

  # [./vel_x_null]
  #   type = DirichletBC
  #   preset = true
  #   variable = vel_x
  #   boundary = 'cool_top channel_wall plenum_wall plenum channel123_flat'
  #   value = 0
  # [../]
  # [./vel_y_null]
  #   type = DirichletBC
  #   preset = true
  #   variable = vel_y
  #   boundary = 'cool_top channel_wall plenum_wall plenum channel123_flat'
  #   value = 0
  # [../]
  # [./InclinedNoDisplacementBC]
  #   [./right]
  #     boundary = 'channel4_flat'
  #     penalty = 1.0
  #     displacements = 'vel_x vel_y'
  #   [../]
  # [../]

  [./vel_z_no_slip]
    type = DirichletBC
    preset = true
    variable = vel_z
    boundary = 'channel_wall'
    value = 0
  [../]
  [./vel_z_null]
    type = DirichletBC
    preset = true
    variable = vel_z
    boundary = 'plenum'
    value = 0
  [../]

  [./vel_in]
    type = FunctionDirichletBC
    boundary = 'cool_top'
    variable = vel_z
    function = 'inlet_func'
  [../]

  # [./p_out]
  #   type = DirichletBC
  #   preset = true
  #   variable = p
  #   boundary = 'channel1_bot channel2_bot channel3_bot'
  #   value = 0
  # [../]
[]

[Functions]
  [./inlet_func]
    type = ParsedFunction
    value = '-30'
  [../]
[]

[Materials]
  [./const]
    type = GenericConstantMaterial
    prop_names = 'rho mu'
    # prop_values = '1. 1.'
    prop_values = '4.3679e-6 3.8236e-7'
  [../]
[]

[Preconditioning]
  [./SMP_PJFNK]
    type = SMP
    full = true
    # solve_type = PJFNK
    solve_type = Newton
  [../]
[]

[Executioner]
  type = Steady

  petsc_options = '-snes_converged_reason -ksp_converged_reason -snes_linesearch_monitor'
  petsc_options_iname = '-pc_type -sub_ksp_type -snes_linesearch_minlambda'
  petsc_options_value = 'lu       preonly       1e-3'

  # petsc_options_iname = '-pc_type -sub_pc_factor_levels -ksp_gmres_restart'
  # petsc_options_value = 'asm      4                     200'
  # line_search = 'none'

  # petsc_options_iname = '-ksp_gmres_restart -pc_type -sub_pc_type -sub_pc_factor_levels'
  # petsc_options_value = '300                bjacobi  ilu          4'
  # line_search = 'none'

  l_tol = 1e-6
  l_max_its = 300

  nl_rel_tol = 1e-12
  nl_max_its = 20
[]

[Outputs]
  file_base = 'ns07F-2'
  execute_on = 'final'
  exodus = true
  csv = true
[]

[Postprocessors]
  [./flow_in]
    type = VolumetricFlowRate
    vel_x = vel_x
    vel_y = vel_y
    vel_z = vel_z
    boundary = 'cool_top'
    execute_on = 'timestep_end'
  [../]
  [./flow_out]
    type = VolumetricFlowRate
    vel_x = vel_x
    vel_y = vel_y
    vel_z = vel_z
    boundary = 'channel1_bot channel2_bot channel3_bot channel4_bot channel5_bot channel6_bot channel7_bot channel8_bot channel9_bot channel10_bot channel11_bot channel12_bot channel13_bot'
    execute_on = 'timestep_end'
  [../]
  [./channel1_fr]
    type = VolumetricFlowRate
    vel_x = vel_x
    vel_y = vel_y
    vel_z = vel_z
    boundary = 'channel1_bot'
    execute_on = 'timestep_end'
  [../]
  [./channel2_fr]
    type = VolumetricFlowRate
    vel_x = vel_x
    vel_y = vel_y
    vel_z = vel_z
    boundary = 'channel2_bot'
    execute_on = 'timestep_end'
  [../]
  [./channel3_fr]
    type = VolumetricFlowRate
    vel_x = vel_x
    vel_y = vel_y
    vel_z = vel_z
    boundary = 'channel3_bot'
    execute_on = 'timestep_end'
  [../]
  [./channel4_fr]
    type = VolumetricFlowRate
    vel_x = vel_x
    vel_y = vel_y
    vel_z = vel_z
    boundary = 'channel4_bot'
    execute_on = 'timestep_end'
  [../]
  [./channel5_fr]
    type = VolumetricFlowRate
    vel_x = vel_x
    vel_y = vel_y
    vel_z = vel_z
    boundary = 'channel5_bot'
    execute_on = 'timestep_end'
  [../]
  [./channel6_fr]
    type = VolumetricFlowRate
    vel_x = vel_x
    vel_y = vel_y
    vel_z = vel_z
    boundary = 'channel6_bot'
    execute_on = 'timestep_end'
  [../]
  [./channel7_fr]
    type = VolumetricFlowRate
    vel_x = vel_x
    vel_y = vel_y
    vel_z = vel_z
    boundary = 'channel7_bot'
    execute_on = 'timestep_end'
  [../]
  [./channel8_fr]
    type = VolumetricFlowRate
    vel_x = vel_x
    vel_y = vel_y
    vel_z = vel_z
    boundary = 'channel8_bot'
    execute_on = 'timestep_end'
  [../]
  [./channel9_fr]
    type = VolumetricFlowRate
    vel_x = vel_x
    vel_y = vel_y
    vel_z = vel_z
    boundary = 'channel9_bot'
    execute_on = 'timestep_end'
  [../]
  [./channel10_fr]
    type = VolumetricFlowRate
    vel_x = vel_x
    vel_y = vel_y
    vel_z = vel_z
    boundary = 'channel10_bot'
    execute_on = 'timestep_end'
  [../]
  [./channel11_fr]
    type = VolumetricFlowRate
    vel_x = vel_x
    vel_y = vel_y
    vel_z = vel_z
    boundary = 'channel11_bot'
    execute_on = 'timestep_end'
  [../]
  [./channel12_fr]
    type = VolumetricFlowRate
    vel_x = vel_x
    vel_y = vel_y
    vel_z = vel_z
    boundary = 'channel12_bot'
    execute_on = 'timestep_end'
  [../]
  [./channel13_fr]
    type = VolumetricFlowRate
    vel_x = vel_x
    vel_y = vel_y
    vel_z = vel_z
    boundary = 'channel13_bot'
    execute_on = 'timestep_end'
  [../]
[]