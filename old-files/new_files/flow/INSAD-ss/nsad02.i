
[GlobalParams]
  integrate_p_by_parts = false
  order = FIRST
[]

[Mesh]
  file = test2.msh
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
  [inlet]
    type = ADVectorFunctionDirichletBC
    variable = velocity
    boundary = 'top'
    function_x = 0
    function_y = 0
    function_z = 'inlet_func'
  [../]
  [wall]
    type = ADVectorFunctionDirichletBC
    variable = velocity
    boundary = 'wall'
    function_x = 0
    function_y = 0
    function_z = 0
  []
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
    # value = '-(1-(x^2+y^2))*2/pi'
    value = '-(1-(x^2+y^2))*2/pi*2865' # cm/s
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
    solve_type = Newton
  [../]
[]

[Executioner]
  type = Steady

  petsc_options = '-snes_converged_reason -ksp_converged_reason -snes_linesearch_monitor'

  # petsc_options_iname = '-pc_type -sub_pc_type -sub_pc_factor_levels'
  # petsc_options_value = 'bjacobi  ilu          4'

  petsc_options_iname = '-pc_type -sub_ksp_type -snes_linesearch_minlambda'
  petsc_options_value = 'lu       preonly       1e-3'

  # petsc_options_iname = '-pc_type -pc_factor_shift_type'
  # petsc_options_value = 'lu       NONZERO'
  # line_search = 'none'

  # l_rel_tol = 1e-12
  l_max_its = 5000

  nl_rel_tol = 1e-11
  nl_max_its = 20
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

[Debug]
  show_var_residual_norms = true
[]

[Outputs]
  file_base = 'nsad02'
  execute_on = 'final'
  exodus = true
[]