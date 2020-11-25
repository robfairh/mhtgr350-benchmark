[GlobalParams]
  displacements = 'disp_x disp_y disp_z'
[]

[Mesh]
  file = mech2.msh
[../]

[Variables]
  [./disp_x]
    order = SECOND
    family = LAGRANGE
  [../]
  [./disp_y]
    order = SECOND
    family = LAGRANGE
  [../]
  [./disp_z]
    order = SECOND
    family = LAGRANGE
  [../]
[]

[Kernels]
  [./gravity_y]
    type = Gravity
    variable = disp_z
    value = -9.81
  [../]
  [./TensorMechanics]
    # Stress divergence kernels
    displacements = 'disp_x disp_y disp_z'
  [../]
[]

[AuxVariables]
  [./von_mises]
    order = CONSTANT
    family = MONOMIAL
  [../]

  [./s11_aux]
    order = CONSTANT
    family = MONOMIAL
  [../]

  [./s22_aux]
    order = CONSTANT
    family = MONOMIAL
  [../]

  [./s33_aux]
    order = CONSTANT
    family = MONOMIAL
  [../]

  [./temp]
    initial_condition = 5
  [../]
[]

[AuxKernels]
  [./von_mises_kernel]
    #Calculates the von mises stress and assigns it to von_mises
    type = RankTwoScalarAux
    variable = von_mises
    rank_two_tensor = stress
    execute_on = timestep_end
    scalar_type = VonMisesStress
  [../]

  [./matl_s11]
    type = RankTwoAux
    rank_two_tensor = stress
    index_i = 0
    index_j = 0
    variable = s11_aux
  [../]

  [./matl_s22]
    type = RankTwoAux
    rank_two_tensor = stress
    index_i = 1
    index_j = 1
    variable = s22_aux
  [../]

  [./matl_s33]
    type = RankTwoAux
    rank_two_tensor = stress
    index_i = 2
    index_j = 2
    variable = s33_aux
  [../]
[]

[BCs]
  [./left_wall]
   type = DirichletBC
   preset = true
   variable = disp_x
   boundary = 'left'
   value = 0.0
  [../]
  [./anchor_x]
    type = DirichletBC
    preset = true
    variable = disp_x
    boundary = 'center'
    value = 0.0
  [../]
  [./anchor_y]
    type = DirichletBC
    preset = true
    variable = disp_y
    boundary = 'center'
    value = 0.0
  [../]
  [./InclinedNoDisplacementBC]
    [./right]
      boundary = 'right'
      penalty = 1.0
      displacements = 'disp_x disp_y'
    [../]
  [../]
  [./top_wall]
   type = DirichletBC
   preset = true
   variable = disp_z
   boundary = 'top'
   value = 0.0
  [../]
  [./bot_wall]
   type = DirichletBC
   preset = true
   variable = disp_z
   boundary = 'bot'
   value = 0.0
  [../]
[]

[Materials]
  [./elasticity_tensor_concrete]
    type = ComputeIsotropicElasticityTensor
    youngs_modulus = 10e9 #Pa
    poissons_ratio = 0.14
  [../]
  [./strain]
    type = ComputeSmallStrain
    displacements = 'disp_x disp_y disp_z'
    eigenstrain_names = thermalstrain
  [../]
  [./stress]
    type = ComputeLinearElasticStress
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
  nl_max_its = 10

  petsc_options_iname = '-pc_type -pc_hypre_type -ksp_gmres_restart'
  petsc_options_value = 'hypre boomeramg 31'
[]

[Outputs]
  file_base = 'ms04'
  execute_on = 'final'
  exodus = true
[]
