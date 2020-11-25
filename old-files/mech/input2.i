[GlobalParams]
  displacements = 'disp_x disp_y'
  order = FIRST
  family = LAGRANGE
  temperature = temp
[]

[Mesh]
  file = case4.msh
[../]

[AuxVariables]
  [./temp]
    initial_condition = 30
  [../]
[]

[Modules/TensorMechanics/Master]
  [./all]
    strain = FINITE
    add_variables = true
    # generate_output = 'stress_xx stress_xy stress_yy stress_zz strain_xx strain_xy strain_yy strain_zz'
    generate_output = 'stress_xx stress_yy stress_zz strain_zz'
    eigenstrain_names = thermalstrain
  [../]
[]

[BCs]
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
  type = Steady

  solve_type = NEWTON
  petsc_options_iname = '-pc_type -pc_hypre_type -ksp_gmres_restart'
  petsc_options_value = 'hypre boomeramg 31'

  l_max_its = 100
  l_rel_tol = 1e-4

  # nl_rel_tol = 1e-10
  # nl_abs_tol = 1e-5
  nl_max_its = 30
[]

[Preconditioning]
  [./SMP]
    type = SMP
    full = true
  [../]
[]

[Debug]
  show_var_residual_norms = true
[]

[Outputs]
  perf_graph = true
  file_base = 'input2'
  execute_on = 'final'
  exodus = true
[]