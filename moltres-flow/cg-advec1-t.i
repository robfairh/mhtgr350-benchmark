velocity = 0.5

[Mesh]
  type = GeneratedMesh
  dim = 2
  nx = 1
  ny = 100
  xmax = 2
  ymax = 100
  elem_type = QUAD4
[../]

[Variables]
  [./temp]
    order = FIRST
    family = LAGRANGE
    initial_condition = 930
  [../]
[]

[Kernels]
  [./time_derivative]
    type = MatINSTemperatureTimeDerivative
    variable = temp
  [../]
  [./advection]
    type = ConservativeTemperatureAdvection
    velocity = '0 ${velocity} 0'
    variable = temp
  [../]
  [./Diffusion]
    type = AnisoHeatConduction
    variable = temp
  [../]
[]

[BCs]
  [./fuel_bottoms_looped]
    boundary = 'bottom'
    type = TemperatureInflowBC
    variable = temp
    uu = 0
    vv = ${velocity}
    ww = 0
    inlet_conc = 930
  [../]
  [./temp_advection_outlet]
    boundary = 'top'
    type = TemperatureOutflowBC
    variable = temp
    velocity = '0 ${velocity} 0'
  [../]
  [./heat_wall]
    boundary = 'right'
    type = FunctionNeumannBC
    variable = temp
    function = 'heat_flux'
  [../]
[]

[Functions]
  [./heat_flux]
    type = ParsedFunction
    value = '10 * sin( pi/100 * y)'
  [../]
[]

[Materials]
  [./coolant]
    type = GenericConstantMaterial
    prop_names = 'k cp rho'
    #prop_values = '1 2e3 1e-2'
    prop_values = '1e4 2e3 1e-2'
  [../]

  [./heat]
    type = AnisoHeatConductionMaterial
    specific_heat = 1
    thermal_conductivity_x = 1e3
    thermal_conductivity_y = 0
    thermal_conductivity_z = 0
  [../]
[]

[Executioner]
  type = Transient
  end_time = 250
  scheme = crank-nicolson
  [./TimeStepper]
    type = ConstantDT
    dt = 1
  [../]
  
  nl_rel_tol = 1e-6
  nl_abs_tol = 1e-5
  solve_type = 'NEWTON'

  # petsc_options = '-snes_converged_reason -ksp_converged_reason -snes_linesearch_monitor'
  # petsc_options_iname = '-pc_type -sub_pc_type -pc_asm_overlap -sub_ksp_type -snes_linesearch_minlambda'
  # petsc_options_value = 'asm      lu           1               preonly       1e-3'
  # nl_max_its = 30
  # l_max_its = 100
[]

[Preconditioning]
  [./SMP]
    type = SMP
    full = true
  [../]
[]

[VectorPostprocessors]
  [./center]
    type = LineValueSampler
    variable = 'temp'
    start_point = '0 0 0'
    end_point = '0 100 0'
    sort_by = y
    num_points = 100
    execute_on = final
  [../]

  [./outer]
    type = LineValueSampler
    variable = 'temp'
    start_point = '2 0 0'
    end_point = '2 100 0'
    sort_by = y
    num_points = 100
    execute_on = final
  [../]

  [./across]
    type = LineValueSampler
    variable = 'temp'
    start_point = '0 50 0'
    end_point = '2 50 0'
    sort_by = x
    num_points = 10
    execute_on = final
  [../]
[]

[Outputs]
  file_base = 'cg-advec1-ss'
  execute_on = 'final'
  exodus = true
  csv = true
[]