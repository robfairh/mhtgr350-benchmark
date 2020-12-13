// No top and bottom reflector

Geometry.CopyMeshingMethod = 1;

Rf = 0.635;  // 0.635 cm
Rc = 0.794;  // 0.794 cm
pi = 1.88;  // 1.88 cm
h = .5;

a = 36.0/2/Cos(Pi/6);
R1 = 4*a;
R2 = 8*a;
R3 = 340.0;
H = 793;

num_segments = (R2-R1)/3/pi;
Printf("%f", num_segments);
num_segments = 14;  // I tried casting to int and it doesn't work
E = R2-R1-num_segments*3*pi;

lx = .3;
ly = 3;

R = R1+E/2;
Point(1) = {R, 0, 0, h};
Point(2) = {R, H, 0, h};
Line(1) = {1, 2};

R += 2*Rf;
Point(3) = {R, 0, 0, h};
Point(4) = {R, H, 0, h};
Line(2) = {1, 3};
Line(3) = {4, 2};
Line(4) = {3, 4};

R += pi-Rf-Rc;
Point(5) = {R, 0, 0, h};
Point(6) = {R, H, 0, h};
Line(5) = {3, 5};
Line(6) = {6, 4};
Line(7) = {5, 6};

R += 2*Rc;
Point(7) = {R, 0, 0, h};
Point(8) = {R, H, 0, h};
Line(8) = {5, 7};
Line(9) = {8, 6};
Line(10) = {7, 8};

R += pi-Rc-Rf;
Point(9) = {R, 0, 0, h};
Point(10) = {R, H, 0, h};
Line(11) = {7, 9};
Line(12) = {10, 8};
Line(13) = {9, 10};

R += 2*Rf;
Point(11) = {R, 0, 0, h};
Point(12) = {R, H, 0, h};
Line(14) = {9, 11};
Line(15) = {12, 10};
Line(16) = {11, 12};

R += pi-2*Rf;
Point(13) = {R, 0, 0, h};
Point(14) = {R, H, 0, h};
Line(17) = {11, 13};
Line(18) = {14, 12};
Line(19) = {13, 14};

// Fuel
Curve Loop(1) = {-1, 2, 3, 4};
Plane Surface(1) = {1};
// Mod
Curve Loop(2) = {-4, 5, 6, 7};
Plane Surface(2) = {2};
// Cool
Curve Loop(3) = {-7, 8, 9, 10};
Plane Surface(3) = {3};
// Mod
Curve Loop(4) = {-10, 11, 12, 13};
Plane Surface(4) = {4};
// Fuel
Curve Loop(5) = {-13, 14, 15, 16};
Plane Surface(5) = {5};
// Mod
Curve Loop(6) = {-16, 17, 18, 19};
Plane Surface(6) = {6};

// Fuel
Transfinite Line{2, 3} = 2*Rf/lx;
// Mod
Transfinite Line{5, 6} = (pi-Rf-Rc)/lx;
// Cool
Transfinite Line{8, 9} = 2*Rc/lx;
// Mod
Transfinite Line{11, 12} = (pi-Rc-Rf)/lx;
// Fuel
Transfinite Line{14, 15} = 2*Rf/lx;
// Mod
Transfinite Line{17, 18} = (pi-2*Rf)/lx;

Transfinite Line{1, 4, 7, 10, 13, 16, 19} = H/ly;

Transfinite Surface{1};
Transfinite Surface{2};
Transfinite Surface{3};
Transfinite Surface{4};
Transfinite Surface{5};
Transfinite Surface{6};

Recombine Surface{1};
Recombine Surface{2};
Recombine Surface{3};
Recombine Surface{4};
Recombine Surface{5};
Recombine Surface{6};

fuel_surfaces[] = {1, 5};
moder_surfaces[] = {2, 4, 6};
cool_surfaces[] = {3};

fuel_bots[] = {2, 14};
fuel_tops[] = {3, 15};
moder_bots[] = {5, 11, 17};
moder_tops[] = {6, 12, 18};
cool_bots[] = {8};
cool_tops[] = {9};

For xindex In {1:num_segments-2}

	new_f_surface = Translate {xindex*3*pi, 0, 0} {
	  Duplicata { Surface{1}; }
	};
	fuel_surfaces += new_f_surface;

	new_m_surface = Translate {xindex*3*pi, 0, 0} {
	  Duplicata { Surface{2}; }
	};
	moder_surfaces += new_m_surface;

	new_c_surface = Translate {xindex*3*pi, 0, 0} {
	  Duplicata { Surface{3}; }
	};
	cool_surfaces += new_c_surface;

	new_m_surface = Translate {xindex*3*pi, 0, 0} {
	  Duplicata { Surface{4}; }
	};
	moder_surfaces += new_m_surface;

	new_f_surface = Translate {xindex*3*pi, 0, 0} {
	  Duplicata { Surface{5}; }
	};
	fuel_surfaces += new_f_surface;

	new_m_surface = Translate {xindex*3*pi, 0, 0} {
	  Duplicata { Surface{6}; }
	};
	moder_surfaces += new_m_surface;	

	fuel_tops += {24 + (xindex - 1) * 30};
	moder_tops += {29 + (xindex - 1) * 30};
 	cool_tops += {34 + (xindex - 1) * 30};
	moder_tops += {39 + (xindex - 1) * 30};
	fuel_tops += {44 + (xindex - 1) * 30};
	moder_tops += {49 + (xindex - 1) * 30};

	fuel_bots += {22 + (xindex - 1) * 30};
	moder_bots += {27 + (xindex - 1) * 30};
	cool_bots += {32 + (xindex - 1) * 30};
	moder_bots += {37 + (xindex - 1) * 30};
	fuel_bots += {42 + (xindex - 1) * 30};
	moder_bots += {47 + (xindex - 1) * 30};

EndFor // xindex

new_f_surface = Translate {xindex*3*pi, 0, 0} {
  Duplicata { Surface{1}; }
};
fuel_surfaces += new_f_surface;

new_m_surface = Translate {xindex*3*pi, 0, 0} {
  Duplicata { Surface{2}; }
};
moder_surfaces += new_m_surface;

new_c_surface = Translate {xindex*3*pi, 0, 0} {
  Duplicata { Surface{3}; }
};
cool_surfaces += new_c_surface;

new_m_surface = Translate {xindex*3*pi, 0, 0} {
  Duplicata { Surface{4}; }
};
moder_surfaces += new_m_surface;

new_f_surface = Translate {xindex*3*pi, 0, 0} {
  Duplicata { Surface{5}; }
};
fuel_surfaces += new_f_surface;

fuel_tops += {24 + (xindex - 1) * 30};
moder_tops += {29 + (xindex - 1) * 30};
cool_tops += {34 + (xindex - 1) * 30};
moder_tops += {39 + (xindex - 1) * 30};
fuel_tops += {44 + (xindex - 1) * 30};

fuel_bots += {22 + (xindex - 1) * 30};
moder_bots += {27 + (xindex - 1) * 30};
cool_bots += {32 + (xindex - 1) * 30};
moder_bots += {37 + (xindex - 1) * 30};
fuel_bots += {42 + (xindex - 1) * 30};

// Central reflector
Point(785) = {0, 0, 0, 1.0};
Point(786) = {0, H, 0, 1.0};
Line(405) = {785, 786};
Line(406) = {785, 1};
Line(407) = {2, 786};
Curve Loop(7) = {-405, 406, 407, 1};
Plane Surface(401) = {7};

// Outer reflector
Point(787) = {R3, 0, 0, 1.0};
Point(788) = {R3, H, 0, 1.0};
Line(408) = {780, 787};
Line(409) = {788, 784};
Line(410) = {787, 788};
Curve Loop(8) = {-403, 408, 409, 410};
Plane Surface(402) = {8};

lx2 = 2;
Transfinite Line{406, 407} = (R1+E/2)/lx2;
Transfinite Line{408, 409} = (R3-R2+E/2)/lx2;
Transfinite Line{405, 1} = H/ly;
Transfinite Line{403, 410} = H/ly;

Transfinite Surface{401};
Transfinite Surface{402};

Recombine Surface{401};
Recombine Surface{402};

moder_surfaces += {401};
moder_surfaces += {402};

moder_tops += {407};
moder_tops += {409};
moder_bots += {406};
moder_bots += {408};

Physical Surface("fuel") = { fuel_surfaces[] };
Physical Surface("moderator") = { moder_surfaces[] };
Physical Surface("coolant") = { cool_surfaces[] };

Physical Line("fuel_top") = { fuel_tops[] };
Physical Line("moder_top") = { moder_tops[] };
Physical Line("cool_top") = { cool_tops[] };
Physical Line("fuel_bot") = { fuel_bots[] };
Physical Line("moder_bot") = { moder_bots[] };
Physical Line("cool_bot") = { cool_bots[] };

Physical Line("outer_wall") = {410};