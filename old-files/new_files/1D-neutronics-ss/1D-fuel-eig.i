
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
  [../]
  [./group2]
  [../]
[]

[Mesh]
  file = '1D-fuel.msh'
[../]

[MeshModifiers]
  [./add_side_sets]
    type = SideSetsFromPoints
    points = '0    0  0
              0  793  0'
    new_boundary = 'fuel_bot fuel_top'
  [../]
[]

[Kernels]
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
    type = CoupledFissionEigenKernel
    variable = group1
    group_number = 1
    block = 'fuel'
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
    type = CoupledFissionEigenKernel
    variable = group2
    group_number = 2
    block = 'fuel'
  [../]
[]

[BCs]
  [./vacuum_group1]
    type = VacuumConcBC
    # type = DirichletBC
    # value = 0
    boundary = 'fuel_bot fuel_top'
    variable = group1
  [../]
  [./vacuum_group2]
    type = VacuumConcBC
    # type = DirichletBC
    # value = 0
    boundary = 'fuel_bot fuel_top'
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
[]

[Executioner]
  type = InversePowerMethod
  max_power_iterations = 50
  xdiff = 'group1diff'

  bx_norm = 'bnorm'
  k0 = 1.5
  pfactor = 1e-2
  l_max_its = 100

  # solve_type = 'PJFNK'
  solve_type = 'NEWTON'
  petsc_options = '-snes_converged_reason -ksp_converged_reason -snes_linesearch_monitor'
  petsc_options_iname = '-pc_type -sub_pc_type'
  petsc_options_value = 'asm lu'
[]

[Preconditioning]
  [./SMP]
    type = SMP
    full = true
  [../]
[]

[Postprocessors]
  [./bnorm]
    type = ElmIntegTotFissNtsPostprocessor
    execute_on = linear
  [../]
  [./group1diff]
    type = ElementL2Diff
    variable = group1
    execute_on = 'linear timestep_end'
    use_displaced_mesh = false
  [../]
[]

[Outputs]
  perf_graph = true
  print_linear_residuals = true
  [./exodus]
    type = Exodus
    file_base = '1D-fuel-eig'
  [../]
[]

[Debug]
  show_var_residual_norms = true
[]