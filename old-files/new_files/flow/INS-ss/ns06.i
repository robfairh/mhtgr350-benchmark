[GlobalParams]
  integrate_p_by_parts = true
  laplace = true
  gravity = '0 0 0'
  supg = true
  pspg = true
  order = FIRST
[]

[Mesh]
 file = test3.msh
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
  [./channel_vel_x_no_slip]
    type = DirichletBC
    variable = vel_x
    preset = true
    # boundary = 'back front chan1_top chan1_bot chan2_top chan2_bot plen_top plen_bot plen1 plen2 plen3'
    boundary = 'back front chan1_top chan1_bot chan2_top chan2_bot plen1 plen2 plen3'
    value = 0
  [../]

  [./vel_in]
    type = FunctionDirichletBC
    boundary = 'cool_in'
    variable = vel_x
    function = 'inlet_func'
  [../]

  [./vel_y_null]
    type = DirichletBC
    variable = vel_y
    preset = true
    boundary = 'cool_in cool_out back front chan1_top chan1_bot chan2_top chan2_bot plen_top plen_bot plen1 plen2 plen3'
    value = 0
  [../]

  [./vel_z_null]
    type = DirichletBC
    variable = vel_z
    preset = true
    boundary = 'cool_in cool_out back front chan1_top chan1_bot chan2_top chan2_bot plen_top plen_bot plen1 plen2 plen3'
    value = 0
  [../]

  # [./p_out]
  #   type = DirichletBC
  #   variable = p
  #   preset = true
  #   boundary = 'cool_out'
  #   value = 0
  # [../]
[]

[Functions]
  [./inlet_func]
    type = ParsedFunction
    # value = '(-y^2+4*y)*(-z^2+1*z)'
    value = '1000'
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

  # petsc_options_iname = '-ksp_gmres_restart -pc_type -sub_pc_type -sub_pc_factor_levels'
  # petsc_options_value = '300                bjacobi  ilu          4'
  # line_search = 'none'

  # petsc_options_iname = '-pc_type -sub_pc_factor_levels -ksp_gmres_restart'
  # petsc_options_value = 'asm      6                     200'
  # line_search = 'none'

  # petsc_options_iname = '-pc_type -sub_pc_type -sub_pc_factor_levels'
  # petsc_options_value = 'bjacobi  ilu          4'

  l_tol = 1e-6
  l_max_its = 300

  nl_rel_tol = 1e-12
  nl_max_its = 20
[]

[Outputs]
  file_base = 'ns06'
  execute_on = 'final'
  exodus = true
  csv = true
[]

[Debug]
  show_var_residual_norms = true
[]

[Postprocessors]
  [./flow_in]
    type = VolumetricFlowRate
    vel_x = vel_x
    vel_y = vel_y
    vel_z = vel_z
    boundary = 'cool_in'
    execute_on = 'timestep_end'
  [../]
  [./flow_out]
    type = VolumetricFlowRate
    vel_x = vel_x
    vel_y = vel_y
    vel_z = vel_z
    boundary = 'cool_out'
    execute_on = 'timestep_end'
  [../]
  [./memory]
    type = MemoryUsage
    execute_on = linear
  [../]
[]