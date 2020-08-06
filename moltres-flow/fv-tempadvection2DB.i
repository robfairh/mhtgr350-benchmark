[Mesh]
  # type = GeneratedMesh
  # dim = 2
  # nx = 1
  # ny = 100
  # xmax = 2
  # ymax = 100
  # elem_type = QUAD4
  file = 2D-3mat.msh
[../]

[Problem]
  kernel_coverage_check = off
[]

[Variables]
  [./temp]
    family = LAGRANGE
    order = FIRST
    initial_condition = 930
    block = 'fuel moderator'
  [../]
  [./v]
    family = MONOMIAL
    order = CONSTANT
    initial_condition = 930
    fv = true
    block = 'coolant'
  [../]
[]

[Kernels]
  [./temp_time_derivative]
    type = MatINSTemperatureTimeDerivative
    variable = v
    block = 'fuel moderator'
  [../]
  [./diffusion]
    type = MatDiffusion
    diffusivity = 'k'
    variable = v
    block = 'fuel moderator'
  [../]
  [./source]
    type = BodyForce
    variable = v
    function = heat_source
    block = 'fuel'
  [../]
[]

[FVKernels]
  [./time]
    type = MatFVTimeKernel
    variable = v
    rho = 1e-2
    cp = 2e3
    block = 'coolant'
  [../]
  [./advection]
    type = MatFVAdvection
    variable = v
    velocity = '0 0.5 0'
    rho = 1e-2
    cp = 2e3
    block = 'coolant'
  [../]
  #[force]
  # type = FVBodyForce
  # variable = v
  # function = 'heat_source'
  #[]
[]

[FVBCs]
  [./fv_outflow]
    type = MatFVConstantScalarOutflowBC
    velocity = '0 0.5 0'
    variable = v
    boundary = top
    rho = 1e-2
    cp = 2e3
  [../]
  [left]
    type = FVDirichletBC
    variable = v
    boundary = bottom
    value = 930
  []
[]

# [BCs]
#   [./heat_wall]
#     boundary = right
#     type = FunctionNeumannBC
#     variable = v
#     function = 'heat_source'
#   [../]
# []

[Functions]
  [./heat_source]
    type = ParsedFunction
    # value = '10 * sin( pi/100 * y)'
    value = '35' # W/cm3
  [../]
[]

[Materials]
  [./solids]
    type = GenericConstantMaterial
    prop_names = 'k  cp rho'
    prop_values = '1  1   1' # [J/kg/K] [kg/cm3]
    block = 'fuel moderator'
  [../]
[]

[Executioner]
  type = Transient
  petsc_options_iname = '-pc_type'
  petsc_options_value = 'lu'
  petsc_options = '-snes_converged_reason'
  nl_abs_tol = 1e-7
  nl_rel_tol = 1e-8
  num_steps = 250
  dt = 1
[]

[Outputs]
  exodus = true
[]
