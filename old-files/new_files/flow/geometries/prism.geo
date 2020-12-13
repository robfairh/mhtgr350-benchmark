h = 0.1;
//+
Point(1) = {0, 0, 0, h};
//+
Point(2) = {0, 1, 0, h};
//+
Point(3) = {1, 1, 0, h};
//+
Point(4) = {1, 0, 0, h};
//+
Line(1) = {1, 4};
//+
Line(2) = {4, 3};
//+
Line(3) = {3, 2};
//+
Line(4) = {2, 1};
//+
Curve Loop(1) = {1, 2, 3, 4};
//+
Plane Surface(1) = {1};
//+
Lc = 8;
Extrude {0, 0, 1} {
  Surface{1}; Layers{Lc}; 
}
Extrude {0, 0, 1} {
  Surface{26}; Layers{Lc}; 
}
Extrude {0, 0, 1} {
  Surface{48}; Layers{Lc}; 
}
Extrude {0, 0, 1} {
  Surface{70}; Layers{Lc}; 
}
Extrude {0, 0, 1} {
  Surface{92}; Layers{Lc}; 
}

//+
Physical Surface("front") = {114};
//+
Physical Surface("back") = {1};
//+
Physical Surface("left") = {25, 47, 69, 91, 113};
//+
Physical Surface("right") = {105, 83, 61, 39, 17};
//+
Physical Surface("bottom") = {13, 35, 57, 79, 101};
//+
Physical Surface("top") = {109, 87, 65, 43, 21};
//+
Physical Surface("L4") = {26};
//+
Physical Surface("L3") = {48};
//+
Physical Surface("L2") = {70};
//+ closer to the front
Physical Surface("L1") = {92};
//+
Physical Volume("cool") = {1, 2, 3, 4, 5};
