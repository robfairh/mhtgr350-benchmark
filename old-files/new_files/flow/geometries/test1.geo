// defines a 2D geometry with 2 cooling channels and upper plenum
SetFactory("OpenCASCADE");

Rc = 0.794;
Rsc = 0.635;   // small coolant channel

h = 5/30;
h2 = 5/50;
L1 = 5;
L2 = L1 + 5;

Point(1) = {0, 0, 0, h};
Point(2) = {L1, 0, 0, h};
Point(3) = {L1, 1-Rsc, 0, h2};
Point(4) = {L1, 1+Rsc, 0, h2};
Point(5) = {L1, 3-Rsc, 0, h2};
Point(6) = {L1, 3+Rsc, 0, h2};

Point(7) = {L1, 4, 0, h};
Point(8) = {0, 4, 0, h};

Point(9) = {L2, 1-Rsc, 0, h2};
Point(10) = {L2, 1+Rsc, 0, h2};
Point(11) = {L2, 3-Rsc, 0, h2};
Point(12) = {L2, 3+Rsc, 0, h2};

Line(1) = {1, 2};
Line(2) = {2, 3};
Line(3) = {3, 9};
Line(4) = {5, 11};
Line(5) = {5, 4};
Line(6) = {4, 10};
Line(7) = {6, 12};
Line(8) = {6, 7};
Line(9) = {7, 8};
Line(10) = {1, 8};
Line(11) = {9, 10};
Line(12) = {11, 12};
Line(13) = {5, 6};
Line(14) = {3, 4};

Curve Loop(1) = {1, 2, 14, -5, 13, 8, 9, -10};
Plane Surface(1) = {1};
Curve Loop(2) = {3, 11, -6, -14};
Plane Surface(2) = {2};
Curve Loop(3) = {13, 7, -12, -4};
Plane Surface(3) = {3};
Physical Surface("coolant") = {1, 2, 3};

Physical Curve("cool_in") = {10};
Physical Curve("plen_bot") = {1};
Physical Curve("plen_top") = {9};
Physical Curve("plen1") = {2};
Physical Curve("plen2") = {5};
Physical Curve("plen3") = {8};
Physical Curve("chan1_bot") = {3};
Physical Curve("chan1_top") = {6};
Physical Curve("chan2_bot") = {4};
Physical Curve("chan2_top") = {7};
Physical Curve("chan1_in") = {14};
Physical Curve("chan1_out") = {11};
Physical Curve("chan2_in") = {13};
Physical Curve("chan2_out") = {12};
