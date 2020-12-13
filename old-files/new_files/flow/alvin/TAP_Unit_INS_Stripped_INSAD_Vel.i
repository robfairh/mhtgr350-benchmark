flow_velocity = 59.4
pressure = 5
out_file = "DobVelPTop.e"
nt_scale=1e13
ini_temp=823.15
g1ic = 0 #196 # W/cm3 #100
#g2ic = 4
L_z1 = -150
L_z2 = -21

[GlobalParams]
  num_groups = 0
  num_precursor_groups = 0
  use_exp_form = false
  group_fluxes = ''
  #temperature = temp
  sss2_input = true
  #pre_concs = 'pre1 pre2 pre3 pre4 pre5 pre6'
  account_delayed = true
  pspg = true
  supg = true
  #alpha = 0.3333333333
  gravity = '0 0 -9.81'
  rho_name = 'rhoAD'
  mu_name = 'muAD'
  k_name = 'kAD'
  cp_name = 'cpAD'
[]

[Mesh]
  file = 'TAP_Unit_Cell_INS_025.e'
[../]

[Problem]
#  coord_type = RZ
  kernel_coverage_check = false
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
    scaling = 1e-2
  [../]
[]

[Functions]
  [./velFunc]
    type = ParsedFunction
    value = '0 + (${flow_velocity}) * tanh((t-0)/4)'
  [../]
  #[./group1_ic_func]
  #  type = ParsedFunction
  #  value = '0 + (${g1ic} * (z>=${L_z1})*(z<=${L_z2}))'
  #[../]
  #[./group2_ic_func]
  #  type = ParsedFunction
  #  value = '0 + (${g2ic} * (z>=${L_z1})*(z<=${L_z2}))'
  #[../]
  [./zero]
    type = ParsedFunction
    value = '0'
  [../]
  [./p_ic_func]
    type = ParsedFunction
    value = '((z-175)*0.0050579532*(-9.81))'
  [../]
[]

[ICs]
  [velocity]
    type = VectorConstantIC
    x_value = 0
    y_value = 0
    z_value = 0.1
    variable = vel
  []
  [./p_ic]
    type = FunctionIC
    variable = p
    function = p_ic_func
  [../]
[]

[Kernels]
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
  [./momentum_supg]
    type = INSADMomentumSUPG
    variable = vel
    velocity = vel
    block = 'V_FUEL'
  [../]
[]

[BCs]
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
    type = ADVectorFunctionDirichletBC
    boundary = 'S_BOTTOM_FUEL_CAP_BOT S_BOTTOM_FUEL'
    variable = vel
    function_x = 'zero'
    function_y = 'zero'
    function_z = 'velFunc'
  [../]
  [./outlet]
    type = ADVectorFunctionDirichletBC
    boundary = 'S_TOP_FUEL_CAP_TOP S_TOP_FUEL'
    variable = vel
    function_x = 'zero'
    function_y = 'zero'
    function_z = 'velFunc'
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
    type = ADGenericConstantMaterial
    property_tables_root = '../TAP_Properties/tap_2g_fuel_'
    interp_type = 'spline'
    block = 'V_FUEL'
    prop_names = 'kAD cpAD muAD rhoAD' #k in W/cmK, cp in JK-1kg-1
    prop_values = '0.05 746.66 0.0002756726693538852 0.0050579532'
  [../]
  [./clad]
    type = GenericMoltresMaterial
    property_tables_root = '../TAP_Properties/tap_2g_fuel_'
    interp_type = 'spline'
    block = 'V_CLAD'
    prop_names = 'k cp mu rho' #k in W/cmK, cp in JK-1kg-1
    prop_values = '0.05 746.66 0.000209 0.0050579532'
  [../]
  #[ins_mat]
  #  type = INSADMaterial
  #  velocity = vel
  #  pressure = p
  #  block = 'V_FUEL'
  #[../]
  [ins_mat_tau]
    type = INSADTauMaterial
    velocity = vel
    pressure = p
    block = 'V_FUEL'
  [../]
  #[ins_mat_energy]
  #  type = INSAD3Eqn
  #  velocity = vel
  #  pressure = p
  #  temperature = temp
  #  block = 'V_FUEL'
  #[../]
  #[ins_mat_tau_energy]
  #  type = INSADStabilized3Eqn
  #  velocity = vel
  #  pressure = p
  #  temperature = temp
  #  block = 'V_FUEL'
  #[../]
[]

[Executioner]
  type = Transient
  start_time = 0
  end_time = 30

  nl_rel_tol = 1e-6
  nl_abs_tol = 1e-6

  solve_type = 'NEWTON'
  petsc_options = '-snes_converged_reason -ksp_converged_reason -snes_linesearch_monitor'
  petsc_options_iname = '-pc_type -sub_pc_type -pc_factor_shift_type'
  petsc_options_value = 'lu       lu           NONZERO'
  #petsc_options_iname = '-pc_type -sub_pc_type -sub_pc_factor_levels -ksp_gmres_restart'
  #petsc_options_value = 'asm      lu           6                     200'
  line_search = 'none'

  nl_max_its = 10
  l_max_its = 100

  dtmin = 1e-5
  dtmax = 0.08

  [./TimeStepper]
    type = IterationAdaptiveDT
    dt = 0.001
    cutback_factor = 0.5 #0.9170040432046712
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
  [./Velocity]
    type = FunctionValuePostprocessor
    function = velFunc
    outputs = 'console exodus'
  [../]
[]

[Outputs]
  perf_graph = true
  print_linear_residuals = true
  [./exodus]
    type = Exodus
    file_base = 'DobVelPTop'
    execute_on = 'initial timestep_end'
  [../]
[]

[Debug]
  show_var_residual_norms = true
[]