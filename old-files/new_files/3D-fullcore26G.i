# nt_scale = 3.071e18

[GlobalParams]
  num_groups = 26
  num_precursor_groups = 8
  use_exp_form = false
  group_fluxes = 'group1 group2 group3 group4 group5 group6 group7 group8 group9 group10 group11 group12 group13 group14 group15 group16 group17 group18 group19 group20 group21 group22 group23 group24 group25 group26'
  sss2_input = true
  account_delayed = false
  temperature = 1200
[]

[Mesh]
  file = '3D-fullcore-elementsA.msh'
[../]

[Nt]
  var_name_base = group
  vacuum_boundaries = 'ref_bot ref_top wall3'
  create_temperature_var = false
  dg_for_temperature = false
  eigen = true
[]

[Materials]
  [./fuel]
    type = GenericMoltresMaterial
    property_tables_root = 'xs26G-LBP/mhtgr_homoge_'
    # property_tables_root = 'xs26G-noLBP/mhtgr_homoge_'
    interp_type = 'linear'
    block = 'F1 F2 F3 F4 F5 F6 F7 F8 F9 F10 F11 F12 F13'
  [../]
  [./ireflector]
    type = GenericMoltresMaterial
    property_tables_root = 'xs26G-LBP/mhtgr_irefl_'
    # property_tables_root = 'xs26G-noLBP/mhtgr_irefl_'
    interp_type = 'linear'
    block = 'ireflector'
  [../]
  [./oreflector]
    type = GenericMoltresMaterial
    property_tables_root = 'xs26G-LBP/mhtgr_orefl_'
    # property_tables_root = 'xs26G-noLBP/mhtgr_orefl_'
    interp_type = 'linear'
    block = 'oreflector'
  [../]
  [./breflector]
    type = GenericMoltresMaterial
    property_tables_root = 'xs26G-LBP/mhtgr_brefl_'
    # property_tables_root = 'xs26G-noLBP/mhtgr_brefl_'
    interp_type = 'linear'
    block = 'breflector'
  [../]
  [./treflector]
    type = GenericMoltresMaterial
    property_tables_root = 'xs26G-LBP/mhtgr_trefl_'
    # property_tables_root = 'xs26G-noLBP/mhtgr_trefl_'
    interp_type = 'linear'
    block = 'treflector'
  [../]
[]

[Preconditioning]
  [./SMP]
    type = SMP
    full = false
  [../]
[]

[Executioner]
  type = InversePowerMethod

  normalization = total_fission_heat
  normal_factor = 58.33e6 # 350/6 10^6 W

  max_power_iterations = 100
  xdiff = 'group1diff'

  bx_norm = 'bnorm'
  k0 = 1.06
  pfactor = 1e-4
  l_max_its = 300

  eig_check_tol = 1e-08

  solve_type = 'PJFNK'
  petsc_options = '-snes_converged_reason -ksp_converged_reason -snes_linesearch_monitor'
  petsc_options_iname = '-pc_type -sub_pc_type'
  petsc_options_value = 'asm lu'
[]

[VectorPostprocessors]
  [./axial1]
    type = LineValueSampler
    variable = 'group1 group2 group3 group4 group5 group6 group7 group8 group9 group10 group11 group12 group13 group14 group15 group16 group17 group18 group19 group20 group21 group22 group23 group24 group25 group26'
    start_point = '85 55 0'
    end_point = '85 55 1073'
    sort_by = z
    num_points = 300
    execute_on = timestep_end
  [../]
  [./axial3]
    type = LineValueSampler
    variable = 'group1 group2 group3 group4 group5 group6 group7 group8 group9 group10 group11 group12 group13 group14 group15 group16 group17 group18 group19 group20 group21 group22 group23 group24 group25 group26'
    start_point = '130 80 0'
    end_point = '130 80 1073'
    sort_by = z
    num_points = 300
    execute_on = timestep_end
  [../]
  [./radial1]
    type = LineValueSampler
    variable = 'group1 group2 group3 group4 group5 group6 group7 group8 group9 group10 group11 group12 group13 group14 group15 group16 group17 group18 group19 group20 group21 group22 group23 group24 group25 group26'
    start_point = '0 0 536'
    end_point = '259.8 150 536'
    sort_by = x
    num_points = 300
    execute_on = timestep_end
  [../]
[]

[Outputs]
  perf_graph = true
  print_linear_residuals = true
  file_base = '3D-fullcore26G-LBP'
  execute_on = timestep_end
  exodus = true
  csv = true
[]

[Debug]
  show_var_residual_norms = true
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
  [./total_fission_heat]
    type = ElmIntegTotFissHeatPostprocessor
    execute_on = timestep_end
    outputs = 'csv console'
    # nt_scale = ${nt_scale}
    block = 'F1 F2 F3 F4 F5 F6 F7 F8 F9 F10 F11 F12 F13'
  [../]
  [./average_fission_heat]
    type = AverageFissionHeat
    execute_on = timestep_end
    outputs = 'csv console'
    # nt_scale = ${nt_scale}
    block = 'F1 F2 F3 F4 F5 F6 F7 F8 F9 F10 F11 F12 F13'
  [../]
  [./memory]
    type = MemoryUsage
    execute_on = linear
    outputs = 'csv console'
  [../]
  [./F1_fission_heat]
    type = ElmIntegTotFissHeatPostprocessor
    execute_on = timestep_end
    outputs = 'csv'
    # nt_scale = ${nt_scale}
    block = 'F1'
  [../]
  [./F2_fission_heat]
    type = ElmIntegTotFissHeatPostprocessor
    execute_on = timestep_end
    outputs = 'csv'
    # nt_scale = ${nt_scale}
    block = 'F2'
  [../]
  [./F3_fission_heat]
    type = ElmIntegTotFissHeatPostprocessor
    execute_on = timestep_end
    outputs = 'csv'
    # nt_scale = ${nt_scale}
    block = 'F3'
  [../]
  [./F4_fission_heat]
    type = ElmIntegTotFissHeatPostprocessor
    execute_on = timestep_end
    outputs = 'csv'
    # nt_scale = ${nt_scale}
    block = 'F4'
  [../]
  [./F5_fission_heat]
    type = ElmIntegTotFissHeatPostprocessor
    execute_on = timestep_end
    outputs = 'csv'
    # nt_scale = ${nt_scale}
    block = 'F5'
  [../]
  [./F6_fission_heat]
    type = ElmIntegTotFissHeatPostprocessor
    execute_on = timestep_end
    outputs = 'csv'
    # nt_scale = ${nt_scale}
    block = 'F6'
  [../]
  [./F7_fission_heat]
    type = ElmIntegTotFissHeatPostprocessor
    execute_on = timestep_end
    outputs = 'csv'
    # nt_scale = ${nt_scale}
    block = 'F7'
  [../]
  [./F8_fission_heat]
    type = ElmIntegTotFissHeatPostprocessor
    execute_on = timestep_end
    outputs = 'csv'
    # nt_scale = ${nt_scale}
    block = 'F8'
  [../]
  [./F9_fission_heat]
    type = ElmIntegTotFissHeatPostprocessor
    execute_on = timestep_end
    outputs = 'csv'
    # nt_scale = ${nt_scale}
    block = 'F9'
  [../]
  [./F10_fission_heat]
    type = ElmIntegTotFissHeatPostprocessor
    execute_on = timestep_end
    outputs = 'csv'
    # nt_scale = ${nt_scale}
    block = 'F10'
  [../]
  [./F11_fission_heat]
    type = ElmIntegTotFissHeatPostprocessor
    execute_on = timestep_end
    outputs = 'csv'
    # nt_scale = ${nt_scale}
    block = 'F11'
  [../]
  [./F12_fission_heat]
    type = ElmIntegTotFissHeatPostprocessor
    execute_on = timestep_end
    outputs = 'csv'
    # nt_scale = ${nt_scale}
    block = 'F12'
  [../]
  [./F13_fission_heat]
    type = ElmIntegTotFissHeatPostprocessor
    execute_on = timestep_end
    outputs = 'csv'
    # nt_scale = ${nt_scale}
    block = 'F13'
  [../]
[]
