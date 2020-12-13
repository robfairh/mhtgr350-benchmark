// Defines a 3D 4 cooling channels
SetFactory("OpenCASCADE");

Rc = 0.794;
// Rc = 1.0;

p = 1.88;
f = p/Cos(Pi/6);

// Circles
c = 1;
X = 3/4*p;
x = X; y = -3*f;
Circle(c) = { x, y, 0, Rc, 0, 2*Pi};
Curve Loop(c) = {c};
Plane Surface(c) = {c}; c+=1;
x = X; y = -f;
Circle(c) = { x, y, 0, Rc, 0, 2*Pi};
Curve Loop(c) = {c};
Plane Surface(c) = {c}; c+=1;
x = X; y = f;
Circle(c) = { x, y, 0, Rc, 0, 2*Pi};
Curve Loop(c) = {c};
Plane Surface(c) = {c}; c+=1;
x = X; y = 3*f;
Circle(c) = { x, y, 0, Rc, 0, 2*Pi};
Curve Loop(c) = {c};
Plane Surface(c) = {c}; c+=1;

X = (3/4+3/2)*p;
x = X; y = -3*f;
Circle(c) = { x, y, 0, Rc, 0, 2*Pi};
Curve Loop(c) = {c};
Plane Surface(c) = {c}; c+=1;
x = X; y = -f;
Circle(c) = { x, y, 0, Rc, 0, 2*Pi};
Curve Loop(c) = {c};
Plane Surface(c) = {c}; c+=1;
x = X; y = f;
Circle(c) = { x, y, 0, Rc, 0, 2*Pi};
Curve Loop(c) = {c};
Plane Surface(c) = {c}; c+=1;
x = X; y = 3*f;
Circle(c) = { x, y, 0, Rc, 0, 2*Pi};
Curve Loop(c) = {c};
Plane Surface(c) = {c}; c+=1;

X = (3/4+3)*p;
x = X; y = -3*f;
Circle(c) = { x, y, 0, Rc, 0, 2*Pi};
Curve Loop(c) = {c};
Plane Surface(c) = {c}; c+=1;
x = X; y = -f;
Circle(c) = { x, y, 0, Rc, 0, 2*Pi};
Curve Loop(c) = {c};
Plane Surface(c) = {c}; c+=1;
x = X; y = f;
Circle(c) = { x, y, 0, Rc, 0, 2*Pi};
Curve Loop(c) = {c};
Plane Surface(c) = {c}; c+=1;
x = X; y = 3*f;
Circle(c) = { x, y, 0, Rc, 0, 2*Pi};
Curve Loop(c) = {c};
Plane Surface(c) = {c}; c+=1;

X = (3/4+3*3/2)*p;
x = X; y = -3*f;
Circle(c) = { x, y, 0, Rc, 0, 2*Pi};
Curve Loop(c) = {c};
Plane Surface(c) = {c}; c+=1;
x = X; y = -f;
Circle(c) = { x, y, 0, Rc, 0, 2*Pi};
Curve Loop(c) = {c};
Plane Surface(c) = {c}; c+=1;
x = X; y = f;
Circle(c) = { x, y, 0, Rc, 0, 2*Pi};
Curve Loop(c) = {c};
Plane Surface(c) = {c}; c+=1;
x = X; y = 3*f;
Circle(c) = { x, y, 0, Rc, 0, 2*Pi};
Curve Loop(c) = {c};
Plane Surface(c) = {c}; c+=1;

Extrude {0, 0, 5} {
   Surface{1}; Surface{2}; Surface{3}; Surface{4}; Surface{5};
   Surface{6}; Surface{7}; Surface{8}; Surface{9}; Surface{10};
   Surface{11}; Surface{12}; Surface{13}; Surface{14}; Surface{15};
   Surface{16};
   Layers{20};
}

pl = 33;
Point(pl) = {6*p, 4*f, 5, 1.0}; pl+=1;
Point(pl) = {6*p, -4*f, 5, 1.0}; pl+=1;
Point(pl) = {0, 4*f, 5, 1.0}; pl+=1;
Point(pl) = {0, -4*f, 5, 1.0}; pl+=1;

Line(49) = {36, 34};
Line(50) = {34, 33};
Line(51) = {33, 35};
Line(52) = {35, 36};
Curve Loop(49) = {49, 50, 51, 52};
Curve Loop(50) = {18};
Curve Loop(51) = {20};
Curve Loop(52) = {22};
Curve Loop(53) = {24};
Curve Loop(54) = {26};
Curve Loop(55) = {28};
Curve Loop(56) = {30};
Curve Loop(57) = {32};
Curve Loop(58) = {34};
Curve Loop(59) = {36};
Curve Loop(60) = {38};
Curve Loop(61) = {40};
Curve Loop(62) = {42};
Curve Loop(63) = {44};
Curve Loop(64) = {46};
Curve Loop(65) = {48};
Plane Surface(49) = {49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65};

Extrude {0, 0, 5} {
  Surface{18}; Surface{20}; Surface{22}; Surface{24}; Surface{26}; Surface{28}; Surface{30}; Surface{32}; Surface{34}; Surface{36}; Surface{38}; Surface{40}; Surface{42}; Surface{44}; Surface{46}; Surface{48}; Surface{49}; 
  Layers{20};
}

Physical Volume("coolant") = {
1, 2, 3, 4, 5, 6, 7, 8, 9, 10,
11, 12, 13, 14, 15, 16, 17, 18, 19, 20,
21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
31, 32, 33
};

Physical Surface("channel_wall") = {
17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 41, 43, 45, 47
};

Physical Surface("plenum_wall") = {82, 85, 83, 84};
Physical Surface('plenum') = {49};
Physical Surface("cool_bot") = {
 	1, 2, 3, 4, 5, 6, 7, 8, 9, 10,
 	11, 12, 13, 14, 15, 16
};

Physical Surface("cool_top") = {51, 53, 55, 57, 59, 61, 63, 65, 67, 69, 71, 73, 75, 77, 79, 81, 86};

Mesh.CharacteristicLengthFactor = 1;
Mesh.CharacteristicLengthExtendFromBoundary = 1;
Mesh.CharacteristicLengthFromCurvature = 1;
Mesh.MinimumCirclePoints = 10;
