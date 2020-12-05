Input files:
------------

* model1.i
	- model1.geo
	- neutronics affect thermal-tluids
	- thermal-fluids affect the neutronics
	- uses the point-wise temperatures for calculating the thermal feedback
	- if it uses PJFNK and no petsc options it runs, it takes forever, I haven't run it to the end
	- two ways in which the heat produced by the neutronics can be deposited in the fuel:
	  1) account for all the fissions in the fuel region: Fuel+film+cool
	  and let the coolant and film have a heat source.
	  2) scale the power to the fissions in the fuel only.
	  1) seems to be more accurate from a neutronics stand point and 2)
	  more accurate from a thermal-hydraulics stand point.
	  I chose the second one.

* model1-noTF.i
	- model1.geo
	- similar to coupledD but w/ no thermal feedback
	- neutronics affect Thermal-Fluids
	- Thermal-Fluids don't affect the neutronics 

* model2.i
	- model2.geo
		* separates the films into 10 layers
	- calculates temperature averages in the heterogeneous regions
	- divides the fuel temperature zones
	- required using 'PostprocessorAux.C' (testApp)

Geometries:
-----------
The difference between model1.geo and model2.geo is that model2 divides the film into axial layers.
This is necessary for obtaining the average temperatures in each 'assembly.'