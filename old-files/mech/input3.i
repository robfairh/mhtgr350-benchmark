# Case 1
# Tcool = 1001.3
# q = 25.2446
# Case 4
Tcool = 755
q = 51.5455

[GlobalParams]
  displacements = 'disp_x disp_y'
  order = FIRST
  family = LAGRANGE
  temperature = temp
[]

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
    scaling = 1e10
  [../]
  [./scalar_strain_zz]
    order = FIRST
    family = SCALAR
  [../]
[]

[Modules/TensorMechanics/Master]
  [./all]
    strain = FINITE
    add_variables = true
    # generate_output = 'stress_xx stress_xy stress_yy stress_zz strain_xx strain_xy strain_yy strain_zz'
    generate_output = 'stress_xx stress_yy stress_zz strain_zz'
    planar_formulation = GENERALIZED_PLANE_STRAIN
    scalar_out_of_plane_strain = scalar_strain_zz
    # save_in = 'saved_x saved_y'
    eigenstrain_names = thermalstrain
  [../]
[]

[Kernels]
  # temperature
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
  [./bottomx]
    type = DirichletBC
    preset = true
    boundary = 'center'
    variable = disp_x
    value = 0.0
  [../]
  [./bottomy]
    type = DirichletBC
    preset = true
    boundary = 'center'
    variable = disp_y
    value = 0.0
  [../]  
  [./left]
    type = DirichletBC
    preset = true
    boundary = 'left'
    variable = disp_x
    value = 0.0
  [../]  
  [./InclinedNoDisplacementBC]
    [./right]
      boundary = 'right'
      penalty = 1.0
      displacements = 'disp_x disp_y'
    [../]
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

  [./elastic_tensor]
    type = ComputeIsotropicElasticityTensor
    youngs_modulus = 10.2e9 # Pa
    poissons_ratio = 0.15
  [../]
  [./stress]
    type = ComputeFiniteStrainElasticStress
  [../]
  [./thermal_strain]
    type = ComputeThermalExpansionEigenstrain
    thermal_expansion_coeff = 4.42e-2
    stress_free_temperature = 25
    temperature = temp
    eigenstrain_name = thermalstrain
  [../]
[]

[Executioner]
  type = Transient

  start_time = 0.0
  dtmin = 1e-2
  end_time = 2.0
  num_steps = 1000

  solve_type = 'NEWTON'
  petsc_options = '-snes_converged_reason -ksp_converged_reason -snes_linesearch_monitor'
  petsc_options_iname = '-pc_type -sub_pc_type -pc_factor_shift_type'
  petsc_options_value = 'lu       lu           NONZERO'
  line_search = none

  l_max_its = 100
  l_tol = 1e-4
  nl_rel_tol = 1e-10
  nl_abs_tol = 1e-5
  nl_max_its = 30

  [./TimeStepper]
    type = IterationAdaptiveDT
    dt = 0.1
    cutback_factor = 0.8
    growth_factor = 1.2
    optimal_iterations = 5
    iteration_window = 1
    linear_iteration_ratio = 100
  [../]

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

[Debug]
  show_var_residual_norms = true
[]

[Outputs]
  perf_graph = true
  file_base = 'input2'
  execute_on = 'final'
  exodus = true
  # csv = true
[]