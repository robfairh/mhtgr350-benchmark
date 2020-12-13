
[GlobalParams]
  integrate_p_by_parts = false
  order = FIRST
[]

[Mesh]
  file = test7A.msh
[]

[Variables]
  [./velocity]
    family = LAGRANGE_VEC
  [../]
  [./p]
  [../]
[]

[ICs]
  [velocity]
    type = VectorConstantIC
    x_value = 1e-15
    y_value = 1e-15
    z_value = 1e-15
    variable = velocity
  []
[]

[AuxVariables]
  [vel_x]
  []
  [vel_y]
  []
  [vel_z]
  []
[]

[AuxKernels]
  [vel_x]
    type = VectorVariableComponentAux
    variable = vel_x
    vector_variable = velocity
    component = 'x'
  []
  [vel_y]
    type = VectorVariableComponentAux
    variable = vel_y
    vector_variable = velocity
    component = 'y'
  []
  [vel_z]
    type = VectorVariableComponentAux
    variable = vel_z
    vector_variable = velocity
    component = 'z'
  []
[]

[Kernels]
  [./mass]
    type = INSADMass
    variable = p
  [../]
  [./mass_pspg]
    type = INSADMassPSPG
    variable = p
  [../]

  [./momentum_convection]
    type = INSADMomentumAdvection
    variable = velocity
  [../]
  [./momentum_viscous]
    type = INSADMomentumViscous
    variable = velocity
  [../]
  [./momentum_pressure]
    type = INSADMomentumPressure
    variable = velocity
    p = p
  [../]

  [./momentum_supg]
    type = INSADMomentumSUPG
    variable = velocity
    velocity = velocity
  [../]
[]

[BCs]
  [no_slip]
    type = ADVectorFunctionDirichletBC
    variable = velocity
    boundary = 'plenum_wall channel1_bot channel2_bot channel3_bot channel4_bot channel5_bot channel6_bot channel7_bot channel8_bot channel9_bot channel10_bot channel11_bot channel12_bot channel13_bot'
    function_x = 0
    function_y = 0
    set_z_comp = false
  []

  [null]
    type = VectorFunctionDirichletBC
    variable = velocity
    boundary = 'plenum channel_wall'
    function_x = 0
    function_y = 0
    function_z = 0
  [../]

  [inlet]
    type = VectorFunctionDirichletBC
    variable = velocity
    boundary = 'cool_top'
    function_x = 0
    function_y = 0
    function_z = 'inlet_func'
  [../]

  [pressure_pin]
    type = DirichletBC
    variable = p
    boundary = 'channel1_bot channel2_bot channel3_bot channel4_bot channel5_bot channel6_bot channel7_bot channel8_bot channel9_bot channel10_bot channel11_bot channel12_bot channel13_bot'
    value = 0
  [../]
[]

[Functions]
  [./inlet_func]
    type = ParsedFunction
    # value = '-1'
    value = '-366.23'
  [../]
[]

[Materials]
  [./const]
    type = ADGenericConstantMaterial
    prop_names = 'rho mu'
    # prop_values = '1  1'
    prop_values = '4.3679e-6 3.8236e-7'
  [../]
  [ins_mat]
    type = INSADTauMaterial
    velocity = velocity
    pressure = p
  []
[]

[Preconditioning]
  [./SMP_PJFNK]
    type = SMP
    full = true
    solve_type = Newton
  [../]
[]

[Executioner]
  type = Steady

  petsc_options = '-snes_converged_reason -ksp_converged_reason -snes_linesearch_monitor'
  
  # it works with test7-2.msh, H=5 (20 layers), H=100 (20 layers)
  # petsc_options_iname = '-pc_type -sub_pc_type -sub_pc_factor_levels'
  # petsc_options_value = 'bjacobi  ilu          4'

  # it works with test7-2.msh, H=100 (200 layers), H=100 (20 layers)
  petsc_options_iname = '-pc_type -sub_ksp_type -snes_linesearch_minlambda'
  petsc_options_value = 'lu       preonly       1e-3'

  # petsc_options_iname = '-pc_type -pc_factor_shift_type'
  # petsc_options_value = 'lu       NONZERO'
  # line_search = 'none'

  nl_rel_tol = 1e-9
  nl_max_its = 20
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
    boundary = 'channel1_bot channel2_bot channel3_bot channel4_bot channel5_bot channel6_bot channel7_bot channel8_bot channel9_bot channel10_bot channel11_bot channel12_bot channel13_bot'
    execute_on = 'timestep_end'
  [../]
  [./flow_in2]
    type = SideIntegralVariablePostprocessor
    variable = vel_z
    boundary = 'channel1_top channel2_top channel3_top channel4_top channel5_top channel6_top channel7_top channel8_top channel9_top channel10_top channel11_top channel12_top channel13_top'
    execute_on = 'timestep_end'
    # outputs = 'csv'
  [../]
  # [./channel1_in]
  #   type = SideIntegralVariablePostprocessor
  #   variable = vel_z
  #   boundary = 'channel1_top'
  #   execute_on = 'timestep_end'
  #   outputs = 'csv'
  # [../]
  # [./channel2_in]
  #   type = SideIntegralVariablePostprocessor
  #   variable = vel_z
  #   boundary = 'channel2_top'
  #   execute_on = 'timestep_end'
  #   outputs = 'csv'
  # [../]
  # [./channel3_in]
  #   type = SideIntegralVariablePostprocessor
  #   variable = vel_z
  #   boundary = 'channel3_top'
  #   execute_on = 'timestep_end'
  #   outputs = 'csv'
  # [../]
  # [./channel4_in]
  #   type = SideIntegralVariablePostprocessor
  #   variable = vel_z
  #   boundary = 'channel4_top'
  #   execute_on = 'timestep_end'
  #   outputs = 'csv'
  # [../]
  # [./channel5_in]
  #   type = SideIntegralVariablePostprocessor
  #   variable = vel_z
  #   boundary = 'channel5_top'
  #   execute_on = 'timestep_end'
  #   outputs = 'csv'
  # [../]
  # [./channel6_in]
  #   type = SideIntegralVariablePostprocessor
  #   variable = vel_z
  #   boundary = 'channel6_top'
  #   execute_on = 'timestep_end'
  #   outputs = 'csv'
  # [../]
  [./channel7_in]
    type = SideIntegralVariablePostprocessor
    variable = vel_z
    boundary = 'channel7_top'
    execute_on = 'timestep_end'
    # outputs = 'csv'
  [../]
  # [./channel8_in]
  #   type = SideIntegralVariablePostprocessor
  #   variable = vel_z
  #   boundary = 'channel8_top'
  #   execute_on = 'timestep_end'
  #   outputs = 'csv'
  # [../]
  # [./channel9_in]
  #   type = SideIntegralVariablePostprocessor
  #   variable = vel_z
  #   boundary = 'channel9_top'
  #   execute_on = 'timestep_end'
  #   outputs = 'csv'
  # [../]
  # [./channel10_in]
  #   type = SideIntegralVariablePostprocessor
  #   variable = vel_z
  #   boundary = 'channel10_top'
  #   execute_on = 'timestep_end'
  #   outputs = 'csv'
  # [../]
  # [./channel11_in]
  #   type = SideIntegralVariablePostprocessor
  #   variable = vel_z
  #   boundary = 'channel11_top'
  #   execute_on = 'timestep_end'
  #   outputs = 'csv'
  # [../]
  # [./channel12_in]
  #   type = SideIntegralVariablePostprocessor
  #   variable = vel_z
  #   boundary = 'channel12_top'
  #   execute_on = 'timestep_end'
  #   outputs = 'csv'
  # [../]
  # [./channel13_in]
  #   type = SideIntegralVariablePostprocessor
  #   variable = vel_z
  #   boundary = 'channel13_top'
  #   execute_on = 'timestep_end'
  #   outputs = 'csv'
  # [../]
  [./memory]
    type = MemoryUsage
    execute_on = linear
  [../]
[]

[Debug]
  show_var_residual_norms = true
[]

[Outputs]
  perf_graph = true
  file_base = 'nsad04A'
  execute_on = 'final'
  exodus = true
  csv = true
[]