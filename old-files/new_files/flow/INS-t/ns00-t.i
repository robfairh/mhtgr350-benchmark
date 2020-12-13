[GlobalParams]
  integrate_p_by_parts = false
  laplace = true
  gravity = '0 0 0'
  supg = true
  pspg = true
  order = FIRST
[]

[Mesh]
  type = GeneratedMesh
  dim = 2
  xmax = 1000.
  ymax = 1.
  nx = 2000
  ny = 20
  elem_type = QUAD9
[]

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
  [./x_momentum_space]
    # type = INSMomentumTractionForm
    type = INSMomentumLaplaceForm
    variable = vel_x
    u = vel_x
    v = vel_y
    p = p
    component = 0
  [../]
  [./y_momentum_space]
    # type = INSMomentumTractionForm
    type = INSMomentumLaplaceForm
    variable = vel_y
    u = vel_x
    v = vel_y
    p = p
    component = 1
  [../]
[]

[BCs]
  [./vel_x_no_slip]
    type = DirichletBC
    variable = vel_x
    boundary = 'bottom top'
    value = 0
  [../]
  [./vel_y_null]
    type = DirichletBC
    variable = vel_y
    boundary = 'left right top bottom'
    value = 0
  [../]

  [./vel_in]
    type = FunctionDirichletBC
    boundary = left
    variable = vel_x
    function = 'inlet_func'
  [../]

  [./p_right]
    type = DirichletBC
    variable = p
    boundary = 'right'
    value = 0
  [../]
[]

[Functions]
  [./inlet_func]
    type = ParsedFunction
    # value = '1'
    value = '2865'
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
    dt = 0.0001
    cutback_factor = 0.6
    growth_factor = 1.2
    optimal_iterations = 5
    iteration_window = 1
    linear_iteration_ratio = 100
  [../]
[]

[Outputs]
  file_base = 'ns00-t'
  execute_on = 'timestep_end'
  exodus = true
[]

[Postprocessors]
  [./flow_in]
    type = VolumetricFlowRate
    vel_x = vel_x
    vel_y = vel_y
    boundary = 'left'
    execute_on = 'timestep_end'
  [../]
  [./flow_out]
    type = VolumetricFlowRate
    vel_x = vel_x
    vel_y = vel_y
    boundary = 'right'
    execute_on = 'timestep_end'
  [../]
[]