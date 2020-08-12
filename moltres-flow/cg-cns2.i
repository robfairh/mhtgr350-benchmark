velocity = 0.5

[Mesh]
  type = GeneratedMesh
  dim = 1
  nx = 100
  xmax = 1
  elem_type = EDGE2
[]

[Variables]
  [density]
    order = FIRST
    family = LAGRANGE
  []
  [momentum_x]
    order = FIRST
    family = LAGRANGE
  []
  [total_energy]
    order = FIRST
    family = LAGRANGE
  []
[]

[AuxVariables]
  [velocity_x]
    order = FIRST
    family = LAGRANGE
  []
  [pressure]
    order = FIRST
    family = LAGRANGE
  []
  [temperature]
    order = FIRST
    family = LAGRANGE
  []
  [enthalpy]
    order = FIRST
    family = LAGRANGE
  []
  [mach_number]
    order = FIRST
    family = LAGRANGE
  []
  [internal_energy]
    order = FIRST
    family = LAGRANGE
  []
  [specific_volume]
    order = FIRST
    family = LAGRANGE
  []
[]

[Kernels]
  # Time derivative
  [density_time_deriv]
    type = TimeDerivative
    variable = density
  []
  [momentum_x_time_deriv]
    type = TimeDerivative
    variable = momentum_x
  []
  [total_energy_time_deriv]
    type = TimeDerivative
    variable = total_energy
  []

  # Mass Inviscid flux
  [rho_if]
    type = NSMassInviscidFlux
    variable = density
  []


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
