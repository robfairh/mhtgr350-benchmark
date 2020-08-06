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
    order = CONSTANT
    family = MONOMIAL
    initial_condition = 930
    fv = true
  [../]
[]

[Kernels]
  [./time_derivative]
    type = MatINSTemperatureTimeDerivative
    variable = temp
  [../]
[]

[DGKernels]
  [./temp_adv]
    type = DGTemperatureAdvection
    variable = temp
    velocity = '0 ${velocity} 0'
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
    prop_names = 'cp rho'
    prop_values = '2e3 1e-2'
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

  nl_rel_tol = 1e-7
  nl_abs_tol = 1e-7
  solve_type = 'NEWTON'

  petsc_options = '-snes_converged_reason -ksp_converged_reason -snes_linesearch_monitor'
  petsc_options_iname = '-pc_type -sub_pc_type -pc_asm_overlap -sub_ksp_type -snes_linesearch_minlambda'
  petsc_options_value = 'asm      lu           1               preonly       1e-3'

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
  [./axial]
    type = LineValueSampler
    variable = 'temp'
    start_point = '1 0 0'
    end_point = '1 100 0'
    sort_by = y
    num_points = 200
    execute_on = 'initial final'
  [../]
[]

[Outputs]
  file_base = 'dg-advec1-t'
  execute_on = 'timestep_end'
  exodus = true
  # csv = true
[]