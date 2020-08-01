// 1/6 of the 3D fuel assembly geometry
SetFactory("OpenCASCADE");

Rc = 0.794;
Rsc = 0.635;   // small coolant channel
dx = 0.2;      // coolant gap thickness
Rcg = Rc + dx; // coolant gap radius
Rf = 0.6225;
Rg = 0.635+0.2;

g = 1; // bypass flow gap

pi = 1.88;
fi = pi*Cos(Pi/6);

P = 18; // flat-to-flat distance/2
F = P/Cos(Pi/6)/2;

h = 1.0;

Hc = 10;
Lr = 2.0;
Lc = 200; // Axial layers in the core

// First column
x = 0; y = 0;
Point(1) = {x, y, 0, h};
x = P*Cos(Pi/6); y = P/2;
Point(2) = {x, y, 0, h};
x = F; y = P;
Point(3) = {x, y, 0, h};
x = 0; y = P;
Point(4) = {x, y, 0, h};

Line(1) = {1, 2};
Line(2) = {2, 3};
Line(3) = {3, 4};
Line(4) = {4, 1};

p = 5;
x = 0; y = P+g;
Point(p) = {x, y, 0, h}; p += 1;
x = F; y = P+g;
Point(p) = {x, y, 0, h}; p += 1;
x = 2*F; y = 2*P+g;
Point(p) = {x, y, 0, h}; p += 1;
x = F; y = 3*P+g;
Point(p) = {x, y, 0, h}; p += 1;
x = 0; y = 3*P+g;
Point(p) = {x, y, 0, h}; p += 1;

Line(5) = {5, 6};
Line(6) = {6, 7};
Line(7) = {7, 8};
Line(8) = {8, 9};
Line(9) = {9, 5};

x = 0; y = 3*P+2*g;
Point(p) = {x, y, 0, h}; p += 1;
x = F; y = 3*P+2*g;
Point(p) = {x, y, 0, h}; p += 1;
x = 2*F; y = 4*P+2*g;
Point(p) = {x, y, 0, h}; p += 1;
x = F; y = 5*P+2*g;
Point(p) = {x, y, 0, h}; p += 1;
x = 0; y = 5*P+2*g;
Point(p) = {x, y, 0, h}; p += 1;

Line(10) = {10, 11};
Line(11) = {11, 12};
Line(12) = {12, 13};
Line(13) = {13, 14};
Line(14) = {14, 10};

x = 0; y = 5*P+3*g;
Point(p) = {x, y, 0, h}; p += 1;
x = F; y = 5*P+3*g;
Point(p) = {x, y, 0, h}; p += 1;
x = 2*F; y = 6*P+3*g;
Point(p) = {x, y, 0, h}; p += 1;
x = F; y = 7*P+3*g;
Point(p) = {x, y, 0, h}; p += 1;
x = 0; y = 7*P+3*g;
Point(p) = {x, y, 0, h}; p += 1;

Line(15) = {15, 16};
Line(16) = {16, 17};
Line(17) = {17, 18};
Line(18) = {18, 19};
Line(19) = {19, 15};

x = 0; y = 7*P+4*g;
Point(p) = {x, y, 0, h}; p += 1;
x = F; y = 7*P+4*g;
Point(p) = {x, y, 0, h}; p += 1;
x = 2*F; y = 8*P+4*g;
Point(p) = {x, y, 0, h}; p += 1;
x = F; y = 9*P+4*g;
Point(p) = {x, y, 0, h}; p += 1;
x = 0; y = 9*P+4*g;
Point(p) = {x, y, 0, h}; p += 1;

Line(20) = {20, 21};
Line(21) = {21, 22};
Line(22) = {22, 23};
Line(23) = {23, 24};
Line(24) = {24, 20};

x = 0; y = 9*P+5*g;
Point(p) = {x, y, 0, h}; p += 1;
x = F; y = 9*P+5*g;
Point(p) = {x, y, 0, h}; p += 1;
x = 2*F; y = 10*P+5*g;
Point(p) = {x, y, 0, h}; p += 1;
x = F; y = 11*P+5*g;
Point(p) = {x, y, 0, h}; p += 1;
x = 0; y = 11*P+5*g;
Point(p) = {x, y, 0, h}; p += 1;

Line(25) = {25, 26};
Line(26) = {26, 27};
Line(27) = {27, 28};
Line(28) = {28, 29};
Line(29) = {29, 25};

x = 0; y = 11*P+6*g;
Point(p) = {x, y, 0, h}; p += 1;
x = F; y = 11*P+6*g;
Point(p) = {x, y, 0, h}; p += 1;
x = 2*F; y = 12*P+6*g;
Point(p) = {x, y, 0, h}; p += 1;
x = F; y = 13*P+6*g;
Point(p) = {x, y, 0, h}; p += 1;
x = 0; y = 13*P+6*g;
Point(p) = {x, y, 0, h}; p += 1;

Line(30) = {30, 31};
Line(31) = {31, 32};
Line(32) = {32, 33};
Line(33) = {33, 34};
Line(34) = {34, 30};

// Second column
x = (P+g)*Cos(Pi/6); y = (P+g)/2;
Point(p) = {x, y, 0, h}; p += 1;
x = (3*P+g)*Cos(Pi/6); y = (3*P+g)/2;
Point(p) = {x, y, 0, h}; p += 1;
xo = (2*P+g)*Cos(Pi/6);
yo = (2*P+g)/2;
x = xo + F; y = yo + P;
Point(p) = {x, y, 0, h}; p += 1;
x = xo - F; y = yo + P;
Point(p) = {x, y, 0, h}; p += 1;
x = xo - 2*F; y = yo;
Point(p) = {x, y, 0, h}; p += 1;

Line(35) = {35, 36};
Line(36) = {36, 37};
Line(37) = {37, 38};
Line(38) = {38, 39};
Line(39) = {39, 35};

x = xo - F; y = yo + P + g;
Point(p) = {x, y, 0, h}; p += 1;
x = xo + F; y = yo + P + g;
Point(p) = {x, y, 0, h}; p += 1;
x = xo + 2*F; y = yo + 2*P + g;
Point(p) = {x, y, 0, h}; p += 1;
x = xo + F; y = yo + 3*P + g;
Point(p) = {x, y, 0, h}; p += 1;
x = xo - F; y = yo + 3*P + g;
Point(p) = {x, y, 0, h}; p += 1;
x = xo - 2*F; y = yo + 2*P + g;
Point(p) = {x, y, 0, h}; p += 1;

Line(40) = {40, 41};
Line(41) = {41, 42};
Line(42) = {42, 43};
Line(43) = {43, 44};
Line(44) = {44, 45};
Line(45) = {45, 40};

x = xo - F; y = yo + 3*P + 2*g;
Point(p) = {x, y, 0, h}; p += 1;
x = xo + F; y = yo + 3*P + 2*g;
Point(p) = {x, y, 0, h}; p += 1;
x = xo + 2*F; y = yo + 4*P + 2*g;
Point(p) = {x, y, 0, h}; p += 1;
x = xo + F; y = yo + 5*P + 2*g;
Point(p) = {x, y, 0, h}; p += 1;
x = xo - F; y = yo + 5*P + 2*g;
Point(p) = {x, y, 0, h}; p += 1;
x = xo - 2*F; y = yo + 4*P + 2*g;
Point(p) = {x, y, 0, h}; p += 1;

Line(46) = {46, 47};
Line(47) = {47, 48};
Line(48) = {48, 49};
Line(49) = {49, 50};
Line(50) = {50, 51};
Line(51) = {51, 46};