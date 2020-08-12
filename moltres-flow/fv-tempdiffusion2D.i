[Mesh]
  type = GeneratedMesh
  dim = 2
  nx = 50
  ny = 10
  xmax = 2
  ymax = 2
  elem_type = QUAD4
[../]

[Problem]
  kernel_coverage_check = off
[]

[Variables]
  [./temp]
    family = MONOMIAL
    order = CONSTANT
    initial_condition = 930
    fv = true
  [../]
[]

[FVKernels]
  [./time]
    type = MatFVTimeKernel
    variable = temp
    rho = 1e-2
    cp = 2e3
  [../]
  [diff]
    type = FVDiffusion
    variable = temp
    coeff = coeff
  []
  [force]
    type = FVBodyForce
    variable = temp
    function = 'heat_source'
  []
[]

[Materials]
  [diff]
    type = ADGenericConstantMaterial
    prop_names = 'coeff'
    prop_values = '1'
  []
[]

[Functions]
  [./heat_source]
    type = ParsedFunction
    value = '10 * sin(pi/2 * x)'
  [../]
[]

[FVBCs]
  [left]
    type = FVDirichletBC
    variable = temp
    boundary = 'left right'
    value = 930
  []
[]

[Executioner]
  type = Transient
  petsc_options_iname = '-pc_type'
  petsc_options_value = 'lu'
  petsc_options = '-snes_converged_reason'
  nl_abs_tol = 1e-7
  nl_rel_tol = 1e-8
  num_steps = 100
  dt = 1
[]

[Outputs]
  # file_base = 'fv_tempadvectio2D'
  exodus = true
[]
