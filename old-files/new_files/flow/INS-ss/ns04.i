[GlobalParams]
  integrate_p_by_parts = false
  laplace = true
  gravity = '0 0 0'
[]

[Mesh]
 file = test2.msh
[]

[Variables]
  [./vel_x]
    order = SECOND
    family = LAGRANGE
  [../]
  [./vel_y]
    order = SECOND
    family = LAGRANGE
  [../]
  [./vel_z]
    order = SECOND
    family = LAGRANGE
  [../]
  [./p]
    order = FIRST
    family = LAGRANGE
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
    # preset = true
    boundary = 'cool_bot cool_top channel_wall'
    value = 0
  [../]
  [./vel_y_null]
    type = DirichletBC
    variable = vel_y
    # preset = true
    boundary = 'cool_bot cool_top channel_wall'
    value = 0
  [../]

  [./channel_vel_z_no_slip]
    type = DirichletBC
    variable = vel_z
    # preset = true
    boundary = 'channel_wall'
    value = 0
  [../]

  [./p_in]
    type = DirichletBC
    variable = p
    # preset = true
    boundary = 'cool_top'
    value = 100
  [../]
  [./p_out]
    type = DirichletBC
    variable = p
    # preset = true
    boundary = 'cool_bot'
    value = 0
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
    solve_type = PJFNK
    # solve_type = Newton
  [../]
[]

[Executioner]
  type = Steady

  petsc_options_iname = '-pc_type -sub_pc_factor_levels -ksp_gmres_restart'
  petsc_options_value = 'asm      6                     200'
  line_search = 'none'

  # petsc_options = '-snes_converged_reason -ksp_converged_reason -snes_linesearch_monitor'
  # petsc_options_iname = '-pc_type -sub_ksp_type -snes_linesearch_minlambda'
  # petsc_options_value = 'lu       preonly       1e-3'

  # petsc_options_iname = '-pc_type -pc_asm_overlap -sub_pc_type -sub_pc_factor_levels  -ksp_gmres_restart'
  # petsc_options_value = 'asm      2               ilu          4       200'

  l_tol = 1e-6
  l_max_its = 300

  nl_rel_tol = 1e-12
  nl_max_its = 6
[]

[Outputs]
  file_base = 'ns04'
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
  [./flow_out]
    type = VolumetricFlowRate
    vel_x = vel_x
    vel_y = vel_y
    vel_z = vel_z
    boundary = 'cool_bot'
    execute_on = 'timestep_end'
  [../]
[]