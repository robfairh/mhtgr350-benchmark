Input files:
------------

* ns00.i:
	- Generated mesh 2D: cooling channel

xmax=10, ny=10, nx=20, v=flat
- Converged
xmax=100, ny=10, nx=200, v=flat
- Converged
xmax=1000, ny=10, nx=2000, v=flat, memory=1.643000e+03
- Converged
- There is something weird close to the entry.
- The centerline velocity rises, goes down, and goes up again

xmax=1000, ny=10, nx=2000, v=quadratic, memory=1.623000e+03
- Converged really fast
- looks good




Need reviewing:

* ns02.i
	- mesh 3D: cooling channel

zmax=10, nz=20, v=quadratic, memory=3008
- Converged
zmax=100, nz=200, v=quadratic, memory=12546
- Converged
zmax=500, nz=1000, v=quadratic, memory=47884
- Converged
zmax=800, nz=1000, v=quadratic, memory=47889
- Converged

integrate_p_by_parts = true

zmax=800, nz=1000, v=quadratic, memory=47423