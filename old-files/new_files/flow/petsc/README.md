This study compares the memory requirements by the most promissing petsc methods.

zmax=10, nz=200

petsc_options_iname = '-pc_type -sub_ksp_type -snes_linesearch_minlambda'
petsc_options_value = 'lu       preonly       1e-3'

bw n=1 ppn=1
bw n=1 ppn=4
bw n=1 ppn=32
bw n=2 ppn=32

It seems like the memory requirement increases a lot increasing the CPUs.
It also seems that the residuals change with the different number of nodes.

roberto-nompi vs n1ppn1: the resiudals are slightly different

It seems that the method is parallel, but according to PetSc website, it is not ...

lu-preonly-vw-n1ppn32 uses memory: 5.673000e+03



petsc_options_iname = '-pc_type -sub_pc_type -sub_pc_factor_shift_type'
petsc_options_value = 'asm      lu           NONZERO'

the more nodes I use the more iterations take the linear solver to converge ...
also, the number of nodes increases the memory requirements ...

asm-lu-bw-n1ppn32 ues memory: 4.889000e+03

Now we compare the memory requirments using only 32 nodes on BW:

A)
bjacobi-ilu-1:
petsc_options_iname = '-pc_type -sub_pc_type -sub_pc_factor_levels -ksp_gmres_restart'
petsc_options_value = 'bjacobi  ilu          4                     300'

bjacobi-ilu-2:
petsc_options_iname = '-pc_type -sub_pc_type -sub_pc_factor_levels -ksp_gmres_restart'
petsc_options_value = 'bjacobi  ilu          6                     300'

bjacobi-ilu-3:
petsc_options_iname = '-pc_type -sub_pc_type -sub_pc_factor_levels -ksp_gmres_restart'
petsc_options_value = 'bjacobi  ilu          4                     200'

bjacobi-lu:
petsc_options_iname = '-pc_type -sub_pc_type -sub_pc_factor_levels -ksp_gmres_restart'
petsc_options_value = 'bjacobi  lu           4                     300'

* higher -sub_pc_factor_levels uses more memory
* higher -ksp_gmres_restart uses more memory
* using -sub_pc_type: lu increases the memory slightly
* bjacobi-ilu-3 uses less memory: 4.324000e+03

B)
petsc_options_iname = '-pc_type -sub_pc_type -pc_factor_shift_type'
petsc_options_value = 'lu       lu           NONZERO'
line_search = 'none'

* memory: 5.663000e+03

C)
asm-1:
petsc_options_iname = '-pc_type -sub_pc_factor_levels -ksp_gmres_restart'
petsc_options_value = 'asm      6                     200'
line_search = 'none'

asm-2:
petsc_options_iname = '-pc_type -sub_pc_factor_levels -ksp_gmres_restart'
petsc_options_value = 'asm      4                     200'
line_search = 'none'

asm-3:
petsc_options_iname = '-pc_type -sub_pc_factor_levels -ksp_gmres_restart'
petsc_options_value = 'asm      6                     300'
line_search = 'none'

* higher -sub_pc_factor_levels uses more memory and barely reduces the number of linear iterations.
* higher -ksp_gmres_restart uses more memory.
* asm-2 uses less memory: 5.004000e+03

D)
asm-ilu-1:
petsc_options_iname = '-pc_type -pc_asm_overlap -sub_pc_type -sub_pc_factor_levels'
petsc_options_value = 'asm      2               ilu          4'

asm-ilu-2:
petsc_options_iname = '-pc_type -pc_asm_overlap -sub_pc_type -sub_pc_factor_levels'
petsc_options_value = 'asm      3               ilu          4'

asm-ilu-3:
petsc_options_iname = '-pc_type -pc_asm_overlap -sub_pc_type -sub_pc_factor_levels'
petsc_options_value = 'asm      2               ilu          6'

asm-lu:
petsc_options_iname = '-pc_type -pc_asm_overlap -sub_pc_type -sub_pc_factor_levels'
petsc_options_value = 'asm      2               lu           4'

* higher -pc_asm_overlap uses more memory and reduces the number of linear iterations.
* higher -sub_pc_factor_levels uses more memory and reduces the number of linear iterations.
* using -sub_pc_type:lu uses more memory and reduces the number of linear iterations.
* asm-ilu-1 uses the less memory: 5.438000e+03
