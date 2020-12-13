[GlobalParams]
  integrate_p_by_parts = true
  laplace = true
  gravity = '0 0 0'
  supg = true
  pspg = true
  order = FIRST
[]

[Mesh]
 file = test6B.msh
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
    boundary = 'cool_top channel_wall channel_flat plenum_wall plenum channel1_bot channel2_bot channel3_bot'
    value = 0
  [../]
  [./vel_y_null]
    type = DirichletBC
    preset = true
    variable = vel_y
    boundary = 'cool_top channel_wall channel_flat plenum_wall plenum channel1_bot channel2_bot channel3_bot'
    value = 0
  [../]

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
  file_base = 'ns07B'
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
    boundary = 'channel1_bot channel2_bot channel3_bot'
    execute_on = 'timestep_end'
  [../]
  [./channel1_in]
    type = SideIntegralVariablePostprocessor
    variable = vel_z
    boundary = 'channel1_top'
    execute_on = 'timestep_end'
    outputs = 'csv'
  [../]
  [./channel2_in]
    type = SideIntegralVariablePostprocessor
    variable = vel_z
    boundary = 'channel2_top'
    execute_on = 'timestep_end'
    outputs = 'csv'
  [../]
  [./channel3_in]
    type = SideIntegralVariablePostprocessor
    variable = vel_z
    boundary = 'channel3_top'
    execute_on = 'timestep_end'
    outputs = 'csv'
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
[]