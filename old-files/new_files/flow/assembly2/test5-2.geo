// Defines a 3D 4 cooling channels
SetFactory("OpenCASCADE");

Rc = 0.794;
// Rc = 1.0;

p = 1.88;
f = p/Cos(Pi/6);

// Circles
x = 3/4*p; y = -f;
Circle(1) = { x, y, 0, Rc, 0, 2*Pi};
Curve Loop(1) = {1};
Plane Surface(1) = {1};

x = 3/4*p; y = f;
Circle(2) = { x, y, 0, Rc, 0, 2*Pi};
Curve Loop(2) = {2};
Plane Surface(2) = {2};

x = 3/4*p+3/2*p; y = -f;
Circle(3) = { x, y, 0, Rc, 0, 2*Pi};
Curve Loop(3) = {3};
Plane Surface(3) = {3};

x = 3/4*p+3/2*p; y = f;
Circle(4) = { x, y, 0, Rc, 0, 2*Pi};
Curve Loop(4) = {4};
Plane Surface(4) = {4};

Extrude {0, 0, 5} {
   Surface{1}; Surface{2}; Surface{3}; Surface{4};
   Layers{20};
}

pl = 9;
Point(pl) = {3*p, 2*f, 5, 1.0}; pl+=1;
Point(pl) = {3*p, -2*f, 5, 1.0}; pl+=1;
Point(pl) = {0, 2*f, 5, 1.0}; pl+=1;
Point(pl) = {0, -2*f, 5, 1.0}; pl+=1;

Line(13) = {12, 10};
Line(14) = {10, 9};
Line(15) = {9, 11};
Line(16) = {12, 11};
Curve Loop(13) = {13, 14, 15, -16};
Curve Loop(14) = {6};
Curve Loop(15) = {8};
Curve Loop(16) = {10};
Curve Loop(17) = {12};
Plane Surface(13) = {13, 14, 15, 16, 17};

Extrude {0, 0, 5} {
  Surface{6}; Surface{8}; Surface{10}; Surface{12}; Surface{13};
  Layers{20};
}

Physical Volume("coolant") = {1, 2, 3, 4, 5, 6, 7, 8, 9};
Physical Surface("channel_wall") = {5, 7, 9, 11};
Physical Surface("plenum_wall") = {22, 23, 24, 25};
Physical Surface("plenum") = {13};
Physical Surface("cool_bot") = {1, 2, 4, 3};
Physical Surface("cool_top") = {15, 17, 19, 21, 26};

Mesh.CharacteristicLengthFactor = 1;
Mesh.CharacteristicLengthExtendFromBoundary = 1;
Mesh.CharacteristicLengthFromCurvature = 1;
Mesh.MinimumCirclePoints = 10;
