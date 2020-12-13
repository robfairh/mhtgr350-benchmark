flow_velocity = 0.997754630483832 #1.1338120800952636 #1.0204308720857374 #0.9070496640762109 #0.7936684560666845 #0.6802872480571581 #0.0694083062305294
pressure = 5
out_file = "VelBotPTop.e"
nt_scale=1e13
ini_temp=900
diri_temp=900
g1ic=67 #300
L_x = 46.75
L_y = 50.15

[GlobalParams]
  num_groups = 1
  num_precursor_groups = 0
  use_exp_form = false
  group_fluxes = 'group1'
  temperature = temp
  sss2_input = false
  #pre_concs = 'pre1 pre2 pre3 pre4 pre5 pre6'
  account_delayed = true
  pspg = true
  supg = true
  alpha = 0.3333333333
  gravity = '0 -9.81 0'
[]

[Mesh]
  file = '2D_MSRE_34_AP4_6_NoMod.e'
[../]

[Problem]
#  coord_type = RZ
#  kernel_coverage_check = false
[]

[UserObjects]
  [./uxs]
    type = SolutionUserObject
    system_variables = ux
    mesh = ${out_file}
    timestep = LATEST
    execute_on = initial
  [../]
  [./uys]
    type = SolutionUserObject
    system_variables = uy
    mesh = ${out_file}
    timestep = LATEST
    execute_on = initial
  [../]
  [./ps]
    type = SolutionUserObject
    system_variables = p
    mesh = ${out_file}
    timestep = LATEST
    execute_on = initial
  [../]
[]

[Functions]
  [./velFunc]
    type = ParsedFunction
    value = ${flow_velocity}
    #value = '0 + (${flow_velocity}) * tanh((60-0)/4)'
  [../]
  [./uxf]
    type = SolutionFunction
    solution = uxs
  [../]
  [./uyf]
    type = SolutionFunction
    solution = uys
  [../]
  [./pf]
    type = SolutionFunction
    solution = ps
  [../]
  [./temp_bc_func]
    type = ParsedFunction
    value = '${ini_temp} - (${ini_temp} - ${diri_temp}) * tanh((t-0)/1e-0)'
  [../]
  [./group1_ic_func]
    type = ParsedFunction
    value = '(${g1ic} * cos((y*pi)/(2*${L_y})) * cos((x*pi)/(2*${L_x})))*(x<=${L_x})*(y<=${L_y})*(y>=(-${L_y}))'
  [../]
#  [./pFunc]
#    type = ParsedFunction
#    value = '0 + (${pressure}) * tanh((t-0)/1)'
#  [../]
[]

[Variables]
  [./temp]
    initial_condition = ${ini_temp}
    #scaling = 1e-4
    #block = 'fuel moderFcap'
  [../]
  [./ux]
    family = LAGRANGE
    order = FIRST
    block = 'fuel moderFcap'
    #scaling = 1e-4
  [../]
  [./uy]
    family = LAGRANGE
    order = FIRST
    block = 'fuel moderFcap'
    #scaling = 1e-4
  [../]
  [./p]
    family = LAGRANGE
    order = FIRST
    block = 'fuel moderFcap'
    #scaling = 1e-4
  [../]
[]

[AuxVariables]
  [./group1]
    order = FIRST
    family = LAGRANGE
    block = 'fuel'
    scaling = 1e4
  [../]
[]

[ICs]
  [./g1_ic]
    type = FunctionIC
    variable = group1
    function = group1_ic_func
  [../]
  [./ux_ic]
    type = FunctionIC
    variable = ux
    function = uxf
  [../]
  [./uy_ic]
    type = FunctionIC
    variable = uy
    function = uyf
  [../]
  [./p_ic]
    type = FunctionIC
    variable = p
    function = pf
  [../]
[]

[Kernels]
  # Neutronics
  #[./time_group1]
  #  type = NtTimeDerivative
  #  variable = group1
  #  group_number = 1
  #  block = 'fuel moderFcap'
  #[../]
  [./temp_source_fuel]
    type = TransientFissionHeatSource
    variable = temp
    nt_scale=${nt_scale}
    block = 'fuel'
  [../]
  # Temperature
  [./temp_time_derivative]
    type = MatINSTemperatureTimeDerivative
    variable = temp
    #block = 'fuel moderFcap'
  [../]
  #[./temp_diffusion]
  #  type = MatDiffusion
  #  D_name = 'k'
  #  variable = temp
  #  #block = 'fuel moderFcap'
  #[../]
  [./temp_all]
    type = INSTemperature
    variable = temp
    u = ux
    v = uy
    #block = 'fuel moderFcap'
  [../]
  #[./temp_time]
  #  type = INSTemperatureTimeDerivative
  #  variable = temp
  #  block = 'fuel moderFcap'
  #[../]
  # [./temp_source_mod]
  #   type = GammaHeatSource
  #   variable = temp
  #   gamma = .0144 # Cammi .0144
  #   block = 'moder'
  #   average_fission_heat = 'average_fission_heat'
  # [../]
  #[./temp_diffusion]
  #  type = MatDiffusion
  #  D_name = 'k'
  #  variable = temp
  #[../]
  #[./temp_advection_fuel]
  #  type = ConservativeTemperatureAdvection
  #  velocity = '0 ${flow_velocity} 0'
  #  variable = temp
  #  block = 'fuel'
  #[../]
  
  # INS
  [./mass]
    type = INSMass
    variable = p
    u = ux
    v = uy
    p = p
    #pspg = true
    #alpha = 0.33333333
    block = 'fuel moderFcap'
  [../]
  [./x_time_deriv]
    type = INSMomentumTimeDerivative
    variable = ux
    block = 'fuel moderFcap'
  [../]
  [./y_time_deriv]
    type = INSMomentumTimeDerivative
    variable = uy
    block = 'fuel moderFcap'
  [../]
  [./x_momentum_space]
    type = INSMomentumTractionForm
    variable = ux
    u = ux
    v = uy
    p = p
    component = 0
    #supg = true
    #alpha = 0.333333333
    block = 'fuel moderFcap'
  [../]
  [./y_momentum_space]
    type = INSMomentumTractionForm
    variable = uy
    u = ux
    v = uy
    p = p
    component = 1
    #supg = true
    #alpha = 0.333333333
    block = 'fuel moderFcap'
  [../]
[]

[BCs]
  [./temp_diri_cg]
    #boundary = 'super_bots outer_wall'
    boundary = 'fuel_bottoms moderFcapBots'
    type = FunctionDirichletBC
    function = 'temp_bc_func'
    variable = temp
  [../]
  #[./temp_advection_outlet]
  #  boundary = 'fuel_tops'
  #  type = TemperatureOutflowBC
  #  variable = temp
  #  velocity = '0 ${flow_velocity} 0'
  #[../]
  #[./p_inlet]
  #  type = FunctionDirichletBC
  #  boundary = 'fuel_bottoms moderFcapBots'
  #  variable = p
  #  function = 'pFunc'
  #[../]
  [./p_outlet]
    type = DirichletBC
    boundary = 'fuel_tops moderFcapTops'
    variable = p
    value = 0
  [../]
  #[./p_inlet]
  #  type = DirichletBC
  #  boundary = 'fuel_bottoms moderFcapBots'
  #  variable = p
  #  value = 0
  #[../]
  [./uy_inlet]
    type = FunctionDirichletBC
    boundary = 'fuel_bottoms moderFcapBots'
    variable = uy
    function = 'velFunc'
  [../]
  [./ux_inlet]
    type = DirichletBC
    boundary = 'fuel_bottoms moderFcapBots'
    variable = ux
    value = 0
  [../]
  #[./uy_outlet]
  #  type = FunctionDirichletBC
  #  boundary = 'fuel_tops moderFcapTops'
  #  variable = uy
  #  function = 'velFunc'
  #[../]
  [./ux_outlet]
    type = DirichletBC
    boundary = 'fuel_tops moderFcapTops'
    variable = ux
    value = 0
  [../]
  [./no_slip_BC]
    type = DirichletBC
    boundary = 'moder_surface'
    variable = ux
    value = 0
  [../]
  [./no_slip_BC2]
    type = DirichletBC
    boundary = 'moder_surface'
    variable = uy
    value = 0
  [../]
  [./symmetry_BC]
    type = DirichletBC
    boundary = 'fuel_cens'
    variable = ux
    value = 0
  [../]
[]

[Materials]
  [./fuel]
    type = GenericMoltresMaterial
    property_tables_root = './property_file_dir/newt_one_group_msre_fuel_'
    interp_type = 'spline'
    block = 'fuel'
    prop_names = 'k cp mu'
    prop_values = '.0553 1967 7.85419853e-5' # Robertson MSRE technical report @ 922 K
  [../]
  [./rho_fuel]
    type = DerivativeParsedMaterial
    f_name = rho
    function = '2.146e-3 * exp(-1.8 * 1.18e-4 * (temp - 922))'
    args = 'temp'
    derivative_order = 1
    block = 'fuel'
  [../]
  [./moderFcap]
    type = GenericMoltresMaterial
    property_tables_root = './property_file_dir/newt_one_group_msre_fuel_'
    interp_type = 'spline'
    block = 'moderFcap'
    prop_names = 'k cp mu'
    prop_values = '.0553 1967 7.85419853e-5' # Robertson MSRE technical report @ 922 K
  [../]
  [./rho_moderFcap]
    type = DerivativeParsedMaterial
    f_name = rho
    function = '2.146e-3 * exp(-1.8 * 1.18e-4 * (temp - 922))'
    args = 'temp'
    derivative_order = 1
    block = 'moderFcap'
  [../]
[]

[Executioner]
  type = Transient
  start_time = 0
  end_time = 120

  nl_rel_tol = 1e-6
  nl_abs_tol = 1e-6

  solve_type = 'NEWTON'
  petsc_options = '-snes_converged_reason -ksp_converged_reason -snes_linesearch_monitor'
  petsc_options_iname = '-pc_type -pc_factor_shift_type'
  petsc_options_value = 'lu       NONZERO'
  line_search = 'none'
   # petsc_options_iname = '-snes_type'
  # petsc_options_value = 'test'

  nl_max_its = 10
  l_max_its = 100

  dtmin = 1e-8
  dtmax = 0.08

  [./TimeStepper]
    type = IterationAdaptiveDT
    dt = 0.08
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
  [./group1_current]
    type = IntegralNewVariablePostprocessor
    variable = group1
    block = 'fuel'
    outputs = 'console exodus'
  [../]
  [./temp_fuel]
    type = ElementAverageValue
    variable = temp
    block = 'fuel moderFcap'
    outputs = 'exodus console'
  [../]
  [./coreEndTemp]
    type = SideAverageValue
    variable = temp
    boundary = 'fuel_tops'
    outputs = 'exodus console'
  [../]
  [./total_fission_heat]
    type = ElmIntegTotFissHeatPostprocessor
    nt_scale = ${nt_scale}
    execute_on = 'linear nonlinear'
    outputs = 'exodus console'
    block = 'fuel'
  [../]
  [./PowerOutput_MW_cm]
    type = DivisionPostprocessor
    value1 = total_fission_heat
    value2 = 1000000
    outputs = 'console exodus'
  [../]
  [./maxLocalTemp]
    type = ElementExtremeValue
    variable = temp
    block = 'fuel moderFcap'
    outputs = 'exodus console'
  [../]
  #[./pressure]
  #  type = FunctionValuePostprocessor
  #  function = pFunc
  #  outputs = 'console exodus'
  #[../]
  [./inletFlowVelocity]
    type = SideAverageValue
    variable = uy
    boundary = 'fuel_bottoms moderFcapBots'
    outputs = 'exodus console'
  [../]
  [./outletFlowVelocity]
    type = SideAverageValue
    variable = uy
    boundary = 'fuel_tops moderFcapTops'
    outputs = 'exodus console'
  [../]
  [./channel_00]
    type = SideAverageValue
    variable = uy
    boundary = 'channel_tops0'
    outputs = 'exodus'
  [../]
  [./channel_01]
    type = SideAverageValue
    variable = uy
    boundary = 'channel_tops1'
    outputs = 'exodus'
  [../]
  [./channel_02]
    type = SideAverageValue
    variable = uy
    boundary = 'channel_tops2'
    outputs = 'exodus'
  [../]
  [./channel_03]
    type = SideAverageValue
    variable = uy
    boundary = 'channel_tops3'
    outputs = 'exodus'
  [../]
  [./channel_04]
    type = SideAverageValue
    variable = uy
    boundary = 'channel_tops4'
    outputs = 'exodus'
  [../]
  [./channel_05]
    type = SideAverageValue
    variable = uy
    boundary = 'channel_tops5'
    outputs = 'exodus'
  [../]
  [./channel_06]
    type = SideAverageValue
    variable = uy
    boundary = 'channel_tops6'
    outputs = 'exodus'
  [../]
  [./channel_07]
    type = SideAverageValue
    variable = uy
    boundary = 'channel_tops7'
    outputs = 'exodus'
  [../]
  [./channel_08]
    type = SideAverageValue
    variable = uy
    boundary = 'channel_tops8'
    outputs = 'exodus'
  [../]
  [./channel_09]
    type = SideAverageValue
    variable = uy
    boundary = 'channel_tops9'
    outputs = 'exodus'
  [../]
  [./channel_10]
    type = SideAverageValue
    variable = uy
    boundary = 'channel_tops10'
    outputs = 'exodus'
  [../]
  [./channel_11]
    type = SideAverageValue
    variable = uy
    boundary = 'channel_tops11'
    outputs = 'exodus'
  [../]
  [./channel_12]
    type = SideAverageValue
    variable = uy
    boundary = 'channel_tops12'
    outputs = 'exodus'
  [../]
  [./channel_13]
    type = SideAverageValue
    variable = uy
    boundary = 'channel_tops13'
    outputs = 'exodus'
  [../]
  [./channel_14]
    type = SideAverageValue
    variable = uy
    boundary = 'channel_tops14'
    outputs = 'exodus console'
  [../]
[]

[Outputs]
  perf_graph = true
  print_linear_residuals = true
  [./exodus]
    type = Exodus
    file_base = 'Heated67_88'
    execute_on = 'initial timestep_end'
  [../]
[]

[Debug]
  show_var_residual_norms = true
[]

