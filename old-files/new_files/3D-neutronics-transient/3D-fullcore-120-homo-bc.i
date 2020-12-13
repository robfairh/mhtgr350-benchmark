
[GlobalParams]
  num_groups = 2
  num_precursor_groups = 8
  use_exp_form = false
  group_fluxes = 'group1 group2'
  sss2_input = true 
  account_delayed = false
  temperature = 750
[]

[Mesh]
  file = '3D-fullcore-120-homo.msh'
[../]

[Nt]
  var_name_base = group
  vacuum_boundaries = 'ref_top ref_bot wall3'
  create_temperature_var = false
  # pre_blocks = 'fuel coolant moderator' 
  pre_blocks = 'fuel'
  dg_for_temperature = false
[]

# Polar to Cartesian
# R = sqrt(x^2 + y^2)
# x = R * cos(theta)
# y = R * sin(theta)
[Functions]
  [./tr_x]
    type = ParsedFunction
    value = sqrt(x^2+y^2)*cos(pi/2)
  [../]

  [./tr_y]
    type = ParsedFunction
    value = sqrt(x^2+y^2)*sin(pi/2)
  [../]

  [./tr_z]
    type = ParsedFunction
    value = z
  [../]

  [./itr_x]
    type = ParsedFunction
    value = sqrt(x^2+y^2)*cos(-pi/6)
  [../]

  [./itr_y]
    type = ParsedFunction
    value = sqrt(x^2+y^2)*sin(-pi/6)
  [../]

  [./itr_z]
    type = ParsedFunction
    value = z
  [../]
[]

[BCs]
  [./Periodic]
    [./x]
      primary = 'wall2'
      secondary = 'wall1'
      transform_func = 'tr_x tr_y tr_z'
      inv_transform_func = 'itr_x itr_y itr_z'
    [../]
  [../]
[]

[Materials]
  [./fuel]
    type = GenericMoltresMaterial
    property_tables_root = '../xs/8/xs800000-500-100/htgr_2g_homoge_'
    interp_type = 'linear'
    block = 'fuel'
  [../]
  [./breflector]
    type = GenericMoltresMaterial
    property_tables_root = '../xs/8/xs800000-500-100/htgr_2g_brefl_'
    interp_type = 'linear'
    block = 'breflector'
  [../]
  [./treflector]
    type = GenericMoltresMaterial
    property_tables_root = '../xs/8/xs800000-500-100/htgr_2g_trefl_'
    interp_type = 'linear'
    block = 'treflector'
  [../]
  [./ireflector]
    type = GenericMoltresMaterial
    property_tables_root = '../xs/8/xs800000-500-100/htgr_2g_irefl_'
    interp_type = 'linear'
    block = 'ireflector'
  [../]
  [./oreflector]
    type = GenericMoltresMaterial
    property_tables_root = '../xs/8/xs800000-500-100/htgr_2g_orefl_'
    interp_type = 'linear'
    block = 'oreflector'
  [../]
[]


[Executioner]
  # automatic_scaling = true

  type = Transient
  end_time = 1e-3

  nl_rel_tol = 1e-6
  nl_abs_tol = 1e-6

  solve_type = 'NEWTON'
  petsc_options = '-snes_converged_reason -ksp_converged_reason -snes_linesearch_monitor'
  petsc_options_iname = '-pc_type -pc_factor_shift_type'
  petsc_options_value = 'lu       NONZERO'
  line_search = 'none'

  nl_max_its = 30
  l_max_its = 100

  dtmin = 1e-6
  [./TimeStepper]
    type = IterationAdaptiveDT
    dt = 1e-6
    cutback_factor = 0.3
    growth_factor = 1.2
    optimal_iterations = 20
  [../]
  dtmax = 5e-5
[]

[Preconditioning]
  [./SMP]
    type = SMP
    full = true
  [../]
[]

[Postprocessors]
  [./group1_current]
    type = IntegralNewVariablePostprocessor
    variable = group1
    outputs = 'console exodus'
  [../]
  [./group1_old]
    type = IntegralOldVariablePostprocessor
    variable = group1
    outputs = 'console exodus'
  [../]
  [./multiplication]
    type = DivisionPostprocessor
    value1 = group1_current
    value2 = group1_old
    outputs = 'console exodus'
  [../]
[]

[Outputs]
  perf_graph = true
  print_linear_residuals = true
  [./exodus]
    type = Exodus
    file_base = '3D-fullcore-120-homo-bc'
  [../]
[]

[Debug]
  show_var_residual_norms = true
[]