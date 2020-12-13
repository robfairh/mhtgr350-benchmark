[GlobalParams]
  integrate_p_by_parts = true
  laplace = true
  gravity = '0 0 0'
  pspg = true
  supg = true
  order = FIRST
[]

[Mesh]
  type = GeneratedMesh
  dim = 2
  xmax = 10.
  ymax = 1.
  nx = 400
  ny = 20
  elem_type = QUAD9
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
  [./p]
    # der = FIRST
    # family = LAGRANGE
    scaling = 1e-2
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
  [./vel_x_noslip]
    type = DirichletBC
    variable = vel_x
    boundary = 'bottom top'
    value = 0
  [../]
  [./vel_y_noslip]
    type = DirichletBC
    variable = vel_y
    boundary = 'bottom top left'
    value = 0
  [../]

  [./vel_x_in]
    type = FunctionDirichletBC
    variable = vel_x
    boundary = left
    function = 'inlet_func'
  [../]
  [./vel_y_in]
    type = DirichletBC
    variable = vel_y
    boundary = left
    value = 0
  [../]

  # [./vel_x_out]
  #   type = INSMomentumNoBCBCLaplaceForm
  #   variable = vel_x
  #   boundary = right
  #   u = vel_x
  #   v = vel_y
  #   p = p
  #   component = 0
  # [../]
  # [./vel_y_out]
  #   type = INSMomentumNoBCBCLaplaceForm
  #   boundary = right
  #   variable = vel_y
  #   u = vel_x
  #   v = vel_y
  #   p = p
  #   component = 1
  # [../]
  # [./p_right]
  #   type = DirichletBC
  #   variable = p
  #   boundary = 'right'
  #   value = 0
  # [../]
[]

[Functions]
  [./inlet_func]
    type = ParsedFunction
    # value = '1'
    # value = '-(y^2-y)*6'
    # value = '2865'
    # value = '-(y^2-y)*6*2865'
    value = '-(y^2-y)*6*100'
  [../]
[]

[Materials]
  [./const]
    type = GenericConstantMaterial
    prop_names = 'rho mu'
    # prop_values = '1 1'
    prop_values = '4.3679e-6 3.8236e-7'
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

  nl_rel_tol = 1e-11
  nl_max_its = 20

  # automatic_scaling = true
[]

[Outputs]
  file_base = 'ns01'
  execute_on = 'final'
  exodus = true
[]

[Debug]
  show_var_residual_norms = true
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
  [./memory]
    type = MemoryUsage
    execute_on = linear
  [../]
[]