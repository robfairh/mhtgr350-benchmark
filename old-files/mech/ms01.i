[GlobalParams]
  displacements = 'disp_x disp_y'
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

[Variables]
  [./disp_x]
    order = SECOND
    family = LAGRANGE
  [../]
  [./disp_y]
    order = SECOND
    family = LAGRANGE
  [../]
[]

[Kernels]
  [./gravity_y]
    #Gravity is applied to bridge
    type = Gravity
    variable = disp_y
    value = -9.81
  [../]
  [./TensorMechanics]
    #Stress divergence kernels
    displacements = 'disp_x disp_y'
  [../]
[]

[AuxVariables]
  [./von_mises]
    #Dependent variable used to visualize the Von Mises stress
    order = CONSTANT
    family = MONOMIAL
  [../]

  [./s11_aux]
    order = CONSTANT
    family = MONOMIAL
  [../]

  [./s12_aux]
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

  [./matl_s12]
    type = RankTwoAux
    rank_two_tensor = stress
    index_i = 0
    index_j = 1
    variable = s12_aux
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
  #[./Pressure]
  #  [./load]
  #    #Applies the pressure
  #    boundary = top
  #    factor = 0 # Pa
  #    disp_x = disp_x
  #    disp_y = disp_y
  #  [../]
  #[../]
  [./anchor_x]
   #Anchors the bottom and sides against deformation in the x-direction
   type = PresetBC
   variable = disp_x
   boundary = 'bottom'
   value = 0.0
  [../]
  [./anchor_y]
    #Anchors the bottom and sides against deformation in the y-direction
    type = PresetBC
    variable = disp_y
    boundary = 'bottom'
    value = 0.0
  [../]
[]

[Materials]
  [./elasticity_tensor_concrete]
    #Creates the elasticity tensor using concrete parameters
    youngs_modulus = 10e9 #Pa
    poissons_ratio = 0.14
    type = ComputeIsotropicElasticityTensor
  [../]
  [./strain]
    #Computes the strain, assuming small strains
    type = ComputeSmallStrain
    displacements = 'disp_x disp_y'
    eigenstrain_names = thermalstrain
  [../]
  [./stress]
    #Computes the stress, using linear elasticity
    type = ComputeLinearElasticStress
  [../]
  [./concrete]
    #Defines the density of concrete
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
    #Creates the entire Jacobian, for the Newton solve
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
  file_base = 'ms03'
  execute_on = 'final'
  exodus = true
[]
