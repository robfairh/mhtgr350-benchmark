Input files:
------------

* nsad00-t.i
	- generated mesh 2D: one channel
	- uses pspg, supg, first order

rho=mu=vel=1
xmax=5, nx=40, ny=20, in=-1.0, out=.9829, memory=7.940000e+02, time=1.559
xmax=100, nx=200, ny=20, in=-1.0, out=0.8581, memory=8.840000e+02, time=9.006
xmax=1000, nx=2000, ny=20, in=-1.0, out=0.8581, memory=1.740000+03, time=102.669

Comments:
- the velocity increases slightly at the outlet

rho=4.3679e-6, mu=3.8236e-7, vel=2865
xmax=10, nx=100, ny=20, in=-2865, out=2865, memory=8.110000e+02, time=2.665
xmax=1000, nx=2000, ny=20, in=-2865, out=2865, memory=1.738000+03, time=108.556

Comments:
- Same results as nsad00.i
- There are oscillations at the entry on the channel

* nsad01-t.i
	- generated mesh 3D: one channel
	- uses pspg, supg, first order

rho=mu=vel=1
zmax=100, nx=ny=10, nz=200, in=-1.0, out=.9829, memory=7.940000e+02, time=1.559
zmax=400, nx=ny=10, nz=800, it works, I don't have these values

rho=4.3679e-6, mu=3.8236e-7, vel=2865
zmax=100, nx=ny=10, nz=200, in=2.865000e+03, out=2.863213e+03, memory=2.978000e+03





Needs review

* nsad02-t.i
	- mesh 3D: cooling channel
	- uses pspg, supg, first order

rho=mu=vel=1
H=100, nz=200, MinimumCirclePoints=25, CharacteristicLengthFactor=0.4, in=0.9706, out=0.8562
H=1000, nz=2000, MinimumCirclePoints=25, CharacteristicLengthFactor=0.4, in=0.9706, out=0.8562

rho=4.3679e-6, mu=3.8236e-7, vel=2865
H=100, nz=200, MinimumCirclePoints=25, CharacteristicLengthFactor=0.4, in=2780.67, out=2779.86, memory=1.86e3
H=1000, nz=2000, MinimumCirclePoints=25, CharacteristicLengthFactor=0.4, in=2780.67, out=2779.88, memory=8.657e3
