
velocity1 = 2.657e3  # [cm/s]
# velocity2 = 5.944e3  # [cm/s]
velocity2 = 1e3  # [cm/s]
# velocity2 = 1.0e3  # [cm/s]

[Mesh]
  file = ../preliminar-th/3D-assembly-30-g2.msh
[../]

[Variables]
  [./temp]
    order = FIRST
    family = LAGRANGE
    initial_condition = 490
  [../]
[]

[Kernels]
  [./coolant_adv]
    type = ConservativeTemperatureAdvection
    velocity = '0 0 ${velocity1}'
    variable = temp
    block = 'coolant'
  [../]
  [./bypass_adv]
    type = ConservativeTemperatureAdvection
    velocity = '0 0 ${velocity2}'
    variable = temp
    block = 'bypass'
  [../]
  [./diffusion]
    type = MatDiffusion
    diffusivity = 'k'
    variable = temp
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
    value = '31.1' # W/cm3
  [../]
[]

[BCs]
  # [./inlet]
  #   boundary = 'cool_bottom'
  #   type = TemperatureInflowBC
  #   variable = temp
  #   uu = 0
  #   vv = 0
  #   ww = ${velocity}
  #   inlet_conc = 490
  # [../]
  [./fuel_bottoms]
    boundary = 'cool_bottom'
    type = DirichletBC
    variable = temp
    value = 490
  [../]
  [./outlet]
    boundary = 'cool_top'
    type = TemperatureOutflowBC
    variable = temp
    velocity = '0 0 ${velocity1}'
  [../]
  [./bypass_bottoms]
    boundary = 'bypass_bottom'
    type = DirichletBC
    variable = temp
    value = 490
  [../]
  [./bypass_top]
    boundary = 'bypass_top'
    type = TemperatureOutflowBC
    variable = temp
    velocity = '0 0 ${velocity2}'
  [../]

[]

[Materials]
  # [./fuel]
  #   type = GenericConstantMaterial
  #   prop_names = 'k'
  #   prop_values = '0.07'
  #   block = 'fuel'
  # [../]
  # [./moderator]
  #   type = GenericConstantMaterial
  #   prop_names = 'k'
  #   prop_values = '0.30'
  #   block = 'moderator'
  # [../]
  # [./gap]
  #   type = GenericConstantMaterial
  #   prop_names = 'k'
  #   prop_values = '2.23e-3'
  #   block = 'gap'
  # [../]
  # [./gapcoolant]
  #   type = GenericConstantMaterial
  #   prop_names = 'k'
  #   prop_values = '0.002484'
  #   block = 'gapc'
  # [../]
  # [./gapbypass]
  #   type = GenericConstantMaterial
  #   prop_names = 'k'
  #   # prop_values = '0.00001'
  #   prop_values = '0.002'
  #   # prop_values = '0.02'
  #   # prop_values = '0.2'
  #   block = 'gapb'
  # [../]
  # [./coolant_k]
  #   type = GenericConstantMaterial
  #   prop_names = 'k'
  #   prop_values = '1e3'
  #   block = 'coolant bypass'
  # [../]

  [./fuel]
    type = PiecewiseLinearInterpolationMaterial
    property = 'k'
    variable = temp
    x = ' 400  500  600  700  800  900 1000 1100' # [C]
    y = '0.06 0.06 0.07 0.07 0.07 0.08 0.08 0.08' # [W/cm/K]
    block = 'fuel'
  [../]
  [./moderator]
    type = PiecewiseLinearInterpolationMaterial
    property = 'k'
    variable = temp
    x = ' 400  500  600  700  800  900 1000 1100' # [C]
    y = '0.26 0.27 0.28 0.30 0.31 0.32 0.33 0.34' # [W/cm/K]
    block = 'moderator'
  [../]
  [./gap] # this values are wrong, they should be divided by 1e2
    type = PiecewiseLinearInterpolationMaterial
    property = 'k'
    variable = temp
    x = '450.  500.  550.  600.  650.  700.  750.  800.  850.  900.  950. 1000. 1050. 1100. 1150. 1200.' # [C]
    y = '0.29114 0.30483 0.31827 0.33147 0.34446 0.35724 0.36983 0.38224 0.39448 0.40656 0.41849 0.43028 0.44193 0.45345 0.46485 0.47614' # [W/cm/K]
    block = 'gap'
  [../]
  [./gapcoolant]
    type = PiecewiseLinearInterpolationMaterial
    property = 'k'
    variable = temp
    x = '450. 1200.' # [C]
    y = '0.002484 0.002484' # [W/cm/K]
    block = 'gapc'
  [../]
  [./gapbypass]
    type = PiecewiseLinearInterpolationMaterial
    property = 'k'
    variable = temp
    x = '450. 1200.' # [C]
    y = '0.00001 0.00001' # [W/cm/K]
    # y = '0.0001 0.0001' # [W/cm/K]
    # y = '0.001 0.001' # [W/cm/K]
    block = 'gapb'
  [../]
  [./coolant_k]
    type = PiecewiseLinearInterpolationMaterial
    property = 'k'
    variable = temp
    x = '450. 1200.' # [C]
    y = '1e3 1e3' # [W/cm/K]
    block = 'coolant bypass'
  [../]

  [./coolant_adv]
    type = GenericConstantMaterial
    prop_names = 'cp rho'
    #prop_values = '2.23e-3 5.188e3 4.368e-6' # [W/cm/K] [J/kg/K] [kg/cm3]
    prop_values = '5.188e3 4.368e-6' # [J/kg/K] [kg/cm3]
    block = 'coolant bypass'
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
  [./fuel]
    type = LineValueSampler
    variable = 'temp'
    start_point = '1.876 3.25 0'
    end_point = '1.876 3.25 793'
    sort_by = z
    num_points = 200
    execute_on = final
  [../]

  [./coolant]
    type = LineValueSampler
    variable = 'temp'
    start_point = '2.816 4.88 0'
    end_point = '2.816 4.88 793'
    sort_by = z
    num_points = 200
    execute_on = final
  [../]

  [./bypass]
    type = LineValueSampler
    variable = 'temp'
    start_point = '5.19 18.1 0'
    end_point = '5.19 18.1 793'
    sort_by = z
    num_points = 200
    execute_on = final
  [../]

  [./lineAB]
    type = LineValueSampler
    variable = 'temp'
    start_point = '0 0 793'
    end_point = '0 18.1 793'
    sort_by = y
    num_points = 200
    execute_on = final
  [../]

  [./lineAC]
    type = LineValueSampler
    variable = 'temp'
    start_point = '0 0 793'
    end_point = '10.44 18.09 793'
    sort_by = x
    num_points = 200
    execute_on = final
  [../]
[]

[Outputs]
  file_base = 'tak1'
  execute_on = 'final'
  exodus = true
  csv = true
[]