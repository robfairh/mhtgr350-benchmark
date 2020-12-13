
[GlobalParams]
  integrate_p_by_parts = false
  order = FIRST
[]

[Mesh]
  type = GeneratedMesh
  dim = 3
  xmax = 1.
  ymax = 1.
  zmax = 1000.
  nx = 10
  ny = 10
  nz = 1000
  elem_type = HEX27
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
    # scaling = 1e-2
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
  [wall]
    type = ADVectorFunctionDirichletBC
    variable = velocity
    boundary = 'left right top bottom'
    function_x = 0
    function_y = 0
    function_z = 0
  []
  [inlet]
    type = ADVectorFunctionDirichletBC
    variable = velocity
    boundary = 'front'
    function_x = 0
    function_y = 0
    function_z = 'inlet_func'
  [../]
  [pressure_pin]
    type = DirichletBC
    variable = p
    boundary = 'back'
    value = 0
  [../]
[]

[Functions]
  [./inlet_func]
    type = ParsedFunction
    # value = '-1'
    value = '-(y^2-y)*(x^2-x)*36'
    # value = '-2865' # cm/s
    # value = '-(y^2-y)*(x^2-x)*36*2865'
  [../]
[]

[Materials]
  [./const]
    type = ADGenericConstantMaterial
    prop_names = 'rho mu'
    prop_values = '1  1'
    # prop_values = '4.3679e-6 3.8236e-7'
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

  petsc_options_iname = '-pc_type -sub_ksp_type -snes_linesearch_minlambda'
  petsc_options_value = 'lu       preonly       1e-3'

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
    boundary = 'front'
    execute_on = 'timestep_end'
  [../]
  [./flow_out]
    type = VolumetricFlowRate
    vel_x = vel_x
    vel_y = vel_y
    vel_z = vel_z
    boundary = 'back'
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
  file_base = 'nsad01'
  execute_on = 'final'
  exodus = true
[]