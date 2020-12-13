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
  dim = 3
  xmax = 1.
  ymax = 1.
  zmax = 10.
  nx = 10
  ny = 10
  nz = 200
  elem_type = HEX27
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
  [./vel_x_noslip]
    type = DirichletBC
    variable = vel_x
    boundary = 'bottom top'
    value = 0
  [../]
  [./vel_x_null]
    type = DirichletBC
    variable = vel_x
    boundary = 'left right front'
    value = 0
  [../]

  [./vel_y_noslip]
    type = DirichletBC
    variable = vel_y
    boundary = 'left right'
    value = 0
  [../]
  [./vel_y_null]
    type = DirichletBC
    variable = vel_y
    boundary = 'top bottom front'
    value = 0
  [../]

  [./vel_z_noslip]
    type = DirichletBC
    variable = vel_z
    boundary = 'left right top bottom'
    value = 0
  [../]
  [./vel_z_in]
    type = FunctionDirichletBC
    variable = vel_z
    boundary = front
    function = 'inlet_func'
  [../]
[]

[Functions]
  [./inlet_func]
    type = ParsedFunction
    # value = '-1'
    value = '-(x^2-x)*(y^2-y)*36'
    # value = '2865'
  [../]
[]

[Materials]
  [./const]
    type = GenericConstantMaterial
    prop_names = 'rho mu'
    prop_values = '1 1'
    # prop_values = '4.3679e-6 3.8236e-7'
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

  # petsc_options_iname = '-pc_type -sub_pc_type -sub_pc_factor_levels -ksp_gmres_restart'
  # petsc_options_value = 'bjacobi  ilu          4                     300'

  # petsc_options_iname = '-pc_type -sub_ksp_type -snes_linesearch_minlambda'
  # petsc_options_value = 'lu       preonly       1e-3'

  petsc_options_iname = '-pc_type -sub_pc_type -pc_factor_shift_type'
  petsc_options_value = 'lu       lu           NONZERO'
  line_search = 'none'

  # petsc_options_iname = '-pc_type -sub_pc_type -sub_pc_factor_shift_type'
  # petsc_options_value = 'asm      lu           NONZERO'

  # petsc_options_iname = '-pc_type -sub_pc_factor_levels -ksp_gmres_restart'
  # petsc_options_value = 'asm      6                     200'
  # line_search = 'none'

  # petsc_options_iname = '-pc_type -pc_asm_overlap -sub_pc_type -sub_pc_factor_levels'
  # petsc_options_value = 'asm      2               ilu          4'

  l_tol = 1e-6
  l_max_its = 300

  nl_rel_tol = 1e-11
  nl_max_its = 20

[]

[Outputs]
  file_base = 'ns01-3'
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
    vel_z = vel_z
    boundary = 'front'
    execute_on = 'timestep_end'
  [../]
  [./flow_out]
    type = VolumetricFlowRate
    vel_x = vel_x
    vel_y = vel_y
    vel_z = vel_z
    boundary = 'back'
    execute_on = 'timestep_end'
  [../]
  [./memory]
    type = MemoryUsage
    execute_on = linear
  [../]
[]