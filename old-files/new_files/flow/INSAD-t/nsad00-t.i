[GlobalParams]
  integrate_p_by_parts = false
  order = FIRST
[]

[Mesh]
  type = GeneratedMesh
  dim = 2
  xmax = 1000.
  ymax = 1.
  nx = 2000
  ny = 20
  elem_type = QUAD9
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
[]

[ICs]
  [velocity]
    type = VectorConstantIC
    x_value = 1e-15
    y_value = 1e-15
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
  [inlet]
    type = VectorFunctionDirichletBC
    variable = velocity
    boundary = 'left'
    function_x = 'inlet_func'
    function_y = 0
    function_z = 0
  [../]
  # [wall]
  #   type = VectorFunctionDirichletBC
  #   variable = velocity
  #   boundary = 'top bottom'
  #   function_x = 0
  #   function_y = 0
  # []

  # [no_slip]
  #   type = ADVectorFunctionDirichletBC
  #   variable = velocity
  #  boundary = 'right'
  #   set_x_comp = false
  #   function_y = 0
  # []

  #[outlet]
  #  type = INSADMomentumNoBCBC
  #  variable = velocity
  #  p = p
  # boundary = 'right'
  # []

  [./no_slip_BC]
    type = VectorDirichletBC
    boundary = 'top bottom'
    variable = velocity
    values = '0 0 0'
  [../]

  [pressure_pin]
    type = DirichletBC
    variable = p
    boundary = 'right'
    value = 0
  [../]
[]

[Functions]
  [./inlet_func]
    type = ParsedFunction
    # value = '-(y^2 - y)'
    # value = '1'
    value = '2865'
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
  petsc_options_iname = '-pc_type -sub_pc_type -pc_factor_shift_type'
  petsc_options_value = 'lu       lu           NONZERO'
  line_search = 'none'

  # petsc_options_iname = '-pc_type -sub_ksp_type -snes_linesearch_minlambda'
  # petsc_options_value = 'lu       preonly       1e-3'

  nl_rel_tol = 1e-6
  l_max_its = 100

  nl_abs_tol = 1e-6
  nl_max_its = 10

  dtmin = 1e-5
  dtmax = 0.08

  [./TimeStepper]
    type = IterationAdaptiveDT
    dt = 0.01
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
    boundary = 'left'
    execute_on = 'timestep_end'
  [../]
  [./flow_out]
    type = VolumetricFlowRate
    vel_x = vel_x
    vel_y = vel_y
    boundary = 'right'
    execute_on = 'timestep_end'
  [../]
  [./memory]
    type = MemoryUsage
    execute_on = linear
  [../]
[]

[Outputs]
  perf_graph = true
  file_base = 'nsad00-t'
  # execute_on = 'final'
  exodus = true
[]