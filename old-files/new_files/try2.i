# This file is a simple input file with the purpose of debugging the Integrated BC

[Variables]
  [./temp]
    order = FIRST
    family = LAGRANGE
  [../]
[]

[Mesh]
  [mymesh]
    type = FileMeshGenerator
    file = '1D-fuel-reflec.msh'
  [../]

  [./add_side_sets]
    type = SideSetsFromPointsGenerator
    input = mymesh
    points = '0    0  0
              0  1073  0'
    new_boundary = 'ref_bot ref_top'
  [../]
[../]


[Kernels]
  [./diff]
    type = Diffusion
    variable = temp
  [../]
  [./source]
    type = BodyForce
    variable = temp
    value = 1.0
  [../]
[]

[BCs]
  [./left]
    type = DirichletBC
    variable = temp
    boundary = 'ref_bot'
    value = 0
  [../]
  [./right]
    type = NeumannBC
    variable = temp
    boundary = 'ref_top'
    value = 0
  [../]
[]

[VectorPostprocessors]
  [./tocsv]
    type = LineValueSampler
    variable = temp
    start_point = '0 0 0'
    end_point = '0 1073 0'
    sort_by = y
    num_points = 250
    execute_on = timestep_end
  [../]
[]

[Executioner]
  type = Steady
  solve_type = 'PJFNK'
[]

[Outputs]
  perf_graph = true
  print_linear_residuals = true
  file_base = 'try2'
  exodus = true
  csv = true
  execute_on = timestep_end
[]