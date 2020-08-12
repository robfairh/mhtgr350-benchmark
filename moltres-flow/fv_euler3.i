[Mesh]
  [gen]
    type = GeneratedMeshGenerator
    dim = 1
    nx = 20
  []
[]

[Problem]
  kernel_coverage_check = false
[]

[Variables]
  # we have to impose non-zero initial conditions in order to avoid an initially
  # singular matrix
  [fv_rho]
    order = CONSTANT
    family = MONOMIAL
    fv = true
    initial_condition = 2
  []
  [fv_vel]
    order = CONSTANT
    family = MONOMIAL
    fv = true
    initial_condition = 2
  []
  [fv_e]
    order = CONSTANT
    family = MONOMIAL
    fv = true
    initial_condition = 1
  []
[]

[FVKernels]
  # del * rho * velocity
  [adv_rho]
    type = FVMatAdvection
    variable = fv_rho
    vel = 'fv_velocity'
  []

  # del * rho * velocity * velocity + del * p
  [adv_rho_u]
    type = FVMomentum
    # type = FVMatAdvection
    variable = fv_vel

    vel = 'fv_velocity'
    advected_quantity = 'rho_u'
    p = 'pres'
  []

  # del * velocity * energy
  [adv_e]
    type = FVEnergy
    # type = FVMatAdvection
    variable = fv_e
    vel = 'fv_velocity'
    p = 'pres'
  []
[]

[Materials]
  [euler_material]
    # type = ADCoupledVelocityMaterial
    type = ADMomentumMaterial
    vel_x = fv_vel
    rho = fv_rho
    energy = fv_e

    velocity = 'fv_velocity'
    pres = 'pres'
  []
[]

[FVBCs]
  [left_rho]
    type = FVDirichletBC
    variable = fv_rho
    value = 1
    boundary = 'left'
  []
  [left_vel]
    type = FVDirichletBC
    variable = fv_vel
    value = 1
    boundary = 'left'
  []
  [left_e]
    type = FVDirichletBC
    variable = fv_e
    value = 1
    boundary = 'left'
  []

  # del * rho * velocity
  [adv_rho]
    type = FVMatAdvectionOutflowBC
    variable = fv_rho
    vel = 'fv_velocity'
    boundary = 'right'
  []
  # del * rho * velocity * velocity
  [right_vel]
    # type = FVMatAdvectionOutflowBC
    type = FVMomentumOutflowBC
    variable = fv_vel
    vel = 'fv_velocity'
    advected_quantity = 'rho_u'
    p = 'pres'
    boundary = 'right'
  []
  # del * velocity * energy
  [right_e]
    # type = FVMatAdvectionOutflowBC
    type = FVEnergyOutflowBC
    variable = fv_e
    vel = 'fv_velocity'
    p = 'pres'
    boundary = 'right'
  []
[]

[Executioner]
  type = Steady
  solve_type = NEWTON
  line_search = 'none'

  # nl_rel_tol = 1e-4
  # nl_abs_tol = 1e-4
  #
  # nl_max_its = 30
  # l_max_its = 100
[]

[Outputs]
  [out]
    type = Exodus
    execute_on = 'final'
  []
[]
