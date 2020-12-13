flow_velocity = 59.4
pressure = 5
out_file = "DobVelPTop.e"
nt_scale=1e13
ini_temp=823.15
g1ic = 196 # W/cm3 #100
#g2ic = 4
L_z1 = -150
L_z2 = -21

[GlobalParams]
  num_groups = 0
  num_precursor_groups = 0
  use_exp_form = false
  group_fluxes = ''
  temperature = temp
  sss2_input = true
  #pre_concs = 'pre1 pre2 pre3 pre4 pre5 pre6'
  account_delayed = true
  pspg = true
  supg = true
  #alpha = 0.3333333333
  gravity = '0 0 -9.81'
  rho_name = 'rhoAD'
  #mu_name = 'muAD'
  k_name = 'kAD'
  cp_name = 'cpAD'
[]

[Mesh]
  file = ${out_file}
[../]

[Problem]
#  coord_type = RZ
  kernel_coverage_check = false
[]

[UserObjects]
  [./uxs]
    type = SolutionUserObject
    system_variables = vel_x
    mesh = ${out_file}
    timestep = LATEST
    execute_on = initial
  [../]
  [./uys]
    type = SolutionUserObject
    system_variables = vel_y
    mesh = ${out_file}
    timestep = LATEST
    execute_on = initial
  [../]
  [./uzs]
    type = SolutionUserObject
    system_variables = vel_z
    mesh = ${out_file}
    timestep = LATEST
    execute_on = initial
  [../]
[]

[Variables]
  [./vel]
    family = LAGRANGE_VEC
    order = FIRST
    block = 'V_FUEL'
    #scaling = 1e-4
  [../]
  [./p]
    family = LAGRANGE
    order = FIRST
    block = 'V_FUEL'
    initial_from_file_var = p
    initial_from_file_timestep = LATEST
    scaling = 1e-2
  [../]
  [./temp]
    initial_condition = ${ini_temp}
    #scaling = 1e-4
    #block = 'V_FUEL'
  [../]
[]

[Functions]
  [./velFunc]
    type = ParsedFunction
    value = '0 + (${flow_velocity}) * tanh((t-0)/4)'
  [../]
  [./group1_ic_func]
    type = ParsedFunction
    value = '0 + (${g1ic} * (z>=${L_z1})*(z<=${L_z2}))'
  [../]
  #[./group2_ic_func]
  #  type = ParsedFunction
  #  value = '0 + (${g2ic} * (z>=${L_z1})*(z<=${L_z2}))'
  #[../]
  [./temp_bc_func]
    type = ParsedFunction
    value = '${ini_temp}'
  [../]
  [./uxf]
    type = SolutionFunction
    solution = uxs
  [../]
  [./uyf]
    type = SolutionFunction
    solution = uys
  [../]
  [./uzf]
    type = SolutionFunction
    solution = uzs
  [../]
  [./zero]
    type = ParsedFunction
    value = '0'
  [../]
[]

#[AuxVariables]
#  [./group1]
#    order = FIRST
#    family = LAGRANGE
#    block = 'V_FUEL'
#    scaling = 1e4
#  [../]
#  [./group2]
#    order = FIRST
#    family = LAGRANGE
#    block = 'V_FUEL'
#    scaling = 1e4
#  [../]
#[]

[ICs]
  #[./g1_ic]
  #  type = FunctionIC
  #  variable = group1
  #  function = group1_ic_func
  #[../]
  #[./g2_ic]
  #  type = FunctionIC
  #  variable = group2
  #  function = group2_ic_func
  #[../]
  [./vel_ic]
    type = VectorFunctionIC
    variable = vel
    function_x = uxf
    function_y = uyf
    function_z = uzf
    block = 'V_FUEL'
  [../]
[]

[Kernels]
  # Neutronics
  #[./temp_source_fuel]
  #  type = TransientFissionHeatSource
  #  variable = temp
  #  nt_scale=${nt_scale}
  #  block = 'V_FUEL'
  #[../]
  # Temperature
  [./temp_time_derivative]
    type = MatINSTemperatureTimeDerivative
    variable = temp
    block = 'V_CLAD'
  [../]
  [./temp_diffusion]
    type = MatDiffusion
    D_name = 'k'
    variable = temp
    block = 'V_CLAD'
  [../]
  # INS
  [./mass]
    type = INSADMass
    variable = p
    block = 'V_FUEL'
  [../]
  [./mass_pspg]
    type = INSADMassPSPG
    variable = p
    block = 'V_FUEL'
  [../]
  [./momentum_time]
    type = INSADMomentumTimeDerivative
    variable = vel
    block = 'V_FUEL'
  [../]
  [./momentum_convection]
    type = INSADMomentumAdvection
    variable = vel
    block = 'V_FUEL'
  [../]
  [./momentum_viscous]
    type = INSADMomentumViscous
    variable = vel
    block = 'V_FUEL'
  [../]
  [./momentum_pressure]
    type = INSADMomentumPressure
    variable = vel
    p = p
    integrate_p_by_parts = false
    block = 'V_FUEL'
  [../]
  [./momentum_gravity]
    type = INSADGravityForce
    variable = vel
    p = p
    block = 'V_FUEL'
  [../]
  [./momentum_boussinesq]
    type = INSADBoussinesqBodyForce
    variable = vel
    temperature = temp
    block = 'V_FUEL'
  [../]
  [./momentum_supg]
    type = INSADMomentumSUPG
    variable = vel
    velocity = vel
    block = 'V_FUEL'
  [../]
  [./temperature_advection]
    type = INSADEnergyAdvection
    variable = temp
    block = 'V_FUEL'
  [../]
  [temperature_time]
    type = INSADHeatConductionTimeDerivative
    variable = temp
    block = 'V_FUEL'
  [../]
  [./temperature_conduction]
    type = ADHeatConduction
    variable = temp
    thermal_conductivity = 'kAD'
    block = 'V_FUEL'
  [../]
  [temperature_source]
    type = INSADEnergySource
    variable = temp
    source_function = 'group1_ic_func'
    block = 'V_FUEL'
  [../]
  [temperature_supg]
    type = INSADEnergySUPG
    variable = temp
    velocity = vel
    block = 'V_FUEL'
  [../]
[]

[BCs]
  [./temp_diri_cg]
    boundary = 'S_BOTTOM_FUEL_CAP_BOT S_BOTTOM_FUEL'
    type = FunctionDirichletBC
    function = 'temp_bc_func'
    variable = temp
  [../]
  
  #[./p_inlet]
  #  type = FunctionDirichletBC
  #  boundary = 'S_BOTTOM_FUEL_CAP_BOT S_BOTTOM_FUEL'
  #  variable = p
  #  function = 'pFunc'
  #[../]
  [./p_outlet]
    type = DirichletBC
    boundary = 'S_TOP_FUEL_CAP_TOP S_TOP_FUEL'
    variable = p
    value = 0
  [../]
  #[./p_inlet]
  #  type = DirichletBC
  #  boundary = 'S_BOTTOM_FUEL_CAP_BOT S_BOTTOM_FUEL'
  #  variable = p
  #  value = 0
  #[../]
  [./inlet]
    type = VectorDirichletBC
    boundary = 'S_BOTTOM_FUEL_CAP_BOT S_BOTTOM_FUEL'
    variable = vel
    values = '0 0 59.4'
  [../]
  [./outlet]
    type = VectorDirichletBC
    boundary = 'S_TOP_FUEL_CAP_TOP S_TOP_FUEL'
    variable = vel
    values = '0 0 59.4'
  [../]
  [./no_slip_BC]
    type = VectorDirichletBC
    boundary = 'S_CLAD'
    variable = vel
    values = '0 0 0'
  [../]
  [./symmetry_BC1]
    type = ADVectorFunctionDirichletBC
    boundary = 'S_X0 S_XOUT'
    variable = vel
    set_x_comp = False
    set_z_comp = False
    function_y = 'zero'
  [../]
  [./symmetry_BC2]
    type = ADVectorFunctionDirichletBC
    boundary = 'S_Y0 S_YOUT'
    variable = vel
    set_y_comp = False
    set_z_comp = False
    function_x = 'zero'
  [../]
[]

[Materials]
  [./fuel]
    type = GenericMoltresMaterial
    property_tables_root = '../TAP_Properties/tap_2g_fuel_'
    interp_type = 'spline'
    block = 'V_FUEL'
    prop_names = 'k cp' # rho' #k in W/cmK, cp in JK-1kg-1
    prop_values = '0.05 746.66' # 0.0050579532'
  [../]
  [./rho_fuel]
    type = DerivativeParsedMaterial
    f_name = rho #rho in kgcm-3
    function = '6.105e-3 - (0.000001272 * temp)' #Estimated from G. J. Janz (1972) @ 900 K
    args = 'temp'
    derivative_order = 1
    block = 'V_FUEL'
  [../]
  [./fuelAD]
    type = ADGenericConstantMaterial
    property_tables_root = '../TAP_Properties/tap_2g_fuel_'
    interp_type = 'spline'
    block = 'V_FUEL'
    prop_names = 'kAD cpAD rhoAD alpha' # mu' # rho' #k in W/cmK, cp in JK-1kg-1
    prop_values = '0.05 746.66 6.105e-3 0.00020835380835380836' # 0.000209' # 0.0050579532'
  [../]
  [./reference_temp]
    type = GenericConstantMaterial
    block = 'V_FUEL'
    prop_names =  'temp_ref'
    prop_values = '0'
  [../]
  #[./rho_fuelAD]
  #  type = ADDerivativeParsedMaterial
  #  f_name = rhoAD #rho in kgcm-3
  #  function = '6.105e-3 - (0.000001272 * temp)' #Estimated from G. J. Janz (1972) @ 900 K
  #  args = 'temp'
  #  derivative_order = 1
  #  block = 'V_FUEL'
  #[../]
  [./mu_fuelAD]
    type = ADDerivativeParsedMaterial
    f_name = mu #mu in Pa.s (cm)
    function = '(10.76111581e-5)*(temp/1000)^(-4.833548134)' #Estimated from G. J. Janz (1972) @ 900 K
    args = 'temp'
    derivative_order = 1
    block = 'V_FUEL'
  [../]
  [./clad]
    type = GenericMoltresMaterial
    property_tables_root = '../TAP_Properties/tap_2g_mod_'
    interp_type = 'spline'
    prop_names = 'k cp'
    prop_values = '0.1975 726.744' # Estimated & Extrapolated from Shinsuke (2001) @ 900 K (Cp 67.5JK-1mol-1)
    block = 'V_CLAD'
  [../]
  [./rho_clad]
    type = DerivativeParsedMaterial
    f_name = rho
    function = '5.66e-3 - (0.000000000001 * temp)' #Used value Dan used, at 900 K
    args = 'temp'
    derivative_order = 1
    block = 'V_CLAD'
  [../]
  #[ins_mat]
  #  type = INSADMaterial
  #  velocity = vel
  #  pressure = p
  #  block = 'V_FUEL'
  #[../]
  #[ins_mat_tau]
  #  type = INSADTauMaterial
  #  velocity = vel
  #  pressure = p
  #  block = 'V_FUEL'
  #[../]
  #[ins_mat_energy]
  #  type = INSAD3Eqn
  #  velocity = vel
  #  pressure = p
  #  temperature = temp
  #  block = 'V_FUEL'
  #[../]
  [ins_mat_tau_energy]
    type = INSADStabilized3Eqn
    velocity = vel
    pressure = p
    temperature = temp
    block = 'V_FUEL'
  [../]
[]

[Executioner]
  type = Transient
  start_time = 30
  end_time = 300

  nl_rel_tol = 1e-6
  nl_abs_tol = 1e-6

  solve_type = 'NEWTON'
  petsc_options = '-snes_converged_reason -ksp_converged_reason -snes_linesearch_monitor'
  petsc_options_iname = '-pc_type -sub_pc_type -pc_factor_shift_type'
  petsc_options_value = 'lu       lu           NONZERO'
  line_search = 'none'
   # petsc_options_iname = '-snes_type'
  # petsc_options_value = 'test'

  nl_max_its = 10
  l_max_its = 100

  dtmin = 1e-8
  dtmax = 0.08

  [./TimeStepper]
    type = IterationAdaptiveDT
    dt = 0.01
    cutback_factor = 0.9170040432046712
    growth_factor = 1.0905077326652577
    optimal_iterations = 5
    iteration_window = 1
    linear_iteration_ratio = 100
  [../]
[]

[Preconditioning]
  [./SMP]
    type = SMP
    full = true
  [../]
[]

[Postprocessors]
  #[./inletFlowVelocity]
  #  type = SideAverageValue
  #  variable = uz
  #  boundary = 'S_BOTTOM_FUEL_CAP_BOT S_BOTTOM_FUEL'
  #  outputs = 'exodus console'
  #[../]
  #[./outletFlowVelocity]
  #  type = SideAverageValue
  #  variable = uz
  #  boundary = 'S_TOP_FUEL_CAP_TOP S_TOP_FUEL'
  #  outputs = 'exodus console'
  #[../]
  #[./group1_current]
  #  type = IntegralNewVariablePostprocessor
  #  variable = group1
  #  block = 'V_FUEL'
  #  outputs = 'console exodus'
  #[../]
  [./temp_fuel]
    type = ElementAverageValue
    variable = temp
    block = 'V_FUEL'
    outputs = 'exodus console'
  [../]
  [./coreEndTemp]
    type = SideAverageValue
    variable = temp
    boundary = 'S_TOP_FUEL_CAP_TOP S_TOP_FUEL'
    outputs = 'exodus console'
  [../]
  #[./total_fission_heat]
  #  type = ElmIntegTotFissHeatPostprocessor
  #  nt_scale = ${nt_scale}
  #  execute_on = 'linear nonlinear'
  #  outputs = 'exodus console'
  #  block = 'V_FUEL'
  #[../]
  #[./percentPowerOutput]
  #  type = DivisionPostprocessor
  #  value1 = total_fission_heat
  #  value2 = 1562500
  #  outputs = 'console exodus'
  #[../]
  [./maxLocalTemp]
    type = ElementExtremeValue
    variable = temp
    block = 'V_FUEL'
    outputs = 'exodus console'
  [../]
  #[./pressure]
  #  type = FunctionValuePostprocessor
  #  function = pFunc
  #  outputs = 'console exodus'
  #[../]
[]

[Outputs]
  perf_graph = true
  print_linear_residuals = true
  [./exodus]
    type = Exodus
    file_base = 'DobVelPTopHeated'
    execute_on = 'initial timestep_end'
  [../]
[]

[Debug]
  show_var_residual_norms = true
[]