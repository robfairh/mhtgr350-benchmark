[GlobalParams]
  integrate_p_by_parts = false
  laplace = true
  gravity = '0 0 0'
[]

[Mesh]
 file = test1.msh
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
  [./vel_x_no_slip]
    # type = DirichletBC
    type = PresetBC
    variable = vel_x
    boundary = 'plen_bot plen_top chan1_bot chan1_top chan2_bot chan2_top'
    value = 0
  [../]
  [./vel_x_null]
    # type = DirichletBC
    type = PresetBC
    variable = vel_x
    boundary = 'plen1 plen2 plen3'
    value = 0
  [../]

  [./vel_y_null]
    # type = DirichletBC
    type = PresetBC
    variable = vel_y
    boundary = 'cool_in cool_out plen_bot plen_top chan1_bot chan1_top chan2_bot chan2_top plen1 plen2 plen3'
    value = 0
  [../]

  [./p_in]
    type = DirichletBC
    variable = p
    boundary = 'cool_in'
    value = 100
  [../]
  [./p_out]
    type = DirichletBC
    variable = p
    boundary = 'cool_out'
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

  petsc_options_iname = '-pc_type -sub_pc_factor_levels -ksp_gmres_restart'
  petsc_options_value = 'asm      6                     200'
  line_search = 'none'

  l_tol = 1e-6
  l_max_its = 300

  nl_rel_tol = 1e-12
  nl_max_its = 6
[]

[Outputs]
  file_base = 'ns02'
  execute_on = 'final'
  exodus = true
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
    boundary = 'cool_out'
    execute_on = 'timestep_end'
  [../]
[]