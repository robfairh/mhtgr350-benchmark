[GlobalParams]
  integrate_p_by_parts = false
  laplace = true
  gravity = '0 0 0'
  supg = true
  pspg = true
  order = FIRST
[]

[Mesh]
 file = assembly.msh
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
    variable = vel_x
    preset = true
    boundary = 'cool_top plenum channel_wall channel1_bot channel2_bot channel3_bot channel4_bot channel5_bot channel6_bot channel7_bot channel8_bot channel9_bot channel10_bot channel11_bot channel12_bot channel13_bot'
    value = 0
  [../]
  [./vel_y_null]
    type = DirichletBC
    variable = vel_x
    preset = true
    boundary = 'cool_top plenum channel_wall channel1_bot channel2_bot channel3_bot channel4_bot channel5_bot channel6_bot channel7_bot channel8_bot channel9_bot channel10_bot channel11_bot channel12_bot channel13_bot'
    value = 0
  [../]
  [./vel_z_null]
    type = DirichletBC
    variable = vel_z
    preset = true
    boundary = 'plenum channel_wall'
    value = 0
  [../]

  [./vel_in]
    type = FunctionDirichletBC
    boundary = 'cool_top'
    variable = vel_z
    function = 'inlet_func'
  [../]

  [./p_out]
    type = DirichletBC
    variable = p
    preset = true
    boundary = 'channel1_bot channel2_bot channel3_bot channel4_bot channel5_bot channel6_bot channel7_bot channel8_bot channel9_bot channel10_bot channel11_bot channel12_bot channel13_bot'
    value = 0
  [../]
[]

[Functions]
  [./inlet_func]
    type = ParsedFunction
    value = '-1'
  [../]
[]

[Materials]
  [./const]
    type = GenericConstantMaterial
    prop_names = 'rho mu'
    prop_values = '1. 1.'
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

  # petsc_options_iname = '-ksp_gmres_restart -pc_type -sub_pc_type -sub_pc_factor_levels'
  # petsc_options_value = '300                bjacobi  ilu          4'
  # line_search = 'none'

  # petsc_options = '-snes_converged_reason -ksp_converged_reason -snes_linesearch_monitor'
  # petsc_options_iname = '-pc_type -sub_ksp_type -snes_linesearch_minlambda'
  # petsc_options_value = 'lu       preonly       1e-3'

  # petsc_options_iname = '-pc_type -sub_pc_factor_levels -ksp_gmres_restart'
  # petsc_options_value = 'asm      4                     200'
  # line_search = 'none'

  # petsc_options_iname = '-pc_type -sub_pc_type -sub_pc_factor_levels'
  # petsc_options_value = 'bjacobi  ilu          4'

  petsc_options_iname = '-pc_type -pc_asm_overlap -sub_pc_type -sub_pc_factor_levels  -ksp_gmres_restart'
  petsc_options_value = 'asm      2               ilu          4       200'

  l_tol = 1e-6
  l_max_its = 300

  nl_rel_tol = 1e-12
  nl_max_its = 6
[]

[Outputs]
  file_base = 'assembly'
  execute_on = 'final'
  exodus = true
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
  [./flow_in_channels]
    type = VolumetricFlowRate
    vel_x = vel_x
    vel_y = vel_y
    vel_z = vel_z
    boundary = 'channel1_top channel2_top channel3_top channel4_top channel5_top channel6_top channel7_top channel8_top channel9_top channel10_top channel11_top channel12_top channel13_top'
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
  [./flow_in_channel1]
    type = VolumetricFlowRate
    vel_x = vel_x
    vel_y = vel_y
    vel_z = vel_z
    boundary = 'channel1_top'
    execute_on = 'timestep_end'
  [../]
  [./flow_in_channel2]
    type = VolumetricFlowRate
    vel_x = vel_x
    vel_y = vel_y
    vel_z = vel_z
    boundary = 'channel2_top'
    execute_on = 'timestep_end'
  [../]
  [./flow_in_channel3]
    type = VolumetricFlowRate
    vel_x = vel_x
    vel_y = vel_y
    vel_z = vel_z
    boundary = 'channel3_top'
    execute_on = 'timestep_end'
  [../]
  [./flow_in_channel4]
    type = VolumetricFlowRate
    vel_x = vel_x
    vel_y = vel_y
    vel_z = vel_z
    boundary = 'channel4_top'
    execute_on = 'timestep_end'
  [../]
  [./flow_in_channel5]
    type = VolumetricFlowRate
    vel_x = vel_x
    vel_y = vel_y
    vel_z = vel_z
    boundary = 'channel5_top'
    execute_on = 'timestep_end'
  [../]
  [./flow_in_channel6]
    type = VolumetricFlowRate
    vel_x = vel_x
    vel_y = vel_y
    vel_z = vel_z
    boundary = 'channel6_top'
    execute_on = 'timestep_end'
  [../]
  [./flow_in_channel7]
    type = VolumetricFlowRate
    vel_x = vel_x
    vel_y = vel_y
    vel_z = vel_z
    boundary = 'channel7_top'
    execute_on = 'timestep_end'
  [../]
  [./flow_in_channel8]
    type = VolumetricFlowRate
    vel_x = vel_x
    vel_y = vel_y
    vel_z = vel_z
    boundary = 'channel8_top'
    execute_on = 'timestep_end'
  [../]
  [./flow_in_channel9]
    type = VolumetricFlowRate
    vel_x = vel_x
    vel_y = vel_y
    vel_z = vel_z
    boundary = 'channel9_top'
    execute_on = 'timestep_end'
  [../]
  [./flow_in_channel10]
    type = VolumetricFlowRate
    vel_x = vel_x
    vel_y = vel_y
    vel_z = vel_z
    boundary = 'channel10_top'
    execute_on = 'timestep_end'
  [../]
  [./flow_in_channel11]
    type = VolumetricFlowRate
    vel_x = vel_x
    vel_y = vel_y
    vel_z = vel_z
    boundary = 'channel11_top'
    execute_on = 'timestep_end'
  [../]
  [./flow_in_channel12]
    type = VolumetricFlowRate
    vel_x = vel_x
    vel_y = vel_y
    vel_z = vel_z
    boundary = 'channel12_top'
    execute_on = 'timestep_end'
  [../]
  [./flow_in_channel13]
    type = VolumetricFlowRate
    vel_x = vel_x
    vel_y = vel_y
    vel_z = vel_z
    boundary = 'channel13_top'
    execute_on = 'timestep_end'
  [../]
[]