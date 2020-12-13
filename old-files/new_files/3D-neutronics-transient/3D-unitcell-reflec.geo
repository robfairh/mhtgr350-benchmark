// This .geo defines the geometry of a unit cell of the MHTGR-350.

/* Fuel assembly column height H = 793 cm (10 fuel assemblies stacked on top
of each other). */
H = 793;
topref = 120; // 120 cm
botref = 160; // 160 cm

// Pitch: distance between coolant and fuel channel.
p = 1.88; // 1.88 cm
px = p * Cos(Pi/6);
py = p * Sin(Pi/6);
rc = 0.794; // Coolant channel radius
rf = 0.635; // Fuel channel radius

// element size (finite element, not fuel element)
h = 10;

SetFactory("OpenCASCADE");
// fuel + moderator + coolant channel
Point(1) = {0, 0, 0, h};
Point(2) = {px, 0, 0, h};
Point(3) = {px, -py, 0, h};

Circle(1) = {0, 0, 0, rc, 11/6*Pi, 2*Pi};
Circle(2) = {px, -py, 0, rf, Pi/2, 5/6*Pi};

Line(3) = {1, 4};
Line(4) = {4, 2};
Line(5) = {2, 7};
Line(6) = {7, 3};
Line(7) = {3, 6};
Line(8) = {6, 5};
Line(9) = {5, 1};

Curve Loop(1) = {9, 3, 1};
Plane Surface(1) = {1};
Curve Loop(2) = {7, 2, 6};
Plane Surface(2) = {2};
Curve Loop(3) = {8, -1, 4, 5, -2};
Plane Surface(3) = {3};

Extrude {0, 0, botref} {
  Surface{1}; Surface{3}; Surface{2}; Layers{botref/h}; Recombine;
}
Extrude {0, 0, H} {
  Surface{7}; Surface{12}; Surface{15}; Layers{H/h}; Recombine;
}
Extrude {0, 0, topref} {
  Surface{19}; Surface{24}; Surface{27}; Layers{topref/h}; Recombine;
}
//+
Physical Volume("fuel") = {6};
Physical Volume("moderator") = {5};
Physical Volume("coolant") = {4};
Physical Volume("breflector") = {1, 2, 3};
Physical Volume("treflector") = {7, 8,9};

Physical Surface("ref_bot") = {1, 2, 3};
Physical Surface("ref_top") = {31, 36, 39};

Physical Surface("cool_bot") = {7};
Physical Surface("moder_bot") = {12};
Physical Surface("fuel_bot") = {15};

Physical Surface("cool_top") = {19};
Physical Surface("moder_top") = {24};
Physical Surface("fuel_top") = {27};
