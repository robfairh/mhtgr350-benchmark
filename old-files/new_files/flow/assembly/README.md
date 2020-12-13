
assembly1.i:
- first order, integrate_by_parts=true

* rho=mu=v=1:
H1=100, L1=200, H2=5, L2=20

It is wrong, I think the integrating by pressure=true doesn't work with the half channel ...
See .csv
Make python post-processor
Check if this is true.
It is is, what should that BC be for the pressure ?

* ns07B:
	- test7B.msh

	- rho=mu=v=1
		- H1=5, nz=40, H2=5, nz=40, works

	- rho=4.3679e-6, mu=3.8236e-7, v=735
		- H1=5, nz=40, H2=5, nz=40, works



* ns07C:
	- test7C.msh
	- rho=mu=v=1
		- H1=5, nz=40, H2=5, nz=40, works

	- rho=4.3679e-6, mu=3.8236e-7, v=735
		- H1=5, n1=40, H2=5, n2=40, 2D mesh: 0.6, 1, 1, 10
		- H1=5, n1=40, H2=5, n2=40, 2D mesh: 0.7, 1, 1, 20
		- H1=5, n1=100, H2=5, n2=30, 2D mesh: 0.6, 1, 1, 10

did not converge

- rho=mu=1, v=10
- test7C-1.msh: H1=5, n1=50, H2=5, n2=50, 2D mesh: 0.6, 1, 1, 10, converged

- rho=mu=1, v=100
- test7C-1.msh: H1=5, n1=50, H2=5, n2=50, 2D mesh: 0.6, 1, 1, 10, did not converge

- rho=1, mu=1e-2, v=100
- test7C-1.msh: H1=5, n1=50, H2=5, n2=50, 2D mesh: 0.6, 1, 1, 10, did not converge

- rho=1e-2, mu=1, v=100
- test7C-1.msh: H1=5, n1=50, H2=5, n2=50, 2D mesh: 0.6, 1, 1, 10, converged

- rho=1e-2, mu=1e-3, v=100
- test7C-2.msh: H1=5, n1=100, H2=5, n2=100, 2D mesh: 0.6, 1, 1, 10, did not converge

- rho=1e-4, mu=1e-5, v=10
- test7C-2.msh: H1=5, n1=100, H2=5, n2=100, 2D mesh: 0.6, 1, 1, 10, converged

- rho=1e-4, mu=1e-5, v=100
- test7C-2.msh: H1=5, n1=100, H2=5, n2=100, 2D mesh: 0.6, 1, 1, 10, did not converge

- rho=1e-6, mu=1e-7, v=1
- test7C-3.msh: H1=5, n1=200, H2=5, n2=200, 2D mesh: 0.6, 1, 1, 10, converged

- rho=1e-6, mu=1e-7, v=10
- test7C-3.msh: H1=5, n1=200, H2=5, n2=200, 2D mesh: 0.6, 1, 1, 10, converged

- rho=1e-6, mu=1e-7, v=100
- test7C-3.msh: H1=5, n1=200, H2=5, n2=200, 2D mesh: 0.6, 1, 1, 10, did not converge

- rho=4.3679e-6, mu=3.8236e-7, v=1
- test7C-3.msh: H1=5, n1=200, H2=5, n2=200, 2D mesh: 0.6, 1, 1, 10, converged

- rho=4.3679e-6, mu=3.8236e-7, v=10
- test7C-3.msh: H1=5, n1=200, H2=5, n2=200, 2D mesh: 0.6, 1, 1, 10, converged

- rho=4.3679e-6, mu=3.8236e-7, v=40
- test7C-3.msh: H1=5, n1=200, H2=5, n2=200, 2D mesh: 0.6, 1, 1, 10, did not converge

- rho=4.3679e-6, mu=3.8236e-7, v=70
- test7C-3.msh: H1=5, n1=200, H2=5, n2=200, 2D mesh: 0.6, 1, 1, 10, did not converge

- rho=4.3679e-6, mu=3.8236e-7, v=100
- test7C-3.msh: H1=5, n1=200, H2=5, n2=200, 2D mesh: 0.6, 1, 1, 10, did not converge

- rho=4.3679e-6, mu=3.8236e-7, v=15
- test7C-3.msh: H1=5, n1=200, H2=5, n2=200, 2D mesh: 0.6, 1, 1, 10, converged

- rho=4.3679e-6, mu=3.8236e-7, v=20
- test7C-3.msh: H1=5, n1=200, H2=5, n2=200, 2D mesh: 0.6, 1, 1, 10, did not converge

- rho=4.3679e-6, mu=3.8236e-7, v=25
- test7C-3.msh: H1=5, n1=200, H2=5, n2=200, 2D mesh: 0.6, 1, 1, 10, did not converge

- rho=4.3679e-6, mu=3.8236e-7, v=30
- test7C-3.msh: H1=5, n1=200, H2=5, n2=200, 2D mesh: 0.6, 1, 1, 10, did not converge

- rho=4.3679e-6, mu=3.8236e-7, v=35
- test7C-3.msh: H1=5, n1=200, H2=5, n2=200, 2D mesh: 0.6, 1, 1, 10, did not converge

- rho=4.3679e-6, mu=3.8236e-7, v=20
- test7C-4.msh: H1=20, n1=100, H2=20, n2=100, 2D mesh: 0.6, 1, 1, 10, converged

- rho=4.3679e-6, mu=3.8236e-7, v=20
- test7C-5.msh: H1=20, n1=200, H2=20, n2=200, 2D mesh: 0.6, 1, 1, 10, did not converge

- rho=4.3679e-6, mu=3.8236e-7, v=20
- test7C-8.msh: H1=5, n1=200, H2=5, n2=200, 2D mesh: 0.6, 1, 1, 20, converged

- rho=4.3679e-6, mu=3.8236e-7, v=50
- test7C-4.msh: H1=20, n1=100, H2=20, n2=100, 2D mesh: 0.6, 1, 1, 10, did not converge

- rho=4.3679e-6, mu=3.8236e-7, v=50
- test7C-8.msh: H1=5, n1=200, H2=5, n2=200, 2D mesh: 0.6, 1, 1, 20, did not converge

- rho=4.3679e-6, mu=3.8236e-7, v=50
- test7C.msh: H1=40, n1=200, H2=40, n2=200, 2D mesh: 0.6, 1, 1, 20, did not converge

- test7C.msh: H1=40, n1=200, H2=40, n2=200, 2D mesh: 0.6, 1, 1, 30, did not converge
- test7C.msh: H1=40, n1=200, H2=40, n2=200, 2D mesh: 0.6, 1, 1, 30, Rc = 0.794, OOM
- test7C.msh: H1=40, n1=200, H2=40, n2=200, 2D mesh: 0.6, 1, 1, 25, Rc = 0.794, 11636777.bw




- test7C-1.msh: H1=5, n1=50, H2=5, n2=50, 2D mesh: 0.6, 1, 1, 10
- test7C-2.msh: H1=5, n1=100, H2=5, n2=100, 2D mesh: 0.6, 1, 1, 10
- test7C-3.msh: H1=5, n1=200, H2=5, n2=200, 2D mesh: 0.6, 1, 1, 10
- test7C-4.msh: H1=20, n1=100, H2=20, n2=100, 2D mesh: 0.6, 1, 1, 10
- test7C-5.msh: H1=20, n1=200, H2=20, n2=200, 2D mesh: 0.6, 1, 1, 10
- test7C-6.msh: H1=5, n1=50, H2=5, n2=50, 2D mesh: 0.6, 1, 1, 20
- test7C-7.msh: H1=5, n1=100, H2=5, n2=100, 2D mesh: 0.6, 1, 1, 20
- test7C-8.msh: H1=5, n1=200, H2=5, n2=200, 2D mesh: 0.6, 1, 1, 20






* ns07D:
	- test7D.msh
	- rho=mu=v=1
		- H1=5, nz=40, H2=5, nz=40, works
	- rho=4.3679e-6, mu=3.8236e-7, v=735
		- H1=5, nz=40, H2=5, nz=40, did not converge


* ns07E:
	- test7E.msh
	- rho=mu=v=1 works
		- H1=5, nz=40, H2=5, nz=40

	- rho=4.3679e-6, mu=3.8236e-7, v=735
		- H1=5, nz=40, H2=5, nz=40, did not converge


* ns07F:
	- rho=mu=v=1
		- test7F-1.msh: H1=5, nz=40, H2=5, nz=40, works
		- test7F-2.msh: H1=10, n1=50, H2=5, n2=30, works
		- test7F-3.msh: H1=50, n1=250, H2=5, n2=30, works
		- test7F-4.msh: H1=100, n1=400, H2=5, n2=30, works (nl_rel_tol = 1e-10)
		- test7F-5.msh: H1=400, n1=2000, H2=5, n2=30, works (nl_rel_tol = 1e-10)
		- test7F-6.msh: H1=800, n1=4000, H2=5, n2=30, works

	- rho=4.3679e-6, mu=3.8236e-7, v=1
		- test7F-1.msh: H1=5, nz=40, H2=5, nz=40, converged

	- rho=4.3679e-6, mu=3.8236e-7, v=10
		- test7F-1.msh: H1=5, nz=40, H2=5, nz=40, converged

	- rho=4.3679e-6, mu=3.8236e-7, v=15
		- test7F-1.msh: H1=5, nz=40, H2=5, nz=40, converged

	- rho=4.3679e-6, mu=3.8236e-7, v=20
		- test7F-1.msh: H1=5, nz=40, H2=5, nz=40, converged

	- rho=4.3679e-6, mu=3.8236e-7, v=25
		- test7F-1.msh: H1=5, nz=40, H2=5, nz=40, did not converge

	- rho=4.3679e-6, mu=3.8236e-7, v=30
		- test7F-1.msh: H1=5, nz=40, H2=5, nz=40, did not converge


- rho=4.3679e-6, mu=3.8236e-7, v=25
- test7F.msh: H1=20, nz=100, H2=20, nz=100, converged

- rho=4.3679e-6, mu=3.8236e-7, v=30
- test7F.msh: H1=20, nz=100, H2=20, nz=100, converged

- rho=4.3679e-6, mu=3.8236e-7, v=40
- test7F.msh: H1=20, nz=100, H2=20, nz=100, did not converge
- test7F.msh: H1=20, nz=100, H2=20, nz=100, R=0.794, 11636805.bw