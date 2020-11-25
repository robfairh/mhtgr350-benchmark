[GlobalParams]
  displacements = 'disp_x disp_y'
  temperature = temp
[]

[Mesh]
  type = GeneratedMesh
  dim = 2
  xmax = 2.
  ymax = 2.
  nx = 25
  ny = 25
  elem_type = QUAD9
[]

[AuxVariables]
  [./temp]
    initial_condition = 5
  [../]
[]

[Modules/TensorMechanics/Master]
  [./block1]
    strain = FINITE
    add_variables = true
    generate_output = 'stress_xx stress_yy strain_xx strain_yy'
    eigenstrain_names = thermalstrain
  [../]
[]

[Kernels]
  [./gravity_y]
    type = Gravity
    variable = disp_y
    value = -9.81
  [../]
[]

[BCs]
  [./anchor_x]
    type = PresetBC
    variable = disp_x
    boundary = 'bottom'
    value = 0.0
  [../]
  [./anchor_y]
    type = PresetBC
    variable = disp_y
    boundary = 'bottom'
    value = 0.0
  [../]
[]

[Materials]
  [./elasticity_tensor]
    type = ComputeIsotropicElasticityTensor
    youngs_modulus = 10e9
    poissons_ratio = 0.14
  [../]
  [./stress]
    #assumes finite strains and rotations increments
    type = ComputeFiniteStrainElasticStress
  [../]
  [./concrete]
    type = GenericConstantMaterial
    prop_names = 'density thermal_conductivity'
    prop_values = '1700 3.6e-6'
  [../]
  [./thermal_expansion_strain]
    type = ComputeThermalExpansionEigenstrain
    stress_free_temperature = 0
    thermal_expansion_coeff = 3.6e-6
    temperature = temp
    eigenstrain_name = thermalstrain
  [../]
[]

[Preconditioning]
  [./SMP]
    type = SMP
    full = true
  [../]
[]

[Executioner]
  type = Steady
  solve_type = NEWTON

  l_tol = 1e-4
  l_max_its = 30

  nl_rel_tol = 1e-9
  nl_max_its = 15

  petsc_options_iname = '-pc_type -pc_hypre_type -ksp_gmres_restart'
  petsc_options_value = 'hypre boomeramg 31'
[]

[Outputs]
  file_base = 'ms04'
  execute_on = 'final'
  exodus = true
[]
