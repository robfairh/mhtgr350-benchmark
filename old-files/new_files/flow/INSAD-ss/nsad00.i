# it has a small component in the y-direction
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
    value = '2865' # cm/s
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

  # petsc_options_iname = '-pc_type -sub_pc_type -pc_factor_shift_type'
  # petsc_options_value = 'lu       lu           NONZERO'
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
  file_base = 'nsad00'
  execute_on = 'final'
  exodus = true
[]
