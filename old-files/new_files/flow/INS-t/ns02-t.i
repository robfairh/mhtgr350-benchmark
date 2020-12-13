[GlobalParams]
  integrate_p_by_parts = false
  laplace = true
  gravity = '0 0 0'
  supg = true
  pspg = true
  order = FIRST
[]

[Mesh]
 file = test6.msh
[]

# [MeshModifiers]
#   [./middle_node]
#     type = AddExtraNodeset
#     new_boundary = 'righ_bottom'
#     coord = '5 0'
#   [../]
# []

[Variables]
  [./vel_x]
    # order = SECOND
    # family = LAGRANGE
    initial_condition = 1e-15
  [../]
  [./vel_y]
    # order = SECOND
    # family = LAGRANGE
    initial_condition = 1e-15
  [../]
  [./vel_z]
    # order = SECOND
    # family = LAGRANGE
    initial_condition = 1e-15
  [../]
  [./p]
    # order = FIRST
    # family = LAGRANGE
    initial_condition = 1e-15
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

  [./momentum_time_x]
    type = INSMomentumTimeDerivative
    variable = vel_x
  [../]
  [./momentum_time_y]
    type = INSMomentumTimeDerivative
    variable = vel_y
  [../]
  [./momentum_time_z]
    type = INSMomentumTimeDerivative
    variable = vel_z
  [../]
  [./x_momentum_space]
    # type = INSMomentumTractionForm
    type = INSMomentumLaplaceForm
    variable = vel_x
    u = vel_x
    v = vel_y
    w = vel_z
    p = p
    component = 0
  [../]
  [./y_momentum_space]
    # type = INSMomentumTractionForm
    type = INSMomentumLaplaceForm
    variable = vel_y
    u = vel_x
    v = vel_y
    w = vel_z
    p = p
    component = 1
  [../]
  [./z_momentum_space]
    # type = INSMomentumTractionForm
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
  [./vel_x_noslip_null]
    type = DirichletBC
    preset = true
    variable = vel_x
    boundary = 'plenum cool_top channel_wall plenum_wall channel1_bot channel2_bot channel3_bot'
    value = 0
  [../]
  [./vel_y_noslip_null]
    type = DirichletBC
    preset = true
    variable = vel_y
    boundary = 'plenum cool_top channel_wall plenum_wall channel1_bot channel2_bot channel3_bot'
    value = 0
  [../]

  [./vel_z_noslip_null]
    type = DirichletBC
    preset = true
    variable = vel_z
    boundary = 'channel_wall plenum'
    value = 0
  [../]

  [./vel_in]
    type = FunctionDirichletBC
    boundary = 'cool_top'
    variable = vel_z
    function = 'inlet_func'
  [../]

  [./p_right]
    type = DirichletBC
    preset = true
    variable = p
    boundary = 'channel1_bot channel2_bot channel3_bot'
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
    solve_type = Newton
  [../]
[]

[Executioner]
  type = Transient
  start_time = 0
  end_time = 1
  # num_steps = 5

  # dt = 0.005
  # dtmin = 0.005

  solve_type = 'NEWTON'
  petsc_options = '-snes_converged_reason -ksp_converged_reason -snes_linesearch_monitor'
  petsc_options_iname = '-pc_type -sub_pc_type -pc_factor_shift_type'
  petsc_options_value = 'lu       lu           NONZERO'
  line_search = 'none'

  nl_rel_tol = 1e-6
  l_max_its = 100

  nl_abs_tol = 1e-6
  nl_max_its = 10

  dtmin = 1e-5
  dtmax = 0.1

  [./TimeStepper]
    type = IterationAdaptiveDT
    dt = 0.001
    cutback_factor = 0.5
    growth_factor = 1.1
    optimal_iterations = 5
    iteration_window = 1
    linear_iteration_ratio = 100
  [../]
[]

[Outputs]
  file_base = 'ns02-t'
  execute_on = 'timestep_end'
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
  [./flow_out]
    type = VolumetricFlowRate
    vel_x = vel_x
    vel_y = vel_y
    vel_z = vel_z
    boundary = 'channel1_bot channel2_bot channel3_bot'
    execute_on = 'timestep_end'
  [../]
[]