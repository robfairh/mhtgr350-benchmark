// OLD BENCHMARK GEOMETRY
Geometry.CopyMeshingMethod = 1;

Hb = 160;  // Bottom reflector height
Hf = 79.3;  // Fuel assembly height
Ht = 120;  // Top reflector height

Lb = 30;  // Number of axial layers in bottom reflector
Lf = 10;  // Number of axial layers in each fuel assembly
Lt = 30;  // Number of axial layers in top reflector

F = 18.0;  // Half of flat-to-flat distance
A = F/Cos(Pi/6);
h = 20;

// 1
p = 1;
Point(p) = {0, 0, 0, h}; p += 1;
Point(p) = {0, F, 0, h}; p += 1;

x = F*Cos(Pi/6); y = -F/2;
Point(p) = {x, y, 0, h}; p += 1;
x = A/2; y = F;
Point(p) = {x, y, 0, h}; p += 1;
x = A; y = 0;
Point(p) = {x, y, 0, h}; p += 1;

l = 1;
Line(l) = {1, 2}; l += 1;
Line(l) = {2, 4}; l += 1;
Line(l) = {4, 5}; l += 1;
Line(l) = {5, 3}; l += 1;
Line(l) = {3, 1}; l += 1;

Curve Loop(1) = {5, 1, 2, 3, 4};
Plane Surface(1) = {1};

// 2 - first half
x = 0; y = F + 1*2*F;
Point(p) = {x, y, 0, h}; p += 1;
x = A/2;
Point(p) = {x, y, 0, h}; p += 1;
x = A; y = 1*2*F;
Point(p) = {x, y, 0, h}; p += 1;

Line(l) = {2, 6}; l += 1;
Line(l) = {6, 7}; l += 1;
Line(l) = {7, 8}; l += 1;
Line(l) = {8, 4}; l += 1;

Curve Loop(2) = {6, 7, 8, 9, -2};
Plane Surface(2) = {2};

// 4, 8, 14, 22, 32, 44, 58, 74 - first half
For index In {1:8}
  Translate {0, index*2*F, 0} {
    Duplicata { Surface{2}; }
  }
EndFor

// 2 - 2nd half
p = 89;
x = A + A;
Point(p) = {x, 0, 0, h}; p += 1;
x = A + A - A/2 + A; y = -F;
Point(p) = {x, y, 0, h}; p += 1;
x = A + A - A/2 + A; y = -F;
Point(p) = {x, y, 0, h}; p += 1;
x = A + A - A/2 + F*Cos(Pi/6); y = -F/2 - F;
Point(p) = {x, y, 0, h}; p += 1;

Line(50) = {5, 89};
Line(51) = {89, 90};
Line(52) = {90, 92};
Line(53) = {92, 3};

Curve Loop(3) = {4, -53, -52, -51, -50};
Plane Surface(46) = {3};

// 5
x = A + A; y = 2*F;
Point(p) = {x, y, 0, h}; p += 1;
x = A + A - A/2 + A; y = -F + 2*F;
Point(p) = {x, y, 0, h}; p += 1;

l = 54;
Line(l) = {8, 93}; l += 1;
Line(l) = {93, 94}; l += 1;
Line(l) = {94, 89}; l += 1;

Curve Loop(4) = {54, 55, 56, -50, -3, -9};
Plane Surface(47) = {4};

// 5, 9, 15, 23, 33, 45, 59, 75
For index In {1:8}
  Translate {0, index*2*F, 0} {
    Duplicata { Surface{47}; }
  }
EndFor

For index In {1:8}
Translate { index*(A+A/2), -index*F, 0} {
  Duplicata {
    Surface{46};  Surface{47};  Surface{57};  Surface{61};
  Surface{65};  Surface{69};  Surface{73};  Surface{77};
  Surface{81};  Surface{85};
  }
}
EndFor

Physical Surface("ref_bot") = {
  1, 2, 10, 15, 20, 25, 30, 35, 40, 45,
  46, 47, 57, 61, 65, 69, 73, 77, 81, 85,
  89, 95, 102, 109, 116, 123, 130, 137, 144, 151,
  155, 161, 168, 175, 182, 189, 196, 203, 210, 217,
  221, 227, 234, 241, 248, 255, 262, 269, 276, 283,
  287, 293, 300, 307, 314, 321, 328, 335, 342, 349,
  353, 359, 366, 373, 380, 387, 394, 401, 408, 415,
  419, 425, 432, 439, 446, 453, 460, 467, 474, 481,
  485, 491, 498, 505, 512, 519, 526, 533, 540, 547,
  551, 557, 564, 571, 578, 585, 592, 599, 606, 613
};

// Goes from 2D to 3D
Extrude {0, 0, Hb} {
  Surface{1}; Surface{2}; Surface{10}; Surface{15};  Surface{20};
  Surface{25}; Surface{30}; Surface{35}; Surface{40}; Surface{45};
  Surface{46}; Surface{47}; Surface{57}; Surface{61}; Surface{65};
  Surface{69}; Surface{73}; Surface{77}; Surface{81}; Surface{85};
  Surface{89}; Surface{95}; Surface{102}; Surface{109}; Surface{116};
  Surface{123}; Surface{130}; Surface{137}; Surface{144}; Surface{151};
  Surface{155}; Surface{161}; Surface{168}; Surface{175}; Surface{182};
  Surface{189}; Surface{196}; Surface{203}; Surface{210}; Surface{217};
  Surface{221}; Surface{227}; Surface{234}; Surface{241}; Surface{248};
  Surface{255}; Surface{262}; Surface{269}; Surface{276}; Surface{283};
  Surface{287}; Surface{293}; Surface{300}; Surface{307}; Surface{314};
  Surface{321}; Surface{328}; Surface{335}; Surface{342}; Surface{349};
  Surface{353}; Surface{359}; Surface{366}; Surface{373}; Surface{380};
  Surface{387}; Surface{394}; Surface{401}; Surface{408}; Surface{415};
  Surface{419}; Surface{425}; Surface{432}; Surface{439}; Surface{446};
  Surface{453}; Surface{460}; Surface{467}; Surface{474}; Surface{481};
  Surface{485}; Surface{491}; Surface{498}; Surface{505}; Surface{512};
  Surface{519}; Surface{526}; Surface{533}; Surface{540}; Surface{547};
  Surface{551}; Surface{557}; Surface{564}; Surface{571}; Surface{578};
  Surface{585}; Surface{592}; Surface{599}; Surface{606}; Surface{613}; 
  Layers{Lb}; Recombine;
}

Physical Volume("M221") = {1, 2, 11, 12, 3, 21, 13, 23, 22};
Physical Volume("M222") = {
  4, 31, 14, 24, 34, 33, 32, 5, 41, 15,
  25, 35, 45, 44, 43, 42, 16, 26, 36, 46,
  55, 54, 53, 52
};
Physical Volume("M223") = {
  6, 17, 27, 37, 47, 57, 56, 7, 51,
  18, 28, 38, 48, 58, 68, 66, 65, 64, 63,
  62, 67, 77, 76, 75, 74, 73, 72, 61
};
Physical Volume("M224") = {
  8, 19, 29, 39, 49, 59, 69, 79, 78, 88,
  87, 86, 85, 84, 83, 82, 71, 9, 20, 30,
  40, 50, 60, 70, 80, 90, 89, 99, 98, 97,
  96, 95, 94, 93, 92, 81, 10, 100, 91
};

Physical Surface("wall1") = {
  630, 653, 680, 707, 734, 761, 788, 815, 842, 869
};

Physical Surface("wall2") = {
  3420, 3105, 2790, 2475, 2160, 1845, 1530, 1215, 900, 626
};

Physical Surface("outerwall") = {
  873, 877, 1180, 1184, 1495, 1499, 1810, 1814, 2125, 2129,
  2440, 2444, 2755, 2759, 3070, 3074, 3385, 3389, 3424, 3428
};

Physical Surface("outerwall") += {
  3448, 3452, 3480, 3484, 3512, 3516, 3544, 3548, 3576, 3580,
  3608, 3612, 3640, 3644, 3672, 3676, 3700, 3704, 3708
};


Extrude {0, 0, Hf} {
  Surface{643}; Surface{670}; Surface{697}; Surface{724}; Surface{751};
  Surface{778}; Surface{805}; Surface{832}; Surface{859}; Surface{886};
  Surface{913}; Surface{945}; Surface{977}; Surface{1009}; Surface{1041};
  Surface{1073}; Surface{1105}; Surface{1137}; Surface{1169}; Surface{1201};
  Surface{1228}; Surface{1260}; Surface{1292}; Surface{1324}; Surface{1356};
  Surface{1388}; Surface{1420}; Surface{1452}; Surface{1484}; Surface{1516};
  Surface{1543}; Surface{1575}; Surface{1607}; Surface{1639}; Surface{1671};
  Surface{1703}; Surface{1735}; Surface{1767}; Surface{1799}; Surface{1831};
  Surface{1858}; Surface{1890}; Surface{1922}; Surface{1954}; Surface{1986};
  Surface{2018}; Surface{2050}; Surface{2082}; Surface{2114}; Surface{2146};
  Surface{2173}; Surface{2205}; Surface{2237}; Surface{2269}; Surface{2301};
  Surface{2333}; Surface{2365}; Surface{2397}; Surface{2429}; Surface{2461};
  Surface{2488}; Surface{2520}; Surface{2552}; Surface{2584}; Surface{2616};
  Surface{2648}; Surface{2680}; Surface{2712}; Surface{2744}; Surface{2776};
  Surface{2803}; Surface{2835}; Surface{2867}; Surface{2899}; Surface{2931};
  Surface{2963}; Surface{2995}; Surface{3027}; Surface{3059}; Surface{3091};
  Surface{3118}; Surface{3150}; Surface{3182}; Surface{3214}; Surface{3246};
  Surface{3278}; Surface{3310}; Surface{3342}; Surface{3374}; Surface{3406};
  Surface{3433}; Surface{3465}; Surface{3497}; Surface{3529}; Surface{3561};
  Surface{3593}; Surface{3625}; Surface{3657}; Surface{3689}; Surface{3721};
  Layers{Lf}; Recombine;
}

Physical Volume("M225") = {101, 102, 112, 111, 103, 113, 123, 122, 121};

Physical Volume("M1") = {104, 131};
Physical Volume("M2") = {114};
Physical Volume("M3") = {124};
Physical Volume("M4") = {134};
Physical Volume("M5") = {133};
Physical Volume("M6") = {132};

Physical Volume("M7") = {105, 141};
Physical Volume("M8") = {115};
Physical Volume("M9") = {125};
Physical Volume("M10") = {135};
Physical Volume("M11") = {145};
Physical Volume("M12") = {144};
Physical Volume("M13") = {143};
Physical Volume("M14") = {142};

Physical Volume("M15") = {116};
Physical Volume("M16") = {126};
Physical Volume("M17") = {136};
Physical Volume("M18") = {146};
Physical Volume("M19") = {155};
Physical Volume("M20") = {154};
Physical Volume("M21") = {153};
Physical Volume("M22") = {152};

Physical Volume("M226") = {
  106, 107, 117, 118, 127, 128, 137, 147, 148, 138,
  157, 158, 156, 167, 166, 177, 168, 165, 164, 175,
  163, 174, 176, 162, 173, 172, 151, 161
};

Physical Volume("M227") = {
  108, 119, 129, 139, 149, 159, 169, 179, 178, 188,
  187, 186, 184, 185, 183, 182, 181, 171, 109, 110,
  120, 130, 140, 150, 160, 170, 180, 190, 189, 200,
  199, 198, 197, 196, 195, 194, 193, 192, 191
};

Physical Surface("wall1") += {
  3735, 3758, 3785, 3812, 3839, 3866, 3893, 3920, 3947, 3974
};

Physical Surface("wall2") += {
  3731, 4005, 4320, 4635, 4950, 5265, 5580, 5895, 6210, 6525
};

Physical Surface("outerwall") += {
  3978, 3982, 4285, 4289, 4600, 4604, 4915, 4919, 5230, 5234,
  5545, 5549, 5860, 5864, 6175, 6179, 6490, 6494, 6805, 6809
};

Physical Surface("outerwall") += {
  6529, 6533, 6557, 6553, 6589, 6585, 6621, 6617, 6653, 6649,
  6685, 6681, 6717, 6713, 6749, 6745, 6781, 6777, 6813
};

Extrude {0, 0, Hf} {
  Surface{3748}; Surface{3775}; Surface{3802}; Surface{3829}; Surface{3856};
  Surface{3883}; Surface{3910}; Surface{3937}; Surface{3964}; Surface{3991};
  Surface{4018}; Surface{4050}; Surface{4082}; Surface{4114}; Surface{4146};
  Surface{4178}; Surface{4210}; Surface{4242}; Surface{4274}; Surface{4306};
  Surface{4333}; Surface{4365}; Surface{4397}; Surface{4429}; Surface{4461};
  Surface{4493}; Surface{4525}; Surface{4557}; Surface{4589}; Surface{4621};
  Surface{4648}; Surface{4680}; Surface{4712}; Surface{4744}; Surface{4776};
  Surface{4808}; Surface{4840}; Surface{4872}; Surface{4904}; Surface{4936};
  Surface{4963}; Surface{4995}; Surface{5027}; Surface{5059}; Surface{5091};
  Surface{5123}; Surface{5155}; Surface{5187}; Surface{5219}; Surface{5251};
  Surface{5278}; Surface{5310}; Surface{5342}; Surface{5374}; Surface{5406};
  Surface{5438}; Surface{5470}; Surface{5502}; Surface{5534}; Surface{5566};
  Surface{5593}; Surface{5625}; Surface{5657}; Surface{5689}; Surface{5721};
  Surface{5753}; Surface{5785}; Surface{5817}; Surface{5849}; Surface{5881};
  Surface{5908}; Surface{5940}; Surface{5972}; Surface{6004}; Surface{6036};
  Surface{6068}; Surface{6100}; Surface{6132}; Surface{6164}; Surface{6196};
  Surface{6223}; Surface{6255}; Surface{6287}; Surface{6319}; Surface{6351};
  Surface{6383}; Surface{6415}; Surface{6447}; Surface{6479}; Surface{6511};
  Surface{6538}; Surface{6570}; Surface{6602}; Surface{6634}; Surface{6666};
  Surface{6698}; Surface{6730}; Surface{6762}; Surface{6794}; Surface{6826};
  Layers{Lf}; Recombine;
}

Physical Volume("M225") += {201, 202, 203, 212, 213, 223, 222, 211, 221};

Physical Volume("M23") = {204, 231};
Physical Volume("M24") = {214};
Physical Volume("M25") = {224};
Physical Volume("M26") = {234};
Physical Volume("M27") = {233};
Physical Volume("M28") = {232};

Physical Volume("M29") = {205, 241};
Physical Volume("M30") = {215};
Physical Volume("M31") = {225};
Physical Volume("M32") = {235};
Physical Volume("M33") = {245};
Physical Volume("M34") = {244};
Physical Volume("M35") = {243};
Physical Volume("M36") = {242};

Physical Volume("M37") = {216};
Physical Volume("M38") = {226};
Physical Volume("M39") = {236};
Physical Volume("M40") = {246};
Physical Volume("M41") = {255};
Physical Volume("M42") = {254};
Physical Volume("M43") = {253};
Physical Volume("M44") = {252};

Physical Volume("M226") += {
  206, 207, 251, 261, 217, 227, 237, 247, 257, 256,
  266, 265, 264, 263, 262, 218, 228, 238, 248, 258,
  268, 267, 277, 276, 275, 274, 273, 272
};

Physical Volume("M227") += {
  208, 219, 229, 239, 249, 259, 269, 279, 278, 288,
  287, 286, 285, 284, 283, 282, 271, 209, 210, 220,
  230, 240, 250, 260, 270, 280, 290, 289, 300, 299,
  298, 297, 296, 295, 294, 293, 292, 281, 291
};

Physical Surface("wall1") += {
  6840, 6863, 6890, 6917, 6944, 6971, 6998, 7025, 7052, 7079
};

Physical Surface("wall2") += {
  6836, 7110, 7425, 7740, 8055, 8370, 8685, 9000, 9315, 9630
};

Physical Surface("outerwall") += {
  7083, 7087, 7390, 7394, 7705, 7709, 8020, 8024, 8335, 8339,
  8650, 8654, 8965, 8969, 9280, 9284, 9595, 9599, 9910, 9914
};

Physical Surface("outerwall") += {
  9634, 9638, 9662, 9658, 9694, 9690, 9726, 9722, 9758, 9754,
  9790, 9786, 9822, 9818, 9854, 9850, 9886, 9882, 9918
};

Extrude {0, 0, Hf} {
  Surface{6853}; Surface{6880}; Surface{6907}; Surface{6934}; Surface{6961};
  Surface{6988}; Surface{7015}; Surface{7042}; Surface{7069}; Surface{7096};
  Surface{7123}; Surface{7155}; Surface{7187}; Surface{7219}; Surface{7251};
  Surface{7283}; Surface{7315}; Surface{7347}; Surface{7379}; Surface{7411};
  Surface{7438}; Surface{7470}; Surface{7502}; Surface{7534}; Surface{7566};
  Surface{7598}; Surface{7630}; Surface{7662}; Surface{7694}; Surface{7726};
  Surface{7753}; Surface{7785}; Surface{7817}; Surface{7849}; Surface{7881};
  Surface{7913}; Surface{7945}; Surface{7977}; Surface{8009}; Surface{8041};
  Surface{8068}; Surface{8100}; Surface{8132}; Surface{8164}; Surface{8196};
  Surface{8228}; Surface{8260}; Surface{8292}; Surface{8324}; Surface{8356};
  Surface{8383}; Surface{8415}; Surface{8447}; Surface{8479}; Surface{8511};
  Surface{8543}; Surface{8575}; Surface{8607}; Surface{8639}; Surface{8671};
  Surface{8698}; Surface{8730}; Surface{8762}; Surface{8794}; Surface{8826};
  Surface{8858}; Surface{8890}; Surface{8922}; Surface{8954}; Surface{8986};
  Surface{9013}; Surface{9045}; Surface{9077}; Surface{9109}; Surface{9141};
  Surface{9173}; Surface{9205}; Surface{9237}; Surface{9269}; Surface{9301};
  Surface{9328}; Surface{9360}; Surface{9392}; Surface{9424}; Surface{9456};
  Surface{9488}; Surface{9520}; Surface{9552}; Surface{9584}; Surface{9616};
  Surface{9643}; Surface{9675}; Surface{9707}; Surface{9739}; Surface{9771};
  Surface{9803}; Surface{9835}; Surface{9867}; Surface{9899}; Surface{9931};
  Layers{Lf}; Recombine;
}

Physical Volume("M225") += {301, 302, 303, 313, 323, 312, 322, 311, 321};

Physical Volume("M45") = {304, 331};
Physical Volume("M46") = {314};
Physical Volume("M47") = {324};
Physical Volume("M48") = {334};
Physical Volume("M49") = {333};
Physical Volume("M50") = {332};

Physical Volume("M51") = {305, 341};
Physical Volume("M52") = {315};
Physical Volume("M53") = {325};
Physical Volume("M54") = {335};
Physical Volume("M55") = {345};
Physical Volume("M56") = {344};
Physical Volume("M57") = {343};
Physical Volume("M58") = {342};

Physical Volume("M59") = {316};
Physical Volume("M60") = {326};
Physical Volume("M61") = {336};
Physical Volume("M62") = {346};
Physical Volume("M63") = {355};
Physical Volume("M64") = {354};
Physical Volume("M65") = {353};
Physical Volume("M66") = {352};

Physical Volume("M226") += {
  306, 307, 317, 327, 337, 347, 357, 356, 366, 365,
  364, 363, 362, 351, 361, 318, 328, 338, 348, 358,
  368, 367, 377, 376, 375, 374, 373, 372
};

Physical Volume("M227") += {
  308, 309, 319, 329, 339, 349, 359, 369, 379, 378,
  389, 388, 387, 386, 385, 384, 383, 382, 371, 381,
  310, 320, 330, 340, 350, 360, 370, 380, 390, 400,
  399, 398, 397, 396, 395, 394, 393, 392, 391
};

Physical Surface("wall1") += {
  9945, 9968, 9995, 10022, 10049, 10076, 10103, 10130, 10157, 10184
};

Physical Surface("wall2") += {
  9941, 10215, 10530, 10845, 11160, 11475, 11790, 12105, 12420, 12735
};

Physical Surface("outerwall") += {
  10188, 10192, 10495, 10499, 10810, 10814, 11125, 11129, 11440, 11444,
  11755, 11759, 12070, 12074, 12385, 12389, 12700, 12704, 13015, 13019
};

Physical Surface("outerwall") += {
  12739, 12743, 12767, 12763, 12799, 12795, 12831, 12827, 12863, 12859,
  12895, 12891, 12927, 12923, 12959, 12955, 12991, 12987, 13023
};

Extrude {0, 0, Hf} {
  Surface{9958}; Surface{9985}; Surface{10012}; Surface{10039}; Surface{10066};
  Surface{10093}; Surface{10120}; Surface{10147}; Surface{10174}; Surface{10201};
  Surface{10228}; Surface{10260}; Surface{10292}; Surface{10324}; Surface{10356};
  Surface{10388}; Surface{10420}; Surface{10452}; Surface{10484}; Surface{10516};
  Surface{10543}; Surface{10575}; Surface{10607}; Surface{10639}; Surface{10671};
  Surface{10703}; Surface{10735}; Surface{10767}; Surface{10799}; Surface{10831};
  Surface{10858}; Surface{10890}; Surface{10922}; Surface{10954}; Surface{10986};
  Surface{11018}; Surface{11050}; Surface{11082}; Surface{11114}; Surface{11146};
  Surface{11173}; Surface{11205}; Surface{11237}; Surface{11269}; Surface{11301};
  Surface{11333}; Surface{11365}; Surface{11397}; Surface{11429}; Surface{11461};
  Surface{11488}; Surface{11520}; Surface{11552}; Surface{11584}; Surface{11616};
  Surface{11648}; Surface{11680}; Surface{11712}; Surface{11744}; Surface{11776};
  Surface{11803}; Surface{11835}; Surface{11867}; Surface{11899}; Surface{11931};
  Surface{11963}; Surface{11995}; Surface{12027}; Surface{12059}; Surface{12091};
  Surface{12118}; Surface{12150}; Surface{12182}; Surface{12214}; Surface{12246};
  Surface{12278}; Surface{12310}; Surface{12342}; Surface{12374}; Surface{12406};
  Surface{12433}; Surface{12465}; Surface{12497}; Surface{12529}; Surface{12561};
  Surface{12593}; Surface{12625}; Surface{12657}; Surface{12689}; Surface{12721};
  Surface{12748}; Surface{12780}; Surface{12812}; Surface{12844}; Surface{12876};
  Surface{12908}; Surface{12940}; Surface{12972}; Surface{13004}; Surface{13036}; 
  Layers{Lf}; Recombine;
}

Physical Volume("M225") += {401, 402, 403, 411, 412, 421, 422, 413, 423};

Physical Volume("M67") = {404, 431};
Physical Volume("M68") = {414};
Physical Volume("M69") = {424};
Physical Volume("M70") = {434};
Physical Volume("M71") = {433};
Physical Volume("M72") = {432};

Physical Volume("M73") = {405, 441};
Physical Volume("M74") = {415};
Physical Volume("M75") = {425};
Physical Volume("M76") = {435};
Physical Volume("M77") = {445};
Physical Volume("M78") = {444};
Physical Volume("M79") = {443};
Physical Volume("M80") = {442};

Physical Volume("M81") = {416};
Physical Volume("M82") = {426};
Physical Volume("M83") = {436};
Physical Volume("M84") = {446};
Physical Volume("M85") = {455};
Physical Volume("M86") = {454};
Physical Volume("M87") = {453};
Physical Volume("M88") = {452};

Physical Volume("M226") += {
  406, 417, 427, 407, 418, 428, 438, 437, 447, 448,
  458, 457, 456, 466, 467, 468, 477, 476, 465, 464,
  463, 475, 474, 462, 473, 472, 451, 461
};

Physical Volume("M227") += {
  408, 409, 410, 419, 420, 430, 429, 440, 439, 449,
  450, 459, 460, 470, 469, 480, 479, 490, 489, 478,
  500, 488, 499, 487, 498, 486, 497, 485, 496, 484,
  495, 483, 494, 482, 493, 481, 492, 471, 491
};

Physical Surface("wall1") += {
  13050, 13073, 13100, 13127, 13154, 13181, 13208, 13235, 13262, 13289
};

Physical Surface("wall2") += {
  15840, 15525, 15210, 14895, 14580, 14265, 13950, 13635, 13320, 13046
};

Physical Surface("outerwall") += {
  13293, 13297, 13600, 13604, 13915, 13919, 14230, 14234, 14545, 14549,
  14860, 14864, 15175, 15179, 15490, 15494, 15805, 15809, 16120, 16124
};

Physical Surface("outerwall") += {
  15844, 15848, 15872, 15868, 15904, 15900, 15936, 15932, 15968, 15964,
  16000, 15996, 16032, 16028, 16064, 16060, 16096, 16092, 16128
};

Extrude {0, 0, Hf} {
  Surface{13063}; Surface{13090}; Surface{13117}; Surface{13144}; Surface{13171};
  Surface{13198}; Surface{13225}; Surface{13252}; Surface{13279}; Surface{13306};
  Surface{13333}; Surface{13365}; Surface{13397}; Surface{13429}; Surface{13461};
  Surface{13493}; Surface{13525}; Surface{13557}; Surface{13589}; Surface{13621};
  Surface{13648}; Surface{13680}; Surface{13712}; Surface{13744}; Surface{13776};
  Surface{13808}; Surface{13840}; Surface{13872}; Surface{13904}; Surface{13936};
  Surface{13963}; Surface{13995}; Surface{14027}; Surface{14059}; Surface{14091};
  Surface{14123}; Surface{14155}; Surface{14187}; Surface{14219}; Surface{14251};
  Surface{14278}; Surface{14310}; Surface{14342}; Surface{14374}; Surface{14406};
  Surface{14438}; Surface{14470}; Surface{14502}; Surface{14534}; Surface{14566};
  Surface{14593}; Surface{14625}; Surface{14657}; Surface{14689}; Surface{14721};
  Surface{14753}; Surface{14785}; Surface{14817}; Surface{14849}; Surface{14881};
  Surface{14908}; Surface{14940}; Surface{14972}; Surface{15004}; Surface{15036};
  Surface{15068}; Surface{15100}; Surface{15132}; Surface{15164}; Surface{15196};
  Surface{15223}; Surface{15255}; Surface{15287}; Surface{15319}; Surface{15351};
  Surface{15383}; Surface{15415}; Surface{15447}; Surface{15479}; Surface{15511};
  Surface{15538}; Surface{15570}; Surface{15602}; Surface{15634}; Surface{15666};
  Surface{15698}; Surface{15730}; Surface{15762}; Surface{15794}; Surface{15826};
  Surface{15853}; Surface{15885}; Surface{15917}; Surface{15949}; Surface{15981};
  Surface{16013}; Surface{16045}; Surface{16077}; Surface{16109}; Surface{16141}; 
  Layers{Lf}; Recombine;
}

Physical Volume("M225") += {501, 502, 503, 511, 512, 521, 522, 513, 523};

Physical Volume("M89") = {504, 531};
Physical Volume("M90") = {514};
Physical Volume("M91") = {524};
Physical Volume("M92") = {534};
Physical Volume("M93") = {533};
Physical Volume("M94") = {532};

Physical Volume("M95") = {505, 541};
Physical Volume("M96") = {515};
Physical Volume("M97") = {525};
Physical Volume("M98") = {535};
Physical Volume("M99") = {545};
Physical Volume("M100") = {544};
Physical Volume("M101") = {543};
Physical Volume("M102") = {542};

Physical Volume("M103") = {516};
Physical Volume("M104") = {526};
Physical Volume("M105") = {536};
Physical Volume("M106") = {546};
Physical Volume("M107") = {555};
Physical Volume("M108") = {554};
Physical Volume("M109") = {553};
Physical Volume("M110") = {552};

Physical Volume("M226") += {
  506, 517, 527, 507, 518, 528, 538, 537, 547, 548,
  558, 557, 556, 566, 567, 568, 577, 576, 565, 564,
  563, 575, 574, 562, 573, 572, 551, 561
};

Physical Volume("M227") += {
  508, 509, 510, 519, 520, 530, 529, 540, 539, 549,
  550, 559, 560, 570, 569, 580, 579, 590, 589, 578,
  600, 588, 599, 587, 598, 586, 597, 585, 596, 584,
  595, 583, 594, 582, 593, 581, 592, 571, 591
};

Physical Surface("wall1") += {
  16155, 16178, 16205, 16232, 16259, 16286, 16313, 16340, 16367, 16394
};

Physical Surface("wall2") += {
  16151, 16425, 16740, 17055, 17370, 17685, 18000, 18315, 18630, 18945
};

Physical Surface("outerwall") += {
  16398, 16402, 16705, 16709, 17020, 17024, 17335, 17339, 17650, 17654,
  17965, 17969, 18280, 18284, 18595, 18599, 18910, 18914, 19225, 19229
};

Physical Surface("outerwall") += {
  18949, 18953, 18977, 18973, 19009, 19005, 19041, 19037, 19073, 19069,
  19105, 19101, 19137, 19133, 19169, 19165, 19201, 19197, 19233
};

Extrude {0, 0, Hf} {
   Surface{16168}; Surface{16195}; Surface{16222}; Surface{16249}; Surface{16276};
   Surface{16303}; Surface{16330}; Surface{16357}; Surface{16384}; Surface{16411};
   Surface{16438}; Surface{16470}; Surface{16502}; Surface{16534}; Surface{16566};
   Surface{16598}; Surface{16630}; Surface{16662}; Surface{16694}; Surface{16726};
   Surface{16753}; Surface{16785}; Surface{16817}; Surface{16849}; Surface{16881};
   Surface{16913}; Surface{16945}; Surface{16977}; Surface{17009}; Surface{17041};
   Surface{17068}; Surface{17100}; Surface{17132}; Surface{17164}; Surface{17196};
   Surface{17228}; Surface{17260}; Surface{17292}; Surface{17324}; Surface{17356};
   Surface{17383}; Surface{17415}; Surface{17447}; Surface{17479}; Surface{17511};
   Surface{17543}; Surface{17575}; Surface{17607}; Surface{17639}; Surface{17671};
   Surface{17698}; Surface{17730}; Surface{17762}; Surface{17794}; Surface{17826};
   Surface{17858}; Surface{17890}; Surface{17922}; Surface{17954}; Surface{17986};
   Surface{18013}; Surface{18045}; Surface{18077}; Surface{18109}; Surface{18141};
   Surface{18173}; Surface{18205}; Surface{18237}; Surface{18269}; Surface{18301};
   Surface{18328}; Surface{18360}; Surface{18392}; Surface{18424}; Surface{18456};
   Surface{18488}; Surface{18520}; Surface{18552}; Surface{18584}; Surface{18616};
   Surface{18643}; Surface{18675}; Surface{18707}; Surface{18739}; Surface{18771};
   Surface{18803}; Surface{18835}; Surface{18867}; Surface{18899}; Surface{18931};
   Surface{18958}; Surface{18990}; Surface{19022}; Surface{19054}; Surface{19086};
   Surface{19118}; Surface{19150}; Surface{19182}; Surface{19214}; Surface{19246};
   Layers{Lf}; Recombine;
}

Physical Volume("M225") += {601, 602, 603, 611, 612, 621, 622, 613, 623};

Physical Volume("M111") = {604, 631};
Physical Volume("M112") = {614};
Physical Volume("M113") = {624};
Physical Volume("M114") = {634};
Physical Volume("M115") = {633};
Physical Volume("M116") = {632};

Physical Volume("M117") = {605, 641};
Physical Volume("M118") = {615};
Physical Volume("M119") = {625};
Physical Volume("M120") = {635};
Physical Volume("M121") = {645};
Physical Volume("M122") = {644};
Physical Volume("M123") = {643};
Physical Volume("M124") = {642};

Physical Volume("M125") = {616};
Physical Volume("M126") = {626};
Physical Volume("M127") = {636};
Physical Volume("M128") = {646};
Physical Volume("M129") = {655};
Physical Volume("M130") = {654};
Physical Volume("M131") = {653};
Physical Volume("M132") = {652};

Physical Volume("M226") += {
  606, 617, 627, 607, 618, 628, 638, 637, 647, 648,
  658, 657, 656, 666, 667, 668, 677, 676, 665, 664,
  663, 675, 674, 662, 673, 672, 651, 661
};

Physical Volume("M227") += {
  608, 609, 610, 619, 620, 630, 629, 640, 639, 649,
  650, 659, 660, 670, 669, 680, 679, 690, 689, 678,
  700, 688, 699, 687, 698, 686, 697, 685, 696, 684,
  695, 683, 694, 682, 693, 681, 692, 671, 691
};

Physical Surface("wall1") += {
  19260, 19283, 19310, 19337, 19364, 19391, 19418, 19445, 19472, 19499
};

Physical Surface("wall2") += {
  19256, 19530, 19845, 20160, 20475, 20790, 21105, 21420, 21735, 22050
};

Physical Surface("outerwall") += {
  19503, 19507, 19810, 19814, 20125, 20129, 20440, 20444, 20755, 20759,
  21070, 21074, 21385, 21389, 21700, 21704, 22015, 22019, 22330, 22334
};

Physical Surface("outerwall") += {
  22054, 22058, 22082, 22078, 22114, 22110, 22146, 22142, 22178, 22174,
  22210, 22206, 22242, 22238, 22274, 22270, 22306, 22302, 22338
};

Extrude {0, 0, Hf} {
  Surface{19273}; Surface{19300}; Surface{19327}; Surface{19354}; Surface{19381};
  Surface{19408}; Surface{19435}; Surface{19462}; Surface{19489}; Surface{19516};
  Surface{19543}; Surface{19575}; Surface{19607}; Surface{19639}; Surface{19671};
  Surface{19703}; Surface{19735}; Surface{19767}; Surface{19799}; Surface{19831};
  Surface{19858}; Surface{19890}; Surface{19922}; Surface{19954}; Surface{19986};
  Surface{20018}; Surface{20050}; Surface{20082}; Surface{20114}; Surface{20146};
  Surface{20173}; Surface{20205}; Surface{20237}; Surface{20269}; Surface{20301};
  Surface{20333}; Surface{20365}; Surface{20397}; Surface{20429}; Surface{20461};
  Surface{20488}; Surface{20520}; Surface{20552}; Surface{20584}; Surface{20616};
  Surface{20648}; Surface{20680}; Surface{20712}; Surface{20744}; Surface{20776};
  Surface{20803}; Surface{20835}; Surface{20867}; Surface{20899}; Surface{20931};
  Surface{20963}; Surface{20995}; Surface{21027}; Surface{21059}; Surface{21091};
  Surface{21118}; Surface{21150}; Surface{21182}; Surface{21214}; Surface{21246};
  Surface{21278}; Surface{21310}; Surface{21342}; Surface{21374}; Surface{21406};
  Surface{21433}; Surface{21465}; Surface{21497}; Surface{21529}; Surface{21561};
  Surface{21593}; Surface{21625}; Surface{21657}; Surface{21689}; Surface{21721};
  Surface{21748}; Surface{21780}; Surface{21812}; Surface{21844}; Surface{21876};
  Surface{21908}; Surface{21940}; Surface{21972}; Surface{22004}; Surface{22036};
  Surface{22063}; Surface{22095}; Surface{22127}; Surface{22159}; Surface{22191};
  Surface{22223}; Surface{22255}; Surface{22287}; Surface{22319}; Surface{22351};
  Layers{Lf}; Recombine;
}

Physical Volume("M225") += {701, 702, 703, 711, 712, 721, 722, 713, 723};

Physical Volume("M133") = {704, 731};
Physical Volume("M134") = {714};
Physical Volume("M135") = {724};
Physical Volume("M136") = {734};
Physical Volume("M137") = {733};
Physical Volume("M138") = {732};

Physical Volume("M139") = {705, 741};
Physical Volume("M140") = {715};
Physical Volume("M141") = {725};
Physical Volume("M142") = {735};
Physical Volume("M143") = {745};
Physical Volume("M144") = {744};
Physical Volume("M145") = {743};
Physical Volume("M146") = {742};

Physical Volume("M147") = {716};
Physical Volume("M148") = {726};
Physical Volume("M149") = {736};
Physical Volume("M150") = {746};
Physical Volume("M151") = {755};
Physical Volume("M152") = {754};
Physical Volume("M153") = {753};
Physical Volume("M154") = {752};

Physical Volume("M226") += {
  706, 717, 727, 707, 718, 728, 738, 737, 747, 748,
  758, 757, 756, 766, 767, 768, 777, 776, 765, 764,
  763, 775, 774, 762, 773, 772, 751, 761
};

Physical Volume("M227") += {
  708, 709, 710, 719, 720, 730, 729, 740, 739, 749,
  750, 759, 760, 770, 769, 780, 779, 790, 789, 778,
  800, 788, 799, 787, 798, 786, 797, 785, 796, 784,
  795, 783, 794, 782, 793, 781, 792, 771, 791
};

Physical Surface("wall1") += {
  22365, 22388, 22415, 22442, 22469, 22496, 22523, 22550, 22577, 22604
};

Physical Surface("wall2") += {
  22361, 22635, 22950, 23265, 23580, 23895, 24210, 24525, 24840, 25155
};

Physical Surface("outerwall") += {
  22608, 22612, 22915, 22919, 23230, 23234, 23545, 23549, 23860, 23864,
  24175, 24179, 24490, 24494, 24805, 24809, 25120, 25124, 25435, 25439
};

Physical Surface("outerwall") += {
  25159, 25163, 25187, 25183, 25219, 25215, 25251, 25247, 25283, 25279,
  25315, 25311, 25347, 25343, 25379, 25375, 25411, 25407, 25443
};

Extrude {0, 0, Hf} {
  Surface{22378}; Surface{22405}; Surface{22432}; Surface{22459}; Surface{22486};
  Surface{22513}; Surface{22540}; Surface{22567}; Surface{22594}; Surface{22621};
  Surface{22648}; Surface{22680}; Surface{22712}; Surface{22744}; Surface{22776};
  Surface{22808}; Surface{22840}; Surface{22872}; Surface{22904}; Surface{22936};
  Surface{22963}; Surface{22995}; Surface{23027}; Surface{23059}; Surface{23091};
  Surface{23123}; Surface{23155}; Surface{23187}; Surface{23219}; Surface{23251};
  Surface{23278}; Surface{23310}; Surface{23342}; Surface{23374}; Surface{23406};
  Surface{23438}; Surface{23470}; Surface{23502}; Surface{23534}; Surface{23566};
  Surface{23593}; Surface{23625}; Surface{23657}; Surface{23689}; Surface{23721};
  Surface{23753}; Surface{23785}; Surface{23817}; Surface{23849}; Surface{23881};
  Surface{23908}; Surface{23940}; Surface{23972}; Surface{24004}; Surface{24036};
  Surface{24068}; Surface{24100}; Surface{24132}; Surface{24164}; Surface{24196};
  Surface{24223}; Surface{24255}; Surface{24287}; Surface{24319}; Surface{24351};
  Surface{24383}; Surface{24415}; Surface{24447}; Surface{24479}; Surface{24511};
  Surface{24538}; Surface{24570}; Surface{24602}; Surface{24634}; Surface{24666};
  Surface{24698}; Surface{24730}; Surface{24762}; Surface{24794}; Surface{24826};
  Surface{24853}; Surface{24885}; Surface{24917}; Surface{24949}; Surface{24981};
  Surface{25013}; Surface{25045}; Surface{25077}; Surface{25109}; Surface{25141};
  Surface{25168}; Surface{25200}; Surface{25232}; Surface{25264}; Surface{25296};
  Surface{25328}; Surface{25360}; Surface{25392}; Surface{25424}; Surface{25456}; 
  Layers{Lf}; Recombine;
}

Physical Volume("M225") += {801, 802, 803, 811, 812, 821, 822, 813, 823};

Physical Volume("M155") = {804, 831};
Physical Volume("M156") = {814};
Physical Volume("M157") = {824};
Physical Volume("M158") = {834};
Physical Volume("M159") = {833};
Physical Volume("M160") = {832};

Physical Volume("M161") = {805, 841};
Physical Volume("M162") = {815};
Physical Volume("M163") = {825};
Physical Volume("M164") = {835};
Physical Volume("M165") = {845};
Physical Volume("M166") = {844};
Physical Volume("M167") = {843};
Physical Volume("M168") = {842};

Physical Volume("M169") = {816};
Physical Volume("M170") = {826};
Physical Volume("M171") = {836};
Physical Volume("M172") = {846};
Physical Volume("M173") = {855};
Physical Volume("M174") = {854};
Physical Volume("M175") = {853};
Physical Volume("M176") = {852};

Physical Volume("M226") += {
  806, 817, 827, 807, 818, 828, 838, 837, 847, 848,
  858, 857, 856, 866, 867, 868, 877, 876, 865, 864,
  863, 875, 874, 862, 873, 872, 851, 861
};

Physical Volume("M227") += {
  808, 809, 810, 819, 820, 830, 829, 840, 839, 849,
  850, 859, 860, 870, 869, 880, 879, 890, 889, 878,
  900, 888, 899, 887, 898, 886, 897, 885, 896, 884,
  895, 883, 894, 882, 893, 881, 892, 871, 891
};

Physical Surface("wall1") += {
  25470, 25493, 25520, 25547, 25574, 25601, 25628, 25655, 25682, 25709
};

Physical Surface("wall2") += {
  25466, 25740, 26055, 26370, 26685, 27000, 27315, 27630, 27945, 28260
};

Physical Surface("outerwall") += {
  25713, 25717, 26020, 26024, 26335, 26339, 26650, 26654, 26965, 26969,
  27280, 27284, 27595, 27599, 27910, 27914, 28225, 28229, 28540, 28544
};

Physical Surface("outerwall") += {
  28264, 28268, 28292, 28288, 28324, 28320, 28356, 28352, 28388, 28384,
  28420, 28416, 28452, 28448, 28484, 28480, 28516, 28512, 28548
};

Extrude {0, 0, Hf} {
  Surface{25483}; Surface{25510}; Surface{25537}; Surface{25564}; Surface{25591};
  Surface{25618}; Surface{25645}; Surface{25672}; Surface{25699}; Surface{25726};
  Surface{25753}; Surface{25785}; Surface{25817}; Surface{25849}; Surface{25881};
  Surface{25913}; Surface{25945}; Surface{25977}; Surface{26009}; Surface{26041};
  Surface{26068}; Surface{26100}; Surface{26132}; Surface{26164}; Surface{26196};
  Surface{26228}; Surface{26260}; Surface{26292}; Surface{26324}; Surface{26356};
  Surface{26383}; Surface{26415}; Surface{26447}; Surface{26479}; Surface{26511};
  Surface{26543}; Surface{26575}; Surface{26607}; Surface{26639}; Surface{26671};
  Surface{26698}; Surface{26730}; Surface{26762}; Surface{26794}; Surface{26826};
  Surface{26858}; Surface{26890}; Surface{26922}; Surface{26954}; Surface{26986};
  Surface{27013}; Surface{27045}; Surface{27077}; Surface{27109}; Surface{27141};
  Surface{27173}; Surface{27205}; Surface{27237}; Surface{27269}; Surface{27301};
  Surface{27328}; Surface{27360}; Surface{27392}; Surface{27424}; Surface{27456};
  Surface{27488}; Surface{27520}; Surface{27552}; Surface{27584}; Surface{27616};
  Surface{27643}; Surface{27675}; Surface{27707}; Surface{27739}; Surface{27771};
  Surface{27803}; Surface{27835}; Surface{27867}; Surface{27899}; Surface{27931};
  Surface{27958}; Surface{27990}; Surface{28022}; Surface{28054}; Surface{28086};
  Surface{28118}; Surface{28150}; Surface{28182}; Surface{28214}; Surface{28246};
  Surface{28273}; Surface{28305}; Surface{28337}; Surface{28369}; Surface{28401};
  Surface{28433}; Surface{28465}; Surface{28497}; Surface{28529}; Surface{28561}; 
  Layers{Lf}; Recombine;
}

Physical Volume("M225") += {901, 902, 903, 911, 912, 921, 922, 913, 923};

Physical Volume("M177") = {904, 931};
Physical Volume("M178") = {914};
Physical Volume("M179") = {924};
Physical Volume("M180") = {934};
Physical Volume("M181") = {933};
Physical Volume("M182") = {932};

Physical Volume("M183") = {905, 941};
Physical Volume("M184") = {915};
Physical Volume("M185") = {925};
Physical Volume("M186") = {935};
Physical Volume("M187") = {945};
Physical Volume("M188") = {944};
Physical Volume("M189") = {943};
Physical Volume("M190") = {942};

Physical Volume("M191") = {916};
Physical Volume("M192") = {926};
Physical Volume("M193") = {936};
Physical Volume("M194") = {946};
Physical Volume("M195") = {955};
Physical Volume("M196") = {954};
Physical Volume("M197") = {953};
Physical Volume("M198") = {952};

Physical Volume("M226") += {
  906, 917, 927, 907, 918, 928, 938, 937, 947, 948,
  958, 957, 956, 966, 967, 968, 977, 976, 965, 964,
  963, 975, 974, 962, 973, 972, 951, 961
};

Physical Volume("M227") += {
  908, 909, 910, 919, 920, 930, 929, 940, 939, 949,
  950, 959, 960, 970, 969, 980, 979, 990, 989, 978,
  1000, 988, 999, 987, 998, 986, 997, 985, 996, 984,
  995, 983, 994, 982, 993, 981, 992, 971, 991
};

Physical Surface("wall1") += {
  28575, 28598, 28625, 28652, 28679, 28706, 28733, 28760, 28787, 28814
};

Physical Surface("wall2") += {
  28571, 28845, 29160, 29475, 29790, 30105, 30420, 30735, 31050, 31365
};

Physical Surface("outerwall") += {
  28818, 28822, 29125, 29129, 29440, 29444, 29755, 29759, 30070, 30074,
  30385, 30389, 30700, 30704, 31015, 31019, 31330, 31334, 31645, 31649
};

Physical Surface("outerwall") += {
  31369, 31373, 31397, 31393, 31429, 31425, 31461, 31457, 31493, 31489,
  31525, 31521, 31557, 31553, 31589, 31585, 31621, 31617, 31653
};

Extrude {0, 0, Hf} {
  Surface{28588}; Surface{28615}; Surface{28642}; Surface{28669}; Surface{28696};
  Surface{28723}; Surface{28750}; Surface{28777}; Surface{28804}; Surface{28831};
  Surface{28858}; Surface{28890}; Surface{28922}; Surface{28954}; Surface{28986};
  Surface{29018}; Surface{29050}; Surface{29082}; Surface{29114}; Surface{29146};
  Surface{29173}; Surface{29205}; Surface{29237}; Surface{29269}; Surface{29301};
  Surface{29333}; Surface{29365}; Surface{29397}; Surface{29429}; Surface{29461};
  Surface{29488}; Surface{29520}; Surface{29552}; Surface{29584}; Surface{29616};
  Surface{29648}; Surface{29680}; Surface{29712}; Surface{29744}; Surface{29776};
  Surface{29803}; Surface{29835}; Surface{29867}; Surface{29899}; Surface{29931};
  Surface{29963}; Surface{29995}; Surface{30027}; Surface{30059}; Surface{30091};
  Surface{30118}; Surface{30150}; Surface{30182}; Surface{30214}; Surface{30246};
  Surface{30278}; Surface{30310}; Surface{30342}; Surface{30374}; Surface{30406};
  Surface{30433}; Surface{30465}; Surface{30497}; Surface{30529}; Surface{30561};
  Surface{30593}; Surface{30625}; Surface{30657}; Surface{30689}; Surface{30721};
  Surface{30748}; Surface{30780}; Surface{30812}; Surface{30844}; Surface{30876};
  Surface{30908}; Surface{30940}; Surface{30972}; Surface{31004}; Surface{31036};
  Surface{31063}; Surface{31095}; Surface{31127}; Surface{31159}; Surface{31191};
  Surface{31223}; Surface{31255}; Surface{31287}; Surface{31319}; Surface{31351};
  Surface{31378}; Surface{31410}; Surface{31442}; Surface{31474}; Surface{31506};
  Surface{31538}; Surface{31570}; Surface{31602}; Surface{31634}; Surface{31666}; 
  Layers{Lf}; Recombine;
}

Physical Volume("M225") += {1001, 1002, 1003, 1011, 1012, 1021, 1022, 1013, 1023};

Physical Volume("M199") = {1004, 1031};
Physical Volume("M200") = {1014};
Physical Volume("M201") = {1024};
Physical Volume("M202") = {1034};
Physical Volume("M203") = {1033};
Physical Volume("M204") = {1032};

Physical Volume("M205") = {1005, 1041};
Physical Volume("M206") = {1015};
Physical Volume("M207") = {1025};
Physical Volume("M208") = {1035};
Physical Volume("M209") = {1045};
Physical Volume("M210") = {1044};
Physical Volume("M211") = {1043};
Physical Volume("M212") = {1042};

Physical Volume("M213") = {1016};
Physical Volume("M214") = {1026};
Physical Volume("M215") = {1036};
Physical Volume("M216") = {1046};
Physical Volume("M217") = {1055};
Physical Volume("M218") = {1054};
Physical Volume("M219") = {1053};
Physical Volume("M220") = {1052};

Physical Volume("M232") = {1017};

Physical Volume("M226") += {
  1006, 1027, 1007, 1018, 1028, 1038, 1037, 1047, 1048,
  1058, 1057, 1056, 1066, 1067, 1068, 1077, 1076, 1065, 1064,
  1063, 1075, 1074, 1062, 1073, 1072, 1051, 1061
};

Physical Volume("M227") += {
  1008, 1009, 1010, 1019, 1020, 1030, 1029, 1040, 1039, 1049,
  1050, 1059, 1060, 1070, 1069, 1080, 1079, 1090, 1089, 1078,
  1100, 1088, 1099, 1087, 1098, 1086, 1097, 1085, 1096, 1084,
  1095, 1083, 1094, 1082, 1093, 1081, 1092, 1071, 1091
};

Physical Surface("wall1") += {
  31680, 31703, 31730, 31757, 31784, 31811, 31838, 31865, 31892, 31919
};

Physical Surface("wall2") += {
  31676, 31950, 32265, 32580, 32895, 33210, 33525, 33840, 34155, 34470
};

Physical Surface("outerwall") += {
  31923, 31927, 32230, 32234, 32545, 32549, 32860, 32864, 33175, 33179,
  33490, 33494, 33805, 33809, 34120, 34124, 34435, 34439, 34750, 34754
};

Physical Surface("outerwall") += {
  34474, 34478, 34502, 34498, 34534, 34530, 34566, 34562, 34598, 34594,
  34630, 34626, 34662, 34658, 34694, 34690, 34726, 34722, 34758
};

Extrude {0, 0, Ht} {
  Surface{31693}; Surface{31720}; Surface{31747}; Surface{31774}; Surface{31801};
  Surface{31828}; Surface{31855}; Surface{31882}; Surface{31909}; Surface{31936};
  Surface{31963}; Surface{31995}; Surface{32027}; Surface{32059}; Surface{32091};
  Surface{32123}; Surface{32155}; Surface{32187}; Surface{32219}; Surface{32251};
  Surface{32278}; Surface{32310}; Surface{32342}; Surface{32374}; Surface{32406};
  Surface{32438}; Surface{32470}; Surface{32502}; Surface{32534}; Surface{32566};
  Surface{32593}; Surface{32625}; Surface{32657}; Surface{32689}; Surface{32721};
  Surface{32753}; Surface{32785}; Surface{32817}; Surface{32849}; Surface{32881};
  Surface{32908}; Surface{32940}; Surface{32972}; Surface{33004}; Surface{33036};
  Surface{33068}; Surface{33100}; Surface{33132}; Surface{33164}; Surface{33196};
  Surface{33223}; Surface{33255}; Surface{33287}; Surface{33319}; Surface{33351};
  Surface{33383}; Surface{33415}; Surface{33447}; Surface{33479}; Surface{33511};
  Surface{33538}; Surface{33570}; Surface{33602}; Surface{33634}; Surface{33666};
  Surface{33698}; Surface{33730}; Surface{33762}; Surface{33794}; Surface{33826};
  Surface{33853}; Surface{33885}; Surface{33917}; Surface{33949}; Surface{33981};
  Surface{34013}; Surface{34045}; Surface{34077}; Surface{34109}; Surface{34141};
  Surface{34168}; Surface{34200}; Surface{34232}; Surface{34264}; Surface{34296};
  Surface{34328}; Surface{34360}; Surface{34392}; Surface{34424}; Surface{34456};
  Surface{34483}; Surface{34515}; Surface{34547}; Surface{34579}; Surface{34611};
  Surface{34643}; Surface{34675}; Surface{34707}; Surface{34739}; Surface{34771}; 
  Layers{Lt}; Recombine;
}

Physical Volume("M228") = {1101, 1102, 1103, 1111, 1112, 1121, 1122, 1113, 1123};

Physical Volume("M229") = {
  1104, 1131, 1114, 1124, 1134,
  1133, 1132, 1105, 1141, 1115,
  1125, 1135, 1145, 1144, 1143,
  1142, 1116, 1126, 1136, 1146,
  1155, 1154, 1153, 1152
};

Physical Volume("M232") += {1117};

Physical Volume("M230") = {
  1106, 1127, 1107, 1118, 1128, 1138, 1137, 1147, 1148,
  1158, 1157, 1156, 1166, 1167, 1168, 1177, 1176, 1165, 1164,
  1163, 1175, 1174, 1162, 1173, 1172, 1151, 1161
};

Physical Volume("M231") = {
  1108, 1109, 1110, 1119, 1120, 1130, 1129, 1140, 1139, 1149,
  1150, 1159, 1160, 1170, 1169, 1180, 1179, 1190, 1189, 1178,
  1200, 1188, 1199, 1187, 1198, 1186, 1197, 1185, 1196, 1184,
  1195, 1183, 1194, 1182, 1193, 1181, 1192, 1171, 1191
};

Physical Surface("wall1") += {
  34785, 34808, 34835, 34862, 34889, 34916, 34943, 34970, 34997, 35024
};

Physical Surface("wall2") += {
  34781, 35055, 35370, 35685, 36000, 36315, 36630, 36945, 37260, 37575
};

Physical Surface("outerwall") += {
  35028, 35032, 35335, 35339, 35650, 35654, 35965, 35969, 36280, 36284,
  36595, 36599, 36910, 36914, 37225, 37229, 37540, 37544, 37855, 37859
};

Physical Surface("outerwall") += {
  37579, 37583, 37607, 37603, 37639, 37635, 37671, 37667, 37703, 37699,
  37735, 37731, 37767, 37763, 37799, 37795, 37831, 37827, 37863
};

Physical Surface("ref_top") = {
  34798, 34825, 34852, 34879, 34906, 34933, 34960, 34987, 35014, 35041,
  35068, 35100, 35132, 35164, 35196, 35228, 35260, 35292, 35324, 35356,
  35383, 35415, 35447, 35479, 35511, 35543, 35575, 35607, 35639, 35671,
  35698, 35730, 35762, 35794, 35826, 35858, 35890, 35922, 35954, 35986,
  36013, 36045, 36077, 36109, 36141, 36173, 36205, 36237, 36269, 36301,
  36328, 36360, 36392, 36424, 36456, 36488, 36520, 36552, 36584, 36616,
  36643, 36675, 36707, 36739, 36771, 36803, 36835, 36867, 36899, 36931,
  36958, 36990, 37022, 37054, 37086, 37118, 37150, 37182, 37214, 37246,
  37273, 37305, 37337, 37369, 37401, 37433, 37465, 37497, 37529, 37561,
  37588, 37620, 37652, 37684, 37716, 37748, 37780, 37812, 37844, 37876
};