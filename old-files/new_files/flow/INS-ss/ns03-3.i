[GlobalParams]
  integrate_p_by_parts = false
  laplace = true
  gravity = '0 0 0'
  pspg = true
  supg = true
  order = FIRST
[]

[Mesh]
 file = test1.msh
[]

[Variables]
  [./vel_x]
    # order = SECOND
    # family = LAGRANGE
  [../]
  [./vel_y]
    # der = SECOND
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
    p = p
  [../]
  [./x_momentum_space]
    type = INSMomentumLaplaceForm
    variable = vel_x
    u = vel_x
    v = vel_y
    p = p
    component = 0
  [../]
  [./y_momentum_space]
    type = INSMomentumLaplaceForm
    variable = vel_y
    u = vel_x
    v = vel_y
    p = p
    component = 1
  [../]
[]

[BCs]
  [./plenum_vel_x_no_slip]
    type = DirichletBC
    variable = vel_x
    boundary = 'plen_bot plen_top chan1_bot chan1_top chan2_bot chan2_top'
    value = 0
  [../]
  [./vel_x_null]
    type = DirichletBC
    variable = vel_x
    boundary = 'plen1 plen2 plen3'
    value = 0
  [../]
  [./vel_y_noslip]
    type = DirichletBC
    variable = vel_y
    boundary = 'plen1 plen2 plen3'
    value = 0
  [../]
  [./vel_y_null]
    type = DirichletBC
    variable = vel_y
    boundary = 'cool_in plen_bot plen_top chan1_bot chan1_top chan2_bot chan2_top'
    value = 0
  [../]

  [./vel_in]
    type = FunctionDirichletBC
    boundary = 'cool_in'
    variable = vel_x
    function = 'inlet_func'
  [../]

  [./p_out]
    type = DirichletBC
    variable = p
    boundary = 'chan1_out chan2_out'
    value = 0
  [../]
[]

[Functions]
  [./inlet_func]
    type = ParsedFunction
    value = '-y^2+4*y'
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
    solve_type = NEWTON
  [../]
[]

[Executioner]
  type = Steady

  petsc_options = '-snes_converged_reason -ksp_converged_reason -snes_linesearch_monitor'
  petsc_options_iname = '-pc_type -sub_ksp_type -snes_linesearch_minlambda'
  petsc_options_value = 'lu       preonly       1e-3'

  l_tol = 1e-6
  l_max_its = 300

  nl_rel_tol = 1e-12
  nl_max_its = 6
[]

[Outputs]
  file_base = 'ns03-3'
  execute_on = 'final'
  exodus = true
  csv = true
[]

[Postprocessors]
  [./flow_in]
    type = VolumetricFlowRate
    vel_x = vel_x
    vel_y = vel_y
    boundary = 'cool_in'
    execute_on = 'timestep_end'
  [../]
  [./flow_out]
    type = VolumetricFlowRate
    vel_x = vel_x
    vel_y = vel_y
    boundary = 'chan1_out chan2_out'
    execute_on = 'timestep_end'
  [../]
  [./channel1_in]
    type = SideIntegralVariablePostprocessor
    variable = vel_x
    boundary = 'chan1_in'
    execute_on = 'timestep_end'
    outputs = 'csv'
  [../]
  [./channel2_in]
    type = SideIntegralVariablePostprocessor
    variable = vel_x
    boundary = 'chan2_in'
    execute_on = 'timestep_end'
    outputs = 'csv'
  [../]
  [./channel1_out]
    type = SideIntegralVariablePostprocessor
    variable = vel_x
    boundary = 'chan1_out'
    execute_on = 'timestep_end'
    outputs = 'csv'
  [../]
  [./channel2_out]
    type = SideIntegralVariablePostprocessor
    variable = vel_x
    boundary = 'chan2_out'
    execute_on = 'timestep_end'
    outputs = 'csv'
  [../]
[]