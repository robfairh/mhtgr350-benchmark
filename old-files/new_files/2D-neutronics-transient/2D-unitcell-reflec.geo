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
HB = 160;
HT = 120;

lx = .5;
lyc = 6;
lyb = 3;
lyt = 3;

R = 0;
Point(1) = {R, 0, 0, h};
Point(2) = {R, H, 0, h};
Line(1) = {1, 2};

R += (pi-2*Rf)/2;
Point(3) = {R, 0, 0, h};
Point(4) = {R, H, 0, h};
Line(2) = {1, 3};
Line(3) = {4, 2};
Line(4) = {3, 4};

R += 2*Rf;
Point(5) = {R, 0, 0, h};
Point(6) = {R, H, 0, h};
Line(5) = {3, 5};
Line(6) = {6, 4};
Line(7) = {5, 6};

R += pi-Rf-Rc;
Point(7) = {R, 0, 0, h};
Point(8) = {R, H, 0, h};
Line(8) = {5, 7};
Line(9) = {8, 6};
Line(10) = {7, 8};

R += 2*Rc;
Point(9) = {R, 0, 0, h};
Point(10) = {R, H, 0, h};
Line(11) = {7, 9};
Line(12) = {10, 8};
Line(13) = {9, 10};

R += pi-Rc-Rf;
Point(11) = {R, 0, 0, h};
Point(12) = {R, H, 0, h};
Line(14) = {9, 11};
Line(15) = {12, 10};
Line(16) = {11, 12};

R += 2*Rf;
Point(13) = {R, 0, 0, h};
Point(14) = {R, H, 0, h};
Line(17) = {11, 13};
Line(18) = {14, 12};
Line(19) = {13, 14};

R += (pi-2*Rf)/2;
Point(15) = {R, 0, 0, h};
Point(16) = {R, H, 0, h};
Line(20) = {13, 15};
Line(21) = {16, 14};
Line(22) = {15, 16};

Curve Loop(1) = {-1, 2, 3, 4};
Plane Surface(1) = {1};
Curve Loop(2) = {-4, 5, 6, 7};
Plane Surface(2) = {2};
Curve Loop(3) = {-7, 8, 9, 10};
Plane Surface(3) = {3};
Curve Loop(4) = {-10, 11, 12, 13};
Plane Surface(4) = {4};
Curve Loop(5) = {-13, 14, 15, 16};
Plane Surface(5) = {5};
Curve Loop(6) = {-16, 17, 18, 19};
Plane Surface(6) = {6};
Curve Loop(7) = {-19, 20, 21, 22};
Plane Surface(7) = {7};

// Mod
Transfinite Line{2, 3} = (pi-2*Rf)/2/lx;
// Fuel
Transfinite Line{5, 6} = 2*Rf/lx;
// Mod
Transfinite Line{8, 9} = (pi-Rf-Rc)/lx;
// Cool
Transfinite Line{11, 12} = 2*Rc/lx;
// Mod
Transfinite Line{14, 15} = (pi-Rc-Rf)/lx;
// Fuel
Transfinite Line{17, 18} = 2*Rf/lx;
// Mod
Transfinite Line{20, 21} = (pi-2*Rf)/2/lx;

Transfinite Line{1, 4, 7, 10, 13, 16, 19, 22} = H/lyc;

Transfinite Surface{1};
Transfinite Surface{2};
Transfinite Surface{3};
Transfinite Surface{4};
Transfinite Surface{5};
Transfinite Surface{6};
Transfinite Surface{7};

Recombine Surface{1};
Recombine Surface{2};
Recombine Surface{3};
Recombine Surface{4};
Recombine Surface{5};
Recombine Surface{6};
Recombine Surface{7};

fuel_surfaces[] = {2, 6};
moder_surfaces[] = {1, 3, 5, 7};
cool_surfaces[] = {4};

fuel_bots[] = {5, 17};
fuel_tops[] = {6, 18};
moder_bots[] = {2, 8, 14, 20};
moder_tops[] = {3, 9, 15, 21};
cool_bots[] = {11};
cool_tops[] = {12};

// Bottom reflector
mod_refl_bot[] = {};
cool_refl_bot[] = {};

new_m_curve = Extrude {0, -HB, 0} {
	Curve{2}; Layers{HB/lyb-1}; Recombine;
};
mod_refl_bot += new_m_curve;

new_m_curve = Extrude {0, -HB, 0} {
	Curve{5}; Layers{HB/lyb-1}; Recombine;
};
mod_refl_bot += new_m_curve;

new_m_curve = Extrude {0, -HB, 0} {
	Curve{8}; Layers{HB/lyb-1}; Recombine;
};
mod_refl_bot += new_m_curve;

new_c_curve = Extrude {0, -HB, 0} {
	Curve{11}; Layers{HB/lyb-1}; Recombine;
};
cool_refl_bot += new_c_curve;

new_m_curve = Extrude {0, -HB, 0} {
	Curve{14}; Layers{HB/lyb-1}; Recombine;
};
mod_refl_bot += new_m_curve;

new_m_curve = Extrude {0, -HB, 0} {
	Curve{17}; Layers{HB/lyb-1}; Recombine;
};
mod_refl_bot += new_m_curve;

new_m_curve = Extrude {0, -HB, 0} {
	Curve{20}; Layers{HB/lyb-1}; Recombine;
};
mod_refl_bot += new_m_curve;

// Top reflector
mod_refl_top[] = {};
cool_refl_top[] = {};

new_m_curve = Extrude {0, HT, 0} {
	Curve{3}; Layers{HT/lyt-1}; Recombine;
};
mod_refl_top += new_m_curve;

new_m_curve = Extrude {0, HT, 0} {
	Curve{6}; Layers{HT/lyt-1}; Recombine;
};
mod_refl_top += new_m_curve;

new_m_curve = Extrude {0, HT, 0} {
	Curve{9}; Layers{HT/lyt-1}; Recombine;
};
mod_refl_top += new_m_curve;

new_c_curve = Extrude {0, HT, 0} {
	Curve{12}; Layers{HT/lyt-1}; Recombine;
};
cool_refl_top += new_c_curve;

new_m_curve = Extrude {0, HT, 0} {
	Curve{15}; Layers{HT/lyt-1}; Recombine;
};
mod_refl_top += new_m_curve;

new_m_curve = Extrude {0, HT, 0} {
	Curve{18}; Layers{HT/lyt-1}; Recombine;
};
mod_refl_top += new_m_curve;

new_m_curve = Extrude {0, HT, 0} {
	Curve{21}; Layers{HT/lyt-1}; Recombine;
};
mod_refl_top += new_m_curve;

// Coolant includes reflectors
// cool_surfaces += {38, 66};
// bottom_refl[] = {26, 30, 34, 42, 46, 50};
// top_refl[] = {54, 58, 62, 70, 74, 78};
// Physical Line("cool_bot") = { cool_refl_bot[] };
// Physical Line("cool_top") = { cool_refl_top[] };

// Coolant does not include reflectors
mod_refl_bot += cool_refl_bot;
mod_refl_top += cool_refl_top;
bottom_refl[] = {26, 30, 34, 38, 42, 46, 50};
top_refl[] = {54, 58, 62, 66, 70, 74, 78};
Physical Curve("cool_bot") = {11};
Physical Curve("cool_top") = {12};

Physical Surface("fuel") = { fuel_surfaces[] };
Physical Surface("moderator") = { moder_surfaces[] };
Physical Surface("coolant") = { cool_surfaces[] };
Physical Surface("breflector") = { bottom_refl[] };
Physical Surface("treflector") = { top_refl[] };

Physical Line("ref_bot") = { mod_refl_bot[] };
Physical Line("ref_top") = { mod_refl_top[] };
Physical Curve("fuel_top") = {6, 18};
Physical Curve("fuel_bot") = {5, 17};

Physical Curve("mod_top") = {3, 9, 15, 21};
Physical Curve("mod_bot") = {2, 8, 14, 20};
