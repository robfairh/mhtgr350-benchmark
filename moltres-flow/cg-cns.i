velocity = 0.5

[Mesh]
  type = GeneratedMesh
  dim = 1
  nx = 100
  xmax = 1
  elem_type = EDGE2
[../]

[Modules]
  [CompressibleNavierStokes]
    initial_pressure = 7
    initial_temperature = 490
    initial_velocity = '1 0 0'
    fluid_properties = helium
  []
  [./FluidProperties]
    [./helium]
      type = IdealGasFluidProperties
      gamma = 1.667
      molar_mass = 4.002602
      # mu = 35.03e-6
    [../]
  []
[]

[Materials]
  [./coolant]
    type = GenericConstantMaterial
    prop_names = 'dynamic_viscosity'
    prop_values = '35.03e-6'
  [../]
[]

[Executioner]
  type = Transient
  end_time = 10
  scheme = crank-nicolson
  [./TimeStepper]
    type = ConstantDT
    dt = 1
  [../]

  nl_rel_tol = 1e-6
  nl_abs_tol = 1e-5
  solve_type = 'NEWTON'

  # petsc_options = '-snes_converged_reason -ksp_converged_reason -snes_linesearch_monitor'
  # petsc_options_iname = '-pc_type -sub_pc_type -pc_asm_overlap -sub_ksp_type -snes_linesearch_minlambda'
  # petsc_options_value = 'asm      lu           1               preonly       1e-3'
  # nl_max_its = 30
  # l_max_its = 100
[]

[Preconditioning]
  [./SMP]
    type = SMP
    full = true
  [../]
[]

[Outputs]
  exodus = true
[]
