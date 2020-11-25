SetFactory("OpenCASCADE");

h = 0.5;
P = 7; // flat-to-flat distance/2
F = P/Cos(Pi/6)/2;

// Points & Lines
x = 0; y = 0;
Point(1) = {x, y, 0, h};
x = 0; y = P;
Point(2) = {x, y, 0, h};
x = F; y = P;
Point(3) = {x, y, 0, h};

Line(1) = {1, 2};
Line(2) = {2, 3};
Line(3) = {3, 1};
Curve Loop(1) = {1, 2, 3};
Plane Surface(1) = {1};


Extrude {0, 0, 10} {
  // Surface{1}; Layers{10}; Recombine;
  Surface{1}; Layers{10};
}

Physical Volume("prism") = {1};

Physical Surface("bot") = {1};
Physical Surface("left") = {2};
Physical Surface("out") = {3};
Physical Surface("right") = {4};
Physical Surface("top") = {5};

Physical Line("center") = {4};