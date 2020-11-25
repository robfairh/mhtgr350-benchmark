# Case 1
# Tcool = 1001.3
# q = 25.2446
# Case 4
Tcool = 755
q = 51.5455

[Mesh]
  # Case 1
  # file = case1.msh
  # Case 4
  file = case4.msh
[../]

[Variables]
  [./temp]
    order = FIRST
    family = LAGRANGE
    initial_condition = 480
  [../]
[]

[Kernels]
  [./diffusion]
    type = MatDiffusion
    diffusivity = 'k'
    variable = temp
    block = 'fuel gap moderator'
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
    value = ${q}
  [../]
[]

[BCs]
  [./convective_channels]
    type = CoupledConvectiveHeatFluxBC
    boundary = 'coolant'
    variable = temp
    htc = 0.25 # [W/cm2/K] from Lejeail, Y. Cabrillat, M. 2005
    T_infinity = ${Tcool}
  [../]
  [./convective_bypass]
    type = CoupledConvectiveHeatFluxBC
    boundary = 'bypass'
    variable = temp
    htc = 0.001 # [W/cm2/K] from Lejeail, Y. Cabrillat, M. 2005
    T_infinity = ${Tcool}
  [../]
[]

[Materials]
  [./fuel]
    type = PiecewiseLinearInterpolationMaterial
    property = 'k'
    variable = temp
    x = '200 1800' # [C]
    y = '0.1 0.1' # [W/cm/K]
    block = 'fuel'
  [../]
  [./gap] # same values as the moderator
    type = PiecewiseLinearInterpolationMaterial
    property = 'k'
    variable = temp
    # x = '    327   593.7   860.3    1127' # [C]
    # y = '0.00256 0.00330 0.00397 0.00460' # [W/cm/K]
    x = '200    400    600    800    1000   1200' # [C]
    y = '1.3232 1.0733 0.8822 0.7499 0.6764 0.6617' # [W/cm/K]
    block = 'gap'
  [../]
  [./moderator]
    type = PiecewiseLinearInterpolationMaterial
    property = 'k'
    variable = temp
    x = '200    400    600    800    1000   1200' # [C]
    y = '1.3232 1.0733 0.8822 0.7499 0.6764 0.6617' # [W/cm/K]
    block = 'moderator'
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

# [VectorPostprocessors]
#   [./fuel]
#     type = LineValueSampler
#     variable = 'temp'
#     start_point = '1.876 3.25 0'
#     end_point = '1.876 3.25 793'
#     sort_by = z
#     num_points = 200
#     execute_on = final
#   [../]
# []

[Outputs]
  perf_graph = true
  file_base = 'input'
  execute_on = 'final'
  exodus = true
  # csv = true
[]