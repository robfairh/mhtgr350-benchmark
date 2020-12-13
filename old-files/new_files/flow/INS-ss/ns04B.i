[Mesh]
 file = test2B.msh
[]

[Problem]
  coord_type = RZ
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
  [./p]
    order = FIRST
    family = LAGRANGE
  [../]
[]

[Kernels]
  [./mass]
    type = INSMassRZ
    variable = p
    u = vel_x
    v = vel_y
    p = p
  [../]
  [./x_momentum_space]
    type = INSMomentumLaplaceFormRZ
    variable = vel_x
    u = vel_x
    v = vel_y
    p = p
    component = 0
    integrate_p_by_parts = false
  [../]
  [./y_momentum_space]
    type = INSMomentumLaplaceFormRZ
    variable = vel_y
    u = vel_x
    v = vel_y
    p = p
    component = 1
    integrate_p_by_parts = false
  [../]
[]

[BCs]
  [./vel_x_null]
    type = DirichletBC
    variable = vel_x
    boundary = 'cool_bot cool_top chan_wall'
    value = 0
  [../]

  [./channel_vel_y_no_slip]
    type = DirichletBC
    variable = vel_y
    boundary = 'chan_wall'
    value = 0
  [../]

  [./p_in]
    type = DirichletBC
    variable = p
    boundary = 'cool_top'
    value = 100
  [../]
  [./p_out]
    type = DirichletBC
    variable = p
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
  [../]
[]

[Executioner]
  type = Steady

  # petsc_options_iname = '-ksp_gmres_restart -pc_type -sub_pc_type -sub_pc_factor_levels'
  # petsc_options_value = '300                bjacobi  ilu          4'

  petsc_options_iname = '-pc_type -sub_pc_factor_levels -ksp_gmres_restart'
  petsc_options_value = 'asm      6                     200'

  line_search = 'none'

  l_tol = 1e-6
  l_max_its = 300

  nl_rel_tol = 1e-12
  nl_max_its = 6
[]

[Outputs]
  file_base = 'ns04B'
  execute_on = 'final'
  exodus = true
[]