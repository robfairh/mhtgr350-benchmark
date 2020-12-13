[GlobalParams]
  integrate_p_by_parts = false
  order = FIRST
[]

[Mesh]
  file = test2-C.msh
[]

[Variables]
  [./velocity]
    family = LAGRANGE_VEC
    order = FIRST
  [../]
  [./p]
    family = LAGRANGE
    order = FIRST
    scaling = 1e-2
  [../]
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

[ICs]
  [velocity]
    type = VectorConstantIC
    x_value = 1e-15
    y_value = 1e-15
    z_value = 1e-15
    variable = velocity
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

  [./momentum_time]
    type = INSADMomentumTimeDerivative
    variable = velocity
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
  [wall]
    type = ADVectorFunctionDirichletBC
    variable = velocity
    boundary = 'wall'
    function_x = 0
    function_y = 0
    function_z = 0
  []
  [inlet]
    type = ADVectorFunctionDirichletBC
    variable = velocity
    boundary = 'top'
    function_x = 0
    function_y = 0
    function_z = 'inlet_func'
  [../]
  [pressure_pin]
    type = DirichletBC
    variable = p
    boundary = 'bottom'
    value = 0
  [../]
[]

[Functions]
  [./inlet_func]
    type = ParsedFunction
    # value = '((x^2+y^2)-1)*2/pi'
    value = '((x^2+y^2)-1)*2/pi*2865'
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
  [../]
[]

[Executioner]
  type = Transient
  start_time = 0
  end_time = 1

  # [./TimeIntegrator] framework/src/timeintegrators
  #   type = ExplicitEuler
  # [../]

  solve_type = 'NEWTON'
  petsc_options = '-snes_converged_reason -ksp_converged_reason -snes_linesearch_monitor'

  # from Alvin's TAP_Unit_INS_Stripped_INSAD_Vel.i
  # petsc_options_iname = '-pc_type -sub_pc_type -pc_factor_shift_type'
  # petsc_options_value = 'lu       lu           NONZERO'
  # line_search = 'none'

  petsc_options_iname = '-pc_type -sub_ksp_type -snes_linesearch_minlambda'
  petsc_options_value = 'lu       preonly       1e-3'

  nl_rel_tol = 1e-6
  l_max_its = 100

  nl_abs_tol = 1e-6
  nl_max_its = 10

  dtmin = 1e-6
  dtmax = 0.1

  [./TimeStepper]
    type = IterationAdaptiveDT
    dt = 1e-5
    cutback_factor = 0.8
    growth_factor = 1.2
    optimal_iterations = 5
    iteration_window = 1
    linear_iteration_ratio = 100
  [../]
[]

[Postprocessors]
  [./flow_in]
    type = VolumetricFlowRate
    vel_x = vel_x
    vel_y = vel_y
    vel_z = vel_z
    boundary = 'top'
    execute_on = 'timestep_end'
  [../]
  [./flow_out]
    type = VolumetricFlowRate
    vel_x = vel_x
    vel_y = vel_y
    vel_z = vel_z
    boundary = 'bottom'
    execute_on = 'timestep_end'
  [../]
  [./memory]
    type = MemoryUsage
    execute_on = linear
  [../]
[]

[Outputs]
  perf_graph = true
  file_base = 'nsad02-tF'
  # execute_on = 'final'
  exodus = true
  # solution_history = true
  csv = true
[]