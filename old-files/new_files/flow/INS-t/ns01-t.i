[GlobalParams]
  integrate_p_by_parts = false
  laplace = true
  gravity = '0 0 0'
  supg = true
  pspg = true
  order = FIRST
[]

[Mesh]
 file = test2A.msh
[]

[Variables]
  [./vel_x]
    initial_condition = 1e-15
  [../]
  [./vel_y]
    initial_condition = 1e-15
  [../]
  [./vel_z]
    initial_condition = 1e-15
  [../]
  [./p]
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
  [./vel_x_null]
    type = DirichletBC
    variable = vel_x
    preset = true
    boundary = 'bottom top wall'
    value = 0
  [../]
  [./vel_y_null]
    type = DirichletBC
    variable = vel_y
    preset = true
    boundary = 'bottom top wall'
    value = 0
  [../]

  [./channel_vel_z_no_slip]
    type = DirichletBC
    variable = vel_z
    preset = true
    boundary = 'wall'
    value = 0
  [../]

  [./vel_in]
    type = FunctionDirichletBC
    boundary = 'top'
    variable = vel_z
    function = 'inlet_func'
  [../]

  [./p_out]
    type = DirichletBC
    variable = p
    preset = true
    boundary = 'bottom'
    value = 0
  [../]
[]

[Functions]
  [./inlet_func]
    type = ParsedFunction
    # value = '((x^2+y^2)-1)*2/pi'
    value = '((x^2+y^2)-1)*2/pi*2865'
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
  [../]
[]

[Executioner]
  type = Transient
  start_time = 0
  end_time = 1
  # num_steps = 5

  solve_type = 'NEWTON'
  petsc_options = '-snes_converged_reason -ksp_converged_reason -snes_linesearch_monitor'
  petsc_options_iname = '-pc_type -sub_pc_type -pc_factor_shift_type'
  petsc_options_value = 'lu       lu           NONZERO'
  line_search = 'none'

  nl_rel_tol = 1e-6
  l_max_its = 100

  nl_abs_tol = 1e-6
  nl_max_its = 10

  dtmin = 1e-6
  dtmax = 0.1

  [./TimeStepper]
    type = IterationAdaptiveDT
    dt = 1e-5
    cutback_factor = 0.6
    growth_factor = 1.3
    optimal_iterations = 4
    iteration_window = 1
    linear_iteration_ratio = 50
  [../]
[]

[Outputs]
  file_base = 'ns01-tA'
  execute_on = 'timestep_end'
  exodus = true
  csv = true
[]

[Postprocessors]
  [./flow_in]
    type = VolumetricFlowRate
    vel_x = vel_x
    vel_y = vel_y
    vel_z = vel_z
    boundary = 'top'
    execute_on = 'timestep_end'
  [../]
  [./flow_out]
    type = VolumetricFlowRate
    vel_x = vel_x
    vel_y = vel_y
    vel_z = vel_z
    boundary = 'bottom'
    execute_on = 'timestep_end'
  [../]
[]