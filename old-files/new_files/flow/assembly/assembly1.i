[GlobalParams]
  integrate_p_by_parts = true
  laplace = true
  gravity = '0 0 0'
  supg = true
  pspg = true
  order = FIRST
[]

[Mesh]
 file = test7.msh
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
    # scaling = 1e-2
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
    # boundary = 'cool_top channel_wall plenum_wall plenum channel1_bot channel2_bot channel3_bot channel4_bot channel5_bot channel6_bot channel7_bot channel8_bot channel9_bot channel10_bot channel11_bot channel12_bot channel13_bot'
    boundary = 'cool_top channel_wall plenum_wall plenum channel1_flat channel2_flat channel3_flat channel4_flat channel5_flat channel6_flat channel10_flat channel13_flat'
    value = 0
  [../]
  [./vel_y_null]
    type = DirichletBC
    preset = true
    variable = vel_y
    # boundary = 'cool_top channel_wall plenum_wall plenum channel1_bot channel2_bot channel3_bot channel4_bot channel5_bot channel6_bot channel7_bot channel8_bot channel9_bot channel10_bot channel11_bot channel12_bot channel13_bot'
    boundary = 'cool_top channel_wall plenum_wall plenum channel1_flat channel2_flat channel3_flat channel4_flat channel5_flat channel6_flat channel10_flat channel13_flat'
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

  # [pressure_pin]
  #   type = DirichletBC
  #   variable = p
  #   boundary = 'channel1_bot channel2_bot channel3_bot channel4_bot channel5_bot channel6_bot channel7_bot channel8_bot channel9_bot channel10_bot channel11_bot channel12_bot channel13_bot'
  #   value = 0
  # [../]

[]

[Functions]
  [./inlet_func]
    type = ParsedFunction
    value = '-1'
    # value = '-366.23'
  [../]
[]

[Materials]
  [./const]
    type = GenericConstantMaterial
    prop_names = 'rho mu'
    prop_values = '1. 1.'
    # prop_values = '4.3679e-6 3.8236e-7'
  [../]
[]

[Preconditioning]
  [./SMP_PJFNK]
    type = SMP
    full = true
    solve_type = Newton
  [../]
[]

[Executioner]
  type = Steady

  petsc_options = '-snes_converged_reason -ksp_converged_reason -snes_linesearch_monitor'
  petsc_options_iname = '-pc_type -sub_ksp_type -snes_linesearch_minlambda'
  petsc_options_value = 'lu       preonly       1e-3'

  # petsc_options_iname = '-pc_type -sub_pc_type -sub_pc_factor_shift_type'
  # petsc_options_value = 'asm         lu                    NONZERO'
  # line_search = 'none'

  l_tol = 1e-6
  l_max_its = 300

  nl_rel_tol = 1e-12
  nl_max_its = 20
[]

[Outputs]
  file_base = 'assembly1'
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
    boundary = 'channel1_bot channel2_bot channel3_bot channel3_bot channel5_bot channel6_bot channel7_bot channel8_bot channel9_bot channel10_bot channel11_bot channel12_bot channel13_bot'
    execute_on = 'timestep_end'
  [../]
  [./channel1_out]
    type = SideIntegralVariablePostprocessor
    variable = vel_z
    boundary = 'channel1_bot'
    execute_on = 'timestep_end'
    outputs = 'csv'
  [../]
  [./channel2_out]
    type = SideIntegralVariablePostprocessor
    variable = vel_z
    boundary = 'channel2_bot'
    execute_on = 'timestep_end'
    outputs = 'csv'
  [../]
  [./channel3_out]
    type = SideIntegralVariablePostprocessor
    variable = vel_z
    boundary = 'channel3_bot'
    execute_on = 'timestep_end'
    outputs = 'csv'
  [../]
  [./channel4_out]
    type = SideIntegralVariablePostprocessor
    variable = vel_z
    boundary = 'channel4_bot'
    execute_on = 'timestep_end'
    outputs = 'csv'
  [../]
  [./channel5_out]
    type = SideIntegralVariablePostprocessor
    variable = vel_z
    boundary = 'channel5_bot'
    execute_on = 'timestep_end'
    outputs = 'csv'
  [../]
  [./channel6_out]
    type = SideIntegralVariablePostprocessor
    variable = vel_z
    boundary = 'channel6_bot'
    execute_on = 'timestep_end'
    outputs = 'csv'
  [../]
  [./channel7_out]
    type = SideIntegralVariablePostprocessor
    variable = vel_z
    boundary = 'channel7_bot'
    execute_on = 'timestep_end'
    outputs = 'csv'
  [../]
  [./channel8_out]
    type = SideIntegralVariablePostprocessor
    variable = vel_z
    boundary = 'channel8_bot'
    execute_on = 'timestep_end'
    outputs = 'csv'
  [../]
  [./channel9_out]
    type = SideIntegralVariablePostprocessor
    variable = vel_z
    boundary = 'channel9_bot'
    execute_on = 'timestep_end'
    outputs = 'csv'
  [../]
  [./channel10_out]
    type = SideIntegralVariablePostprocessor
    variable = vel_z
    boundary = 'channel10_bot'
    execute_on = 'timestep_end'
    outputs = 'csv'
  [../]
  [./channel11_out]
    type = SideIntegralVariablePostprocessor
    variable = vel_z
    boundary = 'channel11_bot'
    execute_on = 'timestep_end'
    outputs = 'csv'
  [../]
  [./channel12_out]
    type = SideIntegralVariablePostprocessor
    variable = vel_z
    boundary = 'channel12_bot'
    execute_on = 'timestep_end'
    outputs = 'csv'
  [../]
  [./channel13_out]
    type = SideIntegralVariablePostprocessor
    variable = vel_z
    boundary = 'channel13_bot'
    execute_on = 'timestep_end'
    outputs = 'csv'
  [../]
[]