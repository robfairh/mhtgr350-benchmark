// defines a 2D geometry with 2 cooling channels and upper plenum
SetFactory("OpenCASCADE");

Rc = 0.794;
Rsc = 0.635;   // small coolant channel

h = 5/25;
L1 = 5;
L2 = L1 + 5;

Point(1) = {0, 0, 0, h};
Point(2) = {L1, 0, 0, h};
Point(3) = {L1, 1-Rsc, 0, h};
Point(4) = {L1, 1+Rsc, 0, h};
Point(5) = {L1, 3-Rsc, 0, h};
Point(6) = {L1, 3+Rsc, 0, h};

Point(7) = {L1, 4, 0, h};
Point(8) = {0, 4, 0, h};

Point(9) = {L2, 1-Rsc, 0, h};
Point(10) = {L2, 1+Rsc, 0, h};
Point(11) = {L2, 3-Rsc, 0, h};
Point(12) = {L2, 3+Rsc, 0, h};

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

Curve Loop(1) = {1, 2, 3, 11, -6, -5, 4, 12, -7, 8, 9, -10};
Plane Surface(1) = {1};

// Physical Curve("cool_in") = {10};
// Physical Curve("cool_out") = {11, 12};
// Physical Curve("plen_bot") = {1};
// Physical Curve("plen_top") = {9};
// Physical Curve("chan1_bot") = {3};
// Physical Curve("chan1_top") = {6};
// Physical Curve("chan2_bot") = {4};
// Physical Curve("chan2_top") = {7};
// Physical Curve("plen1") = {2};
// Physical Curve("plen2") = {5};
// Physical Curve("plen3") = {8};

Extrude {0, 0, 1} {
  Surface{1};
  Layers{4};
}

Physical Volume('coolant') = {1};

Physical Surface("cool_in") = {13};
Physical Surface("cool_out") = {9, 5};
Physical Surface("back") = {1};
Physical Surface("front") = {14};
Physical Surface("chan1_top") = {10};
Physical Surface("chan1_bot") = {8};
Physical Surface("chan2_top") = {6};
Physical Surface("chan2_bot") = {4};
Physical Surface("plen_bot") = {2};
Physical Surface("plen_top") = {12};
Physical Surface("plen1") = {11};
Physical Surface("plen2") = {7};
Physical Surface("plen3") = {3};
