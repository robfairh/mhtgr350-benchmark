Geometry.CopyMeshingMethod = 1;

Hb = 160;
Hc = 793;
Ht = 120;

F = 18.0;  // Half of flat-to-flat distance
A = F/Cos(Pi/6);
h = 10;

Lb = 40;
Lc = 160;
Lt = 40;

// inner reflector
p = 1;
Point(p) = {0, 0, 0, h}; p += 1;
x = 0; y = 5*F;
Point(p) = {x, y, 0, h}; p += 1;
Line(1) = {1, 2};

x = A/2; y = 5*F;
Point(p) = {x, y, 0, h}; p += 1;
Line(2) = {2, 3};

x += A/2; y -= F;
Point(p) = {x, y, 0, h}; p += 1;
Line(3) = {3, 4};

x += A;
Point(p) = {x, y, 0, h}; p += 1;
Line(4) = {4, 5};

x += A/2; y -= F;
Point(p) = {x, y, 0, h}; p += 1;
Line(5) = {5, 6};

x += A;
Point(p) = {x, y, 0, h}; p += 1;
Line(6) = {6, 7};

x += A/2; y -= F;
Point(p) = {x, y, 0, h}; p += 1;
Line(7) = {7, 8};

x -= A/2; y -= F;
Point(p) = {x, y, 0, h}; p += 1;
Line(8) = {8, 9};

x += A/2; y -= F;
Point(p) = {x, y, 0, h}; p += 1;
Line(9) = {9, 10};

x -= A/2; y -= F;
Point(p) = {x, y, 0, h}; p += 1;
Line(10) = {10, 11};

x += A/2; y -= F;
Point(p) = {x, y, 0, h}; p += 1;
Line(11) = {11, 12};

x += -A + F*Cos(Pi/6); y -= F/2;
Point(p) = {x, y, 0, h}; p += 1;
Line(12) = {12, 13};
Line(13) = {13, 1};

// fuel
x = 0; y = 9*F;
Point(p) = {x, y, 0, h}; p += 1;
Line(14) = {2, 14};

x += A/2; y = 9*F;
Point(p) = {x, y, 0, h}; p += 1;
Line(15) = {14, 15};

x += A/2; y += F;
Point(p) = {x, y, 0, h}; p += 1;
Line(16) = {15, 16};

x += A; y += 0;
Point(p) = {x, y, 0, h}; p += 1;
Line(17) = {16, 17};

x += A/2; y -= F;
Point(p) = {x, y, 0, h}; p += 1;
Line(18) = {17, 18};

x += A; y += 0;
Point(p) = {x, y, 0, h}; p += 1;
Line(19) = {18, 19};

x += A/2; y -= F;
Point(p) = {x, y, 0, h}; p += 1;
Line(20) = {19, 20};

x += A; y += 0;
Point(p) = {x, y, 0, h}; p += 1;
Line(21) = {20, 21};

x += A/2; y -= F;
Point(p) = {x, y, 0, h}; p += 1;
Line(22) = {21, 22};

x += A; y += 0;
Point(p) = {x, y, 0, h}; p += 1;
Line(23) = {22, 23};

x += A/2; y -= F;
Point(p) = {x, y, 0, h}; p += 1;
Line(24) = {23, 24};

x -= A/2; y -= F;
Point(p) = {x, y, 0, h}; p += 1;
Line(25) = {24, 25};

x += A/2; y -= F;
Point(p) = {x, y, 0, h}; p += 1;
Line(26) = {25, 26};

x += A; y += 0;
Point(p) = {x, y, 0, h}; p += 1;
Line(27) = {26, 27};

x += A/2; y -= F;
Point(p) = {x, y, 0, h}; p += 1;
Line(28) = {27, 28};

x -= A/2; y -= F;
Point(p) = {x, y, 0, h}; p += 1;
Line(29) = {28, 29};

x += A/2; y -= F;
Point(p) = {x, y, 0, h}; p += 1;
Line(30) = {29, 30};

x -= A/2; y -= F;
Point(p) = {x, y, 0, h}; p += 1;
Line(31) = {30, 31};

x += A/2; y -= F;
Point(p) = {x, y, 0, h}; p += 1;
Line(32) = {31, 32};

x -= A/2; y -= F;
Point(p) = {x, y, 0, h}; p += 1;
Line(33) = {32, 33};

x += A/2; y -= F;
Point(p) = {x, y, 0, h}; p += 1;
Line(34) = {33, 34};

x -= A/2; y -= F;
Point(p) = {x, y, 0, h}; p += 1;
Line(35) = {34, 35};

x -= A; y -= 0;
Point(p) = {x, y, 0, h}; p += 1;
Line(36) = {35, 36};

x += -A + F*Cos(Pi/6); y -= F/2;
Point(p) = {x, y, 0, h}; p += 1;
Line(37) = {36, 37};
Line(38) = {37, 13};

// outer reflector
OR = 300;

x = 0; y = OR;
Point(p) = {x, y, 0, h}; p += 1;
Line(39) = {14, 38};

x = OR*Cos(Pi/6); y = -OR*Sin(Pi/6);
Point(p) = {x, y, 0, h}; p += 1;

Circle(40) = {38, 1, 39};
Line(41) = {39, 37};

Curve Loop(1) = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13};
Plane Surface(1) = {1};
Curve Loop(2) = {14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, -12, -11, -10, -9, -8, -7, -6, -5, -4, -3, -2};
Plane Surface(2) = {2};
Curve Loop(3) = {39, 40, 41, -37, -36, -35, -34, -33, -32, -31, -30, -29, -28, -27, -26, -25, -24, -23, -22, -21, -20, -19, -18, -17, -16, -15};
Plane Surface(3) = {3};

Physical Surface("ref_bot") = {1, 2, 3};

Extrude {0, 0, Hb} {
  Surface{1}; Surface{2}; Surface{3}; 
  Layers{Lb}; Recombine;
}

Physical Volume("breflector") = {1, 2, 3};
Physical Surface("wall1") = {321, 149, 59};
Physical Surface("wall2") = {107, 245, 329};
Physical Surface("wall3") = {325};
Physical Surface("fuel_bot") = {290};

Extrude {0, 0, Hc} {
  Surface{108}; Surface{290}; Surface{422};
  Layers{Lc}; Recombine;
}

Physical Volume("ireflector") = {4};
Physical Volume("fuel") = {5};
Physical Volume("oreflector") = {6};

Physical Surface("wall1") += {702, 440, 530};
Physical Surface("wall2") += {488, 626, 710};
Physical Surface("wall3") += {706};
Physical Surface("fuel_top") = {671};

Extrude {0, 0, Ht} {
  Surface{489}; Surface{671}; Surface{803};
  Layers{Lt}; Recombine;
}

Physical Volume("treflector") = {7, 8, 9};
Physical Surface("wall1") += {1083, 911, 821};
Physical Surface("wall2") += {869, 1007, 1091};
Physical Surface("wall3") += {1087};
Physical Surface("ref_top") = {870, 1052, 1184};

