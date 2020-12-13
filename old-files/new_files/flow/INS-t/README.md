Input files:
------------

* ns00-t.i:
	- generated mesh 2D: one cooling channel
	- uses pspg, supg, first order

rho=mu=v=1:
xmax=5, nx=20, ny=20, in=1, out=0.9429
xmax=100, nx=200, ny=20, in=1, out=0.8178
xmax=1000, nx=2000, ny=20, in=1, out=0.8178

rho=4.3679e-6, mu=3.8236e-7, v=2865:
xmax=100, nx=200, ny=20, in=2.865000e+03, out=2.864771e+03, oscilations in the entry of the channel
xmax=1000, nx=2000, ny=20, in=2.865000e+03, out=2.864789e+03, oscilations in the entry of the channel


* ns01-t.i:
	- mesh 3D: test2.msh, one cooling channel
	- uses PSPG, SUPG, first order

rho=mu=v=1:
H=5, nz=20, in=0.9766, out=0.9020
H=100, nz=200, in=0.9706, out=0.8068
H=1000, nz=2000, in=0.9706, out=0.8068

I think the diff in the in_flow is caused by different 2D discretizations of the top surface.

rho=4.3679e-6, mu=3.8236e-7, v=2865:

H=5, nz=20, in=, out=, did not converge
H=100, nz=200, in=, out=, did not converge
H=1000, nz=2000, in=, out=, did not converge

Comments:
- real value simulation needs a very small dt



Needs reviewing:

* ns02-t.i:
	- test6.msh: 3 cooling channels

* ns03-t.i:
	- test7.msh: fuel assembly
