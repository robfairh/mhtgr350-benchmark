
[GlobalParams]
  num_groups = 2
  num_precursor_groups = 8
  use_exp_form = false
  group_fluxes = 'group1 group2'
  sss2_input = true
  account_delayed = false
  temperature = 750
[]

[Variables]
  [./group1]
    order = FIRST
    family = LAGRANGE
    initial_condition = 1e-4
  [../]
  [./group2]
    order = FIRST
    family = LAGRANGE
    initial_condition = 1e-4
  [../]
[]

[Mesh]
  file = '1D-fuel-reflec.msh'
[../]

[MeshModifiers]
  [./add_side_sets]
    type = SideSetsFromPoints
    points = '0    0  0
              0  1073  0'
    new_boundary = 'ref_bot ref_top'
  [../]
[]

[Kernels]
  [./time_group1]
    type = NtTimeDerivative
    variable = group1
    group_number = 1
  [../]
  [./diff_group1]
    type = GroupDiffusion
    variable = group1
    group_number = 1
  [../]
  [./sigma_r_group1]
    type = SigmaR
    variable = group1
    group_number = 1
  [../]
  [./inscatter_group1]
    type = InScatter
    variable = group1
    group_number = 1
  [../]
  [./fission_source_group1]
    type = CoupledFissionKernel
    variable = group1
    group_number = 1
    block = 'fuel'
  [../]

  [./time_group2]
    type = NtTimeDerivative
    variable = group2
    group_number = 2
  [../]
  [./diff_group2]
    type = GroupDiffusion
    variable = group2
    group_number = 2
  [../]
  [./sigma_r_group2]
    type = SigmaR
    variable = group2
    group_number = 2
  [../]
  [./inscatter_group2]
    type = InScatter
    variable = group2
    group_number = 2
  [../]
  [./fission_source_group2]
    type = CoupledFissionKernel
    variable = group2
    group_number = 2
    block = 'fuel'
  [../]
[]

[BCs]
  [./vacuum_group1]
    type = VacuumConcBC
    #type = DirichletBC
    #value = 0
    boundary = 'ref_bot ref_top'
    variable = group1
  [../]
  [./vacuum_group2]
    type = VacuumConcBC
    #type = DirichletBC
    #value = 0
    boundary = 'ref_bot ref_top'
    variable = group2
  [../]
[]

[Materials]
  [./fuel]
    type = GenericMoltresMaterial
    property_tables_root = '../xs/8/xs800000-500-100/htgr_2g_homoge_'
    interp_type = 'linear'
    prop_names = 'k'
    prop_values = '1.'
    block = 'fuel'
  [../]
  [./refl1]
    type = GenericMoltresMaterial
    property_tables_root = '../xs/8/xs800000-500-100/htgr_2g_brefl_'
    interp_type = 'linear'
    prop_names = 'k'
    prop_values = '1.'
    block = 'breflector'
  [../]
  [./refl2]
    type = GenericMoltresMaterial
    property_tables_root = '../xs/8/xs800000-500-100/htgr_2g_trefl_'
    interp_type = 'linear'
    prop_names = 'k'
    prop_values = '1.'
    block = 'treflector'
  [../]
[]

[Executioner]
  # automatic_scaling = true

  type = Transient
  end_time = 1e-2

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
    dt = 1e-5
    cutback_factor = 0.5
    growth_factor = 1.5
    optimal_iterations = 20
  [../]
  dtmax = 1e-4
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

  [./group1max]
    type = NodalMaxValue
    variable = group1
    execute_on = timestep_end
    block = 'fuel'
  [../]
  [./group2max]
    type = NodalMaxValue
    variable = group2
    execute_on = timestep_end
    block = 'fuel'
  [../]
  [./S1]
    type = DivisionPostprocessor
    value1 = group2max
    value2 = group1max
    outputs = 'console exodus'
    block = 'fuel'
  [../]
[]

[Outputs]
  perf_graph = true
  print_linear_residuals = true
  [./exodus]
    type = Exodus
    file_base = '1D-fuel-reflec'
  [../]
[]

[Debug]
  show_var_residual_norms = true
[]