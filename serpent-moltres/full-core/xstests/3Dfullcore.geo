// Gmsh geometry
Geometry.CopyMeshingMethod = 1;

Hb = 160;
Hf = 79.3;
Hc = 793;
Ht = 120;

P = 36.0;  // flat-to-flat distance
F = P/2/Cos(Pi/6);
h = 40;

Lb = 20;
Lc = 100;
Lt = 40;

p = 1; l = 1; s = 1;

////////////////////////
//                    //
//        FUEL        //
//                    //
////////////////////////
// 1: on the left wall
x0 = 0; y0 = 3*P;
x = x0; y = y0 - P/2;
Point(p) = {x, y, 0, h}; p += 1;
x = x0 + F/2; y = y0 - P/2;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;
x = x0 + F; y = y0;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;
x = x0 + F/2; y = y0 + P/2;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;
x = x0; y = y0 + P/2;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;
Line(l) = {p-1, p-5}; l += 1;
Curve Loop(s) = {l-5, l-4, l-3, l-2, l-1};
Plane Surface(s) = {s}; s += 1;

// 2: inner domain
x0 = F + F/2; y0 = 2*P + P/2;
x = x0 - F/2; y = y0 - P/2;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-5, p-1}; l += 1;
x = x0 + F/2; y = y0 - P/2;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;
x = x0 + F; y = y0;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;
x = x0 + F/2; y = y0 + P/2;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;
Line(l) = {p-1, p-7}; l += 1;
Curve Loop(s) = {l-1, l-2, l-3, l-4, l-5, -(l-9)};
Plane Surface(s) = {s}; s += 1;

// 3: inner domain
x0 = 2*(F + F/2); y0 = 2*P;
x = x0 - F/2; y = y0 - P/2;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-4, p-1}; l += 1;
x = x0 + F/2; y = y0 - P/2;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;
x = x0 + F; y = y0;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;
x = x0 + F/2; y = y0 + P/2;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;
Line(l) = {p-1, p-6}; l += 1;
Curve Loop(s) = {l-1, l-2, l-3, l-4, l-5, -(l-8)};
Plane Surface(s) = {s}; s += 1;

// 4: inner domain
x0 = 3*(F + F/2); y0 = P + P/2;
x = x0 - F/2; y = y0 - P/2;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-4, p-1}; l += 1;
x = x0 + F/2; y = y0 - P/2;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;
x = x0 + F; y = y0;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;
x = x0 + F/2; y = y0 + P/2;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;
Line(l) = {p-1, p-6}; l += 1;
Curve Loop(s) = {l-1, l-2, l-3, l-4, l-5, -(l-8)};
Plane Surface(s) = {s}; s += 1;

// 5: inner domain
x0 = 3*(F + F/2); y0 = P/2;
x = x0 - F; y = y0;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-5, p-1}; l += 1;
x = x0 - F/2; y = y0 - P/2;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;
x = x0 + F/2; y = y0 - P/2;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;
x = x0 + F; y = y0;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;
Line(l) = {p-1, p-7}; l += 1;
Curve Loop(s) = {l-1, l-2, l-3, l-4, l-5, -(l-9)};
Plane Surface(s) = {s}; s += 1;

// 6: inner domain
x0 = 3*(F + F/2); y0 = -P/2;
x = x0 - F; y = y0;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-4, p-1}; l += 1;
x = x0 - F/2; y = y0 - P/2;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;
x = x0 + F/2; y = y0 - P/2;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;
x = x0 + F; y = y0;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;
Line(l) = {p-1, p-6}; l += 1;
Curve Loop(s) = {l-1, l-2, l-3, l-4, l-5, -(l-8)};
Plane Surface(s) = {s}; s += 1;

// 1: on the right wall
x0 = 3*(F + F/2); y0 = -P - P/2;
x = x0 - P/2*Cos(Pi/6); y = y0 + P/4;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-4, p-1}; l += 1;
x = x0 + P/2*Cos(Pi/6); y = y0 - P/4;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;
x = x0 + F; y = y0;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;
Line(l) = {p-1, p-5}; l += 1;
Curve Loop(s) = {l-1, l-2, l-3, l-4, -(l-7)};
Plane Surface(s) = {s}; s += 1;

// 7: on the left wall
x0 = 0; y0 = 4*P;
x = x0 + F; y = y0;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {4, p-1}; l += 1;
x = x0 + F/2; y = y0 + P/2;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;
x = x0; y = y0 + P/2;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;
Line(l) = {p-1, 5}; l += 1;
Curve Loop(s) = {l-1, l-2, l-3, l-4, -4};
Plane Surface(s) = {s}; s += 1;

// 8: inner domain
x0 = F + F/2; y0 = 3*P + P/2;
x = x0 + F; y = y0;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {9, p-1}; l += 1;
x = x0 + F/2; y = y0 + P/2;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;
Line(l) = {p-1, 29}; l += 1;
Curve Loop(s) = {l-1, l-2, l-3, -(l-7), -3, -10};
Plane Surface(s) = {s}; s += 1;

// 9: inner domain
x0 = 2*(F + F/2); y0 = 3*P;
x = x0 + F; y = y0;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {13, p-1}; l += 1;
x = x0 + F/2; y = y0 + P/2;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;
Line(l) = {p-1, 32}; l += 1;
Curve Loop(s) = {l-1, l-2, l-3, -(l-6), -9, -15};
Plane Surface(s) = {s}; s += 1;

// 10: inner domain
x0 = 3*(F + F/2); y0 = 2*P + P/2;
x = x0 + F; y = y0;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {17, p-1}; l += 1;
x = x0 + F/2; y = y0 + P/2;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;
Line(l) = {p-1, 34}; l += 1;
Curve Loop(s) = {l-1, l-2, l-3, -(l-6), -14, -20};
Plane Surface(s) = {s}; s += 1;

// 11: inner domain
x0 = 4*(F + F/2); y0 = 2*P;
x = x0 + F/2; y = y0 - P/2;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {16, p-1}; l += 1;
x = x0 + F; y = y0;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;
x = x0 + F/2; y = y0 + P/2;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;
Line(l) = {p-1, 36}; l += 1;
Curve Loop(s) = {l-1, l-2, l-3, l-4, -(l-7), -19};
Plane Surface(s) = {s}; s += 1;

// 12: inner domain
x0 = 4*(F + F/2); y0 = P;
x = x0 + F/2; y = y0 - P/2;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {21, p-1}; l += 1;
x = x0 + F; y = y0;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;
Line(l) = {p-1, 38}; l += 1;
Curve Loop(s) = {l-1, l-2, l-3, -(l-7), -18, -25};
Plane Surface(s) = {s}; s += 1;

// 13: inner domain
x0 = 4*(F + F/2); y0 = 0;
x = x0 + F/2; y = y0 - P/2;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {25, p-1}; l += 1;
x = x0 + F; y = y0;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;
Line(l) = {p-1, 41}; l += 1;
Curve Loop(s) = {l-1, l-2, l-3, -(l-6), -24, -30};
Plane Surface(s) = {s}; s += 1;

// 14: inner domain
x0 = 4*(F + F/2); y0 = -P;
x = x0 + F/2; y = y0 - P/2;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {28, p-1}; l += 1;
x = x0 + F; y = y0;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;
Line(l) = {p-1, 43}; l += 1;
Curve Loop(s) = {l-1, l-2, l-3, -(l-6), -29, -34};
Plane Surface(s) = {s}; s += 1;

// 7: on the right wall
x0 = 4*(F + F/2); y0 = -2*P;
x = x0 + P/2*Cos(Pi/6); y = y0 - P/4;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {27, p-1}; l += 1;
x = x0 + F; y = y0;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;
Line(l) = {p-1, 45}; l += 1;
Curve Loop(s) = {l-1, l-2, l-3, -(l-6), -33};
Plane Surface(s) = {s}; s += 1;

// 15: inner domain
x0 = F + F/2; y0 = 4*P + P/2;
x = x0 + F; y = y0;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {33, p-1}; l += 1;
x = x0 + F/2; y = y0 + P/2;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;
x = x0 - F/2; y = y0 + P/2;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;
Line(l) = {p-1, 30}; l += 1;
Curve Loop(s) = {l-1, l-2, l-3, l-4, -41, -36};
Plane Surface(s) = {s}; s += 1;

// 16: inner domain
x0 = 2*(F + F/2); y0 = 4*P;
x = x0 + F; y = y0;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {35, p-1}; l += 1;
x = x0 + F/2; y = y0 + P/2;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;
Line(l) = {p-1, 49}; l += 1;
Curve Loop(s) = {l-1, l-2, l-3, -40, -44, -64};
Plane Surface(s) = {s}; s += 1;

// 17: inner domain
x0 = 3*(F + F/2); y0 = 4*P - P/2;
x = x0 + F; y = y0;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {37, p-1}; l += 1;
x = x0 + F/2; y = y0 + P/2;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;
Line(l) = {p-1, 52}; l += 1;
Curve Loop(s) = {l-1, l-2, l-3, -43, -47, -68};
Plane Surface(s) = {s}; s += 1;

// 18: inner domain
x0 = 4*(F + F/2); y0 = 4*P - 2*P/2;
x = x0 + F; y = y0;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {40, p-1}; l += 1;
x = x0 + F/2; y = y0 + P/2;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;
Line(l) = {p-1, 54}; l += 1;
Curve Loop(s) = {l-1, l-2, l-3, -46, -51, -71};
Plane Surface(s) = {s}; s += 1;

// 19: inner domain
x0 = 5*(F + F/2); y0 = 1*P + P/2;
x = x0 + F/2; y = y0 - P/2;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {42, p-1}; l += 1;
x = x0 + F; y = y0;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;
x = x0 + F/2; y = y0 + P/2;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;
Line(l) = {p-1, 39}; l += 1;
Curve Loop(s) = {l-1, l-2, l-3, l-4, -49, -54};
Plane Surface(s) = {s}; s += 1;

// 20: inner domain
x0 = 5*(F + F/2); y0 = P/2;
x = x0 + F/2; y = y0 - P/2;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {44, p-1}; l += 1;
x = x0 + F; y = y0;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;
Line(l) = {p-1, 58}; l += 1;
Curve Loop(s) = {l-1, l-2, l-3, -53, -57, -77};
Plane Surface(s) = {s}; s += 1;

// 21: inner domain
x0 = 5*(F + F/2); y0 = - P/2;
x = x0 + F/2; y = y0 - P/2;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {46, p-1}; l += 1;
x = x0 + F; y = y0;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;
Line(l) = {p-1, p-4}; l += 1;
Curve Loop(s) = {l-1, l-2, l-3, -56, -60, -(l-6)};
Plane Surface(s) = {s}; s += 1;

// 22: inner domain
x0 = 5*(F + F/2); y0 = -P - P/2;
x = x0 + F/2; y = y0 - P/2;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {48, p-1}; l += 1;
x = x0 + F; y = y0;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;
Line(l) = {p-1, p-4}; l += 1;
Curve Loop(s) = {l-1, l-2, l-3, -59, -63, -(l-6)};
Plane Surface(s) = {s}; s += 1;

////////////////////////
//                    //
//  INNER REFLECTOR   //
//                    //
////////////////////////
x = 0; y = 0;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-1, 1}; l += 1;
Line(l) = {p-1, 26}; l += 1;

Curve Loop(s) = {90, 1, 6, 7, 11, 12, 16, 21, 22, 26, 27, 31, -91};
Plane Surface(s) = {s}; s += 1;

////////////////////////
//                    //
// OUTER REFLECTOR 1  //
//                    //
////////////////////////
x0 = 0; y0 = 6*P;
x = x0; y = y0 + P/2;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {31, p-1}; l += 1;
x = x0 + F/2; y = y0 + P/2;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;

x0 = 1*(F + F/2); y0 = 6*P + P/2;
x = x0 - F/2; y = y0 + P/2;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;
x = x0 + F/2; y = y0 + P/2;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;

x0 = 2*(F + F/2); y0 = 6*P;
x = x0 - F/2; y = y0 + P/2;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;
x = x0 + F/2; y = y0 + P/2;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;

x0 = 3*(F + F/2); y0 = 6*P - 1*P/2;
x = x0 - F/2; y = y0 + P/2;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;
x = x0 + F/2; y = y0 + P/2;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;

x0 = 4*(F + F/2); y0 = 6*P - 2*P/2;
x = x0 - F/2; y = y0 + P/2;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;
x = x0 + F/2; y = y0 + P/2;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;

x0 = 5*(F + F/2); y0 = 6*P - 3*P/2;
x = x0 - F/2; y = y0 + P/2;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;
x = x0 + F/2; y = y0 + P/2;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;

x0 = 6*(F + F/2); y0 = 6*P - 4*P/2;
x = x0 - F/2; y = y0 + P/2;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;
x = x0 + F/2; y = y0 + P/2;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;
x = x0 + F; y = y0;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;
x = x0 + F/2; y = y0 - P/2;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;

x0 = 6*(F + F/2); y0 = 3*P;
x = x0 + F; y = y0;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;

x0 = 7*(F + F/2); y0 = 3*P - P/2;
x = x0 + F/2; y = y0 + P/2;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;
x = x0 + F; y = y0;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;
x = x0 + F/2; y = y0 - P/2;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;

x0 = 7*(F + F/2); y0 = 2*P - P/2;
x = x0 + F; y = y0;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;
x = x0 + F/2; y = y0 - P/2;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;

x0 = 7*(F + F/2); y0 = 1*P - P/2;
x = x0 + F; y = y0;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;
x = x0 + F/2; y = y0 - P/2;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;

x0 = 7*(F + F/2); y0 = - P/2;
x = x0 + F; y = y0;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;
x = x0 + F/2; y = y0 - P/2;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;

x0 = 7*(F + F/2); y0 = -1*P - P/2;
x = x0 + F; y = y0;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;
x = x0 + F/2; y = y0 - P/2;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;

x0 = 7*(F + F/2); y0 = -2*P - P/2;
x = x0 + F; y = y0;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;
x = x0 + F/2; y = y0 - P/2;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;
x = x0 - F/2; y = y0 - P/2;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;

x0 = 6*(F + F/2); y0 = -2*P - 2*P/2;
x = x0 + P/2*Cos(Pi/6); y = y0 - P/4;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-2, p-1}; l += 1;
Line(l) = {p-1, 47}; l += 1;

Curve Loop(s) = {92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 62, 87, 88, 89, 85, 86, 82, 83, 78, 79, 80, 50, 74, 75, 76, 72, 73, 69, 70, 65, 66, 67, 37};
Plane Surface(s) = {s}; s += 1;

////////////////////////
//                    //
// OUTER REFLECTOR 2  //
//                    //
////////////////////////

OR = 300;
x = 0; y = OR;
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {68, p-1}; l += 1;

x = OR*Cos(Pi/6); y = -OR*Sin(Pi/6);
Point(p) = {x, y, 0, h}; p += 1;
Line(l) = {p-1, 99}; l += 1;

Circle(l) = {100, 67, 101}; l += 1;
Curve Loop(s) = {125, 127, 126, -123, -122, -121, -120, -119, -118, -117, -116, -115, -114, -113, -112, -111, -110, -109, -108, -107, -106, -105, -104, -103, -102, -101, -100, -99, -98, -97, -96, -95, -94, -93};
Plane Surface(s) = {s}; s += 1;

////////////////////////
//                    //
//     EXTRUSION      //
//                    //
////////////////////////

Extrude {0, 0, -Hb} {
   Surface{1};  Surface{2};  Surface{3};  Surface{4};  Surface{5};
   Surface{6};  Surface{7};  Surface{8};  Surface{9}; Surface{10};
  Surface{11}; Surface{12}; Surface{13}; Surface{14}; Surface{15};
  Surface{16}; Surface{17}; Surface{18}; Surface{19}; Surface{20};
  Surface{21}; Surface{22}; Surface{23}; Surface{24}; Surface{25};
  Surface{26}; Surface{27};
  Layers{Lb}; Recombine;
}

Physical Surface("ref_bot") = {
  154, 186, 218, 250, 282, 314, 341, 368, 400, 432,
  464, 496, 528, 560, 592, 619, 651, 683, 715, 747,
  779, 811, 843, 875, 942, 1224, 1396
};

Physical Volume("breflector") = {
   1,  2,  3,  4,  5,  6,  7,  8,  9, 10,
  11, 12, 13, 14, 15, 16, 17, 18, 19, 20,
  21, 22, 23, 24, 25, 26, 27
};

Extrude {0, 0, Hc} {
   Surface{1};  Surface{2};  Surface{3};  Surface{4};  Surface{5};
   Surface{6};  Surface{7};  Surface{8};  Surface{9}; Surface{10};
  Surface{11}; Surface{12}; Surface{13}; Surface{14}; Surface{15};
  Surface{16}; Surface{17}; Surface{18}; Surface{19}; Surface{20};
  Surface{21}; Surface{22}; Surface{23}; Surface{24}; Surface{25};
  Surface{26}; Surface{27};
  Layers{Lc}; Recombine;
}

Physical Volume("fuel") = {
  28, 29, 30, 31, 32, 33, 34, 35, 36, 37,
  38, 39, 40, 41, 42, 43, 44, 45, 46, 47,
  48, 49, 50, 51
};

Physical Volume("ireflector") = {52};
Physical Volume("oreflector") = {53, 54};

// Another way (maybe) I haven't checked continuity
// Translate {0, 0, Hf} {
//   Duplicata { 
//      Volume{1};  Volume{2};  Volume{3};  Volume{4};  Volume{5};
//      Volume{6};  Volume{7};  Volume{8};  Volume{9}; Volume{10};
//     Volume{11}; Volume{12}; Volume{13}; Volume{14}; Volume{15};
//     Volume{16}; Volume{17}; Volume{18}; Volume{19}; Volume{20};
//     Volume{21}; Volume{22}; Volume{23}; Volume{24}; Volume{25};
//     Volume{26}; Volume{27};
//   }
// }

Extrude {0, 0, Ht} {
  Surface{1423}; Surface{1455}; Surface{1487}; Surface{1519}; Surface{1551};
  Surface{1583}; Surface{1610}; Surface{1637}; Surface{1669}; Surface{1701};
  Surface{1733}; Surface{1765}; Surface{1797}; Surface{1829}; Surface{1861};
  Surface{1888}; Surface{1920}; Surface{1952}; Surface{1984}; Surface{2016};
  Surface{2048}; Surface{2080}; Surface{2112}; Surface{2144}; Surface{2211};
  Surface{2493}; Surface{2665};
  Layers{Lt}; Recombine;
}

Physical Volume("treflector") = {
  55, 56, 57, 58, 59, 60, 61, 62, 63, 64,
  65, 66, 67, 68, 69, 70, 71, 72, 73, 74,
  75, 76, 77, 78, 79, 80, 81
};

Physical Surface("ref_top") = {
  2692, 2724, 2756, 2788, 2820, 2852, 2879, 2906, 2938, 2970,
  3002, 3034, 3066, 3098, 3130, 3157, 3189, 3221, 3253, 3285,
  3317, 3349, 3381, 3413, 3480, 3762, 3934
};

Physical Surface("wall3") = {1267, 2536, 3805};