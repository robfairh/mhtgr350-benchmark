
[GlobalParams]
  integrate_p_by_parts = false
  order = FIRST
[]

[Mesh]
  file = test6.msh
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
    boundary = 'plenum_wall channel1_bot channel2_bot channel3_bot'
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
    preset = true
    variable = p
    boundary = 'channel1_bot channel2_bot channel3_bot'
    value = 0
  [../]
[]

[Functions]
  [./inlet_func]
    type = ParsedFunction
    value = '-1'
  [../]
[]

[Materials]
  [./const]
    type = ADGenericConstantMaterial
    prop_names = 'rho mu'
    prop_values = '1  1'
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

  petsc_options_iname = '-pc_type -sub_pc_type -sub_pc_factor_levels'
  petsc_options_value = 'bjacobi  ilu          4'

  nl_rel_tol = 1e-12
  nl_max_its = 6
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
    boundary = 'channel1_bot channel2_bot channel3_bot'
    execute_on = 'timestep_end'
  [../]
[]

[Outputs]
  file_base = 'nsad03'
  execute_on = 'final'
  exodus = true
[]