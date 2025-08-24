// Gmsh project created for complex polygon with central bridge
SetFactory("OpenCASCADE");

// --- Added parameter block (interactive if opened in Gmsh GUI) ---
DefineConstant[
  Lx = {1.0, Name "Domain/Total width"};
  Ytop = {0.9, Name "Domain/Top y"};
  Ybot = {0.1, Name "Domain/Bottom y"};
  CenterX = {0.50, Name "Slit/Center x"};
  HalfSlitWidth = {0.02, Name "Slit/Half width"};
  BridgeTopY = {0.55, Name "Bridge/Top y"};
  BridgeBotY = {0.45, Name "Bridge/Bottom y"};
  // Mesh sizes
  hOuter = {0.05, Name "Mesh/Outer characteristic size"};
  hSlit  = {0.02, Name "Mesh/Slit region point size"};
  // Refinement parameters (Distance->Threshold)
  hCornerMin = {0.01, Name "Refine/Corner SizeMin"};
  hCornerMax = {0.05, Name "Refine/Corner SizeMax"};
  dCornerMin = {0.02, Name "Refine/Corner DistMin"};
  dCornerMax = {0.10, Name "Refine/Corner DistMax"};
  hBridgeMin = {0.005, Name "Refine/Bridge SizeMin"};
  hBridgeMax = {0.02, Name "Refine/Bridge SizeMax"};
  dBridgeMin = {0.01, Name "Refine/Bridge DistMin"};
  dBridgeMax = {0.05, Name "Refine/Bridge DistMax"};
];

// Derived coordinates
Xleft  = CenterX - HalfSlitWidth;
Xright = CenterX + HalfSlitWidth;

// Define points
Point(1)  = {0.0,    Ytop, 0, hOuter};
Point(2)  = {Xleft,  Ytop, 0, hSlit};
Point(3)  = {Xleft,  BridgeTopY, 0, hSlit};
Point(4)  = {Xright, BridgeTopY, 0, hSlit};
Point(5)  = {Xright, Ytop, 0, hSlit};
Point(6)  = {Lx,     Ytop, 0, hOuter};
Point(7)  = {Lx,     Ybot, 0, hOuter};
Point(8)  = {Xright, Ybot, 0, hSlit};
Point(9)  = {Xright, BridgeBotY, 0, hSlit};
Point(10) = {Xleft,  BridgeBotY, 0, hSlit};
Point(11) = {Xleft,  Ybot, 0, hSlit};
Point(12) = {0.0,    Ybot, 0, hOuter};

// Define lines
Line(1) = {1, 2};
Line(2) = {2, 3};
Line(3) = {3, 4};
Line(4) = {4, 5};
Line(5) = {5, 6};
Line(6) = {6, 7};
Line(7) = {7, 8};
Line(8) = {8, 9};
Line(9) = {9, 10};
Line(10) = {10, 11};
Line(11) = {11, 12};
Line(12) = {12, 1};

// Define curve loop and surface
Curve Loop(1) = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12};
Plane Surface(1) = {1};

// Physical groups for boundaries
Physical Curve("outer_boundary", 13) = {1, 5, 6, 7, 11, 12};
Physical Curve("bridge_boundaries", 14) = {2, 3, 4, 8, 9, 10};

// Physical group for surface
Physical Surface("domain", 15) = {1};

// Mesh refinement fields
// Field for sharp corners
Field[1] = Distance;
Field[1].PointsList = {2,3,4,5,8,9,10,11};

Field[2] = Threshold;
Field[2].InField  = 1;
Field[2].SizeMin  = hCornerMin;
Field[2].SizeMax  = hCornerMax;
Field[2].DistMin  = dCornerMin;
Field[2].DistMax  = dCornerMax;

// Field for thin bridge section
Field[3] = Distance;
Field[3].CurvesList = {3,9}; // bridge top & bottom edges

Field[4] = Threshold;
Field[4].InField  = 3;
Field[4].SizeMin  = hBridgeMin;
Field[4].SizeMax  = hBridgeMax;
Field[4].DistMin  = dBridgeMin;
Field[4].DistMax  = dBridgeMax;

// Combine fields
Field[5] = Min;
Field[5].FieldsList = {2,4};

Background Field = 5;

// Optional: ensure recompute if parameters changed
Mesh.CharacteristicLengthExtendFromBoundary = 0;