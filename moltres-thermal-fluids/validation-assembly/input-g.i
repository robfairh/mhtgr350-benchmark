
v1 = -2124 # [cm/s]
v2 = -2496
v3 = -2507
v4 = -2521
v5 = -2560
v6 = -2495
v7 = -2493
v8 = -2504
v9 = -2522
v10 = -2514
v11 = -2520
v12 = -2565
v13 = -2565
v14 = -1210

[Mesh]
  file = assembly-gap15.msh
[../]

[Variables]
  [./temp]
    order = FIRST
    family = LAGRANGE
    initial_condition = 490
  [../]
[]

[Kernels]
  [./advection_C1]
    type = ConservativeTemperatureAdvection
    velocity = '0 0 ${v1}'
    variable = temp
    block = 'C1'
  [../]
  [./advection_C2]
    type = ConservativeTemperatureAdvection
    velocity = '0 0 ${v2}'
    variable = temp
    block = 'C2'
  [../]
  [./advection_C3]
    type = ConservativeTemperatureAdvection
    velocity = '0 0 ${v3}'
    variable = temp
    block = 'C3'
  [../]
  [./advection_C4]
    type = ConservativeTemperatureAdvection
    velocity = '0 0 ${v4}'
    variable = temp
    block = 'C4'
  [../]
  [./advection_C5]
    type = ConservativeTemperatureAdvection
    velocity = '0 0 ${v5}'
    variable = temp
    block = 'C5'
  [../]
  [./advection_C6]
    type = ConservativeTemperatureAdvection
    velocity = '0 0 ${v6}'
    variable = temp
    block = 'C6'
  [../]
  [./advection_C7]
    type = ConservativeTemperatureAdvection
    velocity = '0 0 ${v7}'
    variable = temp
    block = 'C7'
  [../]
  [./advection_C8]
    type = ConservativeTemperatureAdvection
    velocity = '0 0 ${v8}'
    variable = temp
    block = 'C8'
  [../]
  [./advection_C9]
    type = ConservativeTemperatureAdvection
    velocity = '0 0 ${v9}'
    variable = temp
    block = 'C9'
  [../]
  [./advection_C10]
    type = ConservativeTemperatureAdvection
    velocity = '0 0 ${v10}'
    variable = temp
    block = 'C10'
  [../]
  [./advection_C11]
    type = ConservativeTemperatureAdvection
    velocity = '0 0 ${v11}'
    variable = temp
    block = 'C11'
  [../]
  [./advection_C12]
    type = ConservativeTemperatureAdvection
    velocity = '0 0 ${v12}'
    variable = temp
    block = 'C12'
  [../]
  [./advection_C13]
    type = ConservativeTemperatureAdvection
    velocity = '0 0 ${v13}'
    variable = temp
    block = 'C13'
  [../]
  [./advection_C14]
    type = ConservativeTemperatureAdvection
    velocity = '0 0 ${v14}'
    variable = temp
    block = 'C14'
  [../]
  [./diffusion_cool]
    type = AnisoHeatConduction
    variable = temp
    block = 'C1 C2 C3 C4 C5 C6 C7 C8 C9 C10 C11 C12 C13 C14'
  [../]
  [./diffusion]
    type = MatDiffusion
    diffusivity = 'k'
    variable = temp
    block = 'fuel gap moderator gapc gapb'
  [../]
  [./source]
    type = BodyForce
    variable = temp
    function = heat_source
    block = 'fuel'
  [../]
[]

[Functions]
  [./heat_source]
    type = ParsedFunction
    # value = '54.978 * sin( pi/793 * z)'
    value = 27.88
  [../]
[]

[BCs]
  [./inlet]
    boundary = 'cool_top bypass_top'
    type = DirichletBC
    variable = temp
    value = 490
  [../]
  [./outlet_C1]
    boundary = 'C1_bot'
    type = TemperatureOutflowBC
    variable = temp
    velocity = '0 0 ${v1}'
  [../]
  [./outlet_C2]
    boundary = 'C2_bot'
    type = TemperatureOutflowBC
    variable = temp
    velocity = '0 0 ${v2}'
  [../]
  [./outlet_C3]
    boundary = 'C3_bot'
    type = TemperatureOutflowBC
    variable = temp
    velocity = '0 0 ${v3}'
  [../]
  [./outlet_C4]
    boundary = 'C4_bot'
    type = TemperatureOutflowBC
    variable = temp
    velocity = '0 0 ${v4}'
  [../]
  [./outlet_C5]
    boundary = 'C5_bot'
    type = TemperatureOutflowBC
    variable = temp
    velocity = '0 0 ${v5}'
  [../]
  [./outlet_C6]
    boundary = 'C6_bot'
    type = TemperatureOutflowBC
    variable = temp
    velocity = '0 0 ${v6}'
  [../]
  [./outlet_C7]
    boundary = 'C7_bot'
    type = TemperatureOutflowBC
    variable = temp
    velocity = '0 0 ${v7}'
  [../]
  [./outlet_C8]
    boundary = 'C8_bot'
    type = TemperatureOutflowBC
    variable = temp
    velocity = '0 0 ${v8}'
  [../]
  [./outlet_C9]
    boundary = 'C9_bot'
    type = TemperatureOutflowBC
    variable = temp
    velocity = '0 0 ${v9}'
  [../]
  [./outlet_C10]
    boundary = 'C10_bot'
    type = TemperatureOutflowBC
    variable = temp
    velocity = '0 0 ${v10}'
  [../]
  [./outlet_C11]
    boundary = 'C11_bot'
    type = TemperatureOutflowBC
    variable = temp
    velocity = '0 0 ${v11}'
  [../]
  [./outlet_C12]
    boundary = 'C12_bot'
    type = TemperatureOutflowBC
    variable = temp
    velocity = '0 0 ${v12}'
  [../]
  [./outlet_C13]
    boundary = 'C13_bot'
    type = TemperatureOutflowBC
    variable = temp
    velocity = '0 0 ${v13}'
  [../]
  [./outlet_C14]
    boundary = 'C14_bot'
    type = TemperatureOutflowBC
    variable = temp
    velocity = '0 0 ${v14}'
  [../]
[]

[Materials]
  # [./fuel]
  #   type = GenericConstantMaterial
  #   prop_names = 'k'
  #   prop_values = '0.07' # [W/cm/K]
  #   block = 'fuel'
  # [../]
  # [./gap]
  #   type = GenericConstantMaterial
  #   prop_names = 'k'
  #   prop_values = '3.0e-3' # [W/cm/K]
  #   block = 'gap'
  # [../]
  # [./moderator]
  #   type = GenericConstantMaterial
  #   prop_names = 'k'
  #   prop_values = '0.30' # [W/cm/K]
  #   block = 'moderator'
  # [../]
  # [./gapc]
  #   type = GenericConstantMaterial
  #   prop_names = 'k'
  #   prop_values = '0.001663' # [W/cm/K]
  #   block = 'gapc'
  # [../]

  [./fuel]
    type = PiecewiseLinearInterpolationMaterial
    property = 'k'
    variable = temp
    x = '  327 860.3 1393.7  1927' # [C]
    y = '0.061  0.08  0.099 0.118' # [W/cm/K]
    block = 'fuel'
  [../]
  [./gap]
    type = PiecewiseLinearInterpolationMaterial
    property = 'k'
    variable = temp
    x = '    327   593.7   860.3    1127' # [C]
    y = '0.00256 0.00330 0.00397 0.00460' # [W/cm/K]
    block = 'gap'
  [../]
  [./moderator]
    type = PiecewiseLinearInterpolationMaterial
    property = 'k'
    variable = temp
    x = '  327   607   887  1167  1447  1727' # [C]
    y = '0.286 0.289 0.327 0.368 0.415 0.415' # [W/cm/K]
    block = 'moderator'
  [../]
  [./gapc]
    type = PiecewiseLinearInterpolationMaterial
    property = 'k'
    variable = temp
    x = '327. 1127.' # [C]
    # y = '0.001964 0.002198'
    y = '0.00209 0.00209' # [W/cm/K]
    block = 'gapc'
  [../]
  [./gapb]
    type = PiecewiseLinearInterpolationMaterial
    property = 'k'
    variable = temp
    x = '327. 1127.' # [C]
    # y = '0.002765 0.002765' # [W/cm/K] v=2420, g=0.15
    # y = '0.001588 0.001588' # [W/cm/K] v=1210, g=0.15
    # y = '0.001382 0.001382' # [W/cm/K] v=1205, g=0.3
    # y = '0.000794 0.000794' # [W/cm/K] v=603, g=0.3
    y = '0.001382 0.001382' # [W/cm/K] v=1210, g=0.3
    block = 'gapb'
  [../]

  [./coolant_k]
    type = AnisoHeatConductionMaterial
    specific_heat = 1
    thermal_conductivity_x = 1e3
    thermal_conductivity_y = 1e3
    thermal_conductivity_z = 0
    block = 'C1 C2 C3 C4 C5 C6 C7 C8 C9 C10 C11 C12 C13 C14'
  [../]
  [./coolant_adv]
    type = GenericConstantMaterial
    prop_names = 'cp rho'
    prop_values = '5.188e3 4.369e-6' # [J/kg/K] [kg/cm3]
    block = 'C1 C2 C3 C4 C5 C6 C7 C8 C9 C10 C11 C12 C13 C14'
  [../]
[]

[Executioner]
  type = Steady
  nl_rel_tol = 1e-6
  nl_abs_tol = 1e-5
  solve_type = 'NEWTON'
  petsc_options = '-snes_converged_reason -ksp_converged_reason -snes_linesearch_monitor'

  petsc_options_iname = '-pc_type -sub_ksp_type -snes_linesearch_minlambda'
  petsc_options_value = 'lu       preonly       1e-3'

  nl_max_its = 30
  l_max_its = 100
[]

[Preconditioning]
  [./SMP]
    type = SMP
    full = true
  [../]
[]

[VectorPostprocessors]
  [./lineAB] # A is the center
    type = LineValueSampler
    variable = 'temp'
    start_point = '0 0 0'
    end_point = '0 18.15 0'
    sort_by = y
    num_points = 300
    execute_on = final
  [../]
  [./lineAC] # A is the center
    type = LineValueSampler
    variable = 'temp'
    start_point = '0 0 0'
    end_point = '10.47 18.15 0'
    sort_by = x
    num_points = 300
    execute_on = final
  [../]
  [./linecool2]
    type = LineValueSampler
    variable = 'temp'
    start_point = '2.82 4.885 0'
    end_point = '2.82 18.15 0'
    sort_by = y
    num_points = 200
    execute_on = final
  [../]
  [./linecool3]
    type = LineValueSampler
    variable = 'temp'
    start_point = '5.64 9.769 0'
    end_point = '5.64 18.15 0'
    sort_by = y
    num_points = 200
    execute_on = final
  [../]
[]

[Outputs]
  perf_graph = true
  file_base = 'input-g5'
  execute_on = 'final'
  exodus = true
  csv = true
[]

[Postprocessors]
  [./memory]
    type = MemoryUsage
    execute_on = linear
  [../]
  [./max_cool_T]
    type = NodalMaxValue
    variable = temp
    block = 'C1 C2 C3 C4 C5 C6 C7 C8 C9 C10 C11 C12 C13 C14'
  [../]
  [./max_fuel_T]
    type = NodalMaxValue
    variable = temp
    block = 'fuel'
  [../]
[]