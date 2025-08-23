// Gmsh project created for complex polygon with central bridge
SetFactory("OpenCASCADE");

// Define points
Point(1) = {0.0, 0.9, 0, 0.05};
Point(2) = {0.48, 0.9, 0, 0.02};
Point(3) = {0.48, 0.55, 0, 0.02};
Point(4) = {0.52, 0.55, 0, 0.02};
Point(5) = {0.52, 0.9, 0, 0.02};
Point(6) = {1.0, 0.9, 0, 0.05};
Point(7) = {1.0, 0.1, 0, 0.05};
Point(8) = {0.52, 0.1, 0, 0.02};
Point(9) = {0.52, 0.45, 0, 0.02};
Point(10) = {0.48, 0.45, 0, 0.02};
Point(11) = {0.48, 0.1, 0, 0.02};
Point(12) = {0.0, 0.1, 0, 0.05};

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
Field[1].PointsList = {2, 3, 4, 5, 8, 9, 10, 11};

Field[2] = Threshold;
Field[2].InField = 1;
Field[2].SizeMin = 0.01;
Field[2].SizeMax = 0.05;
Field[2].DistMin = 0.02;
Field[2].DistMax = 0.1;

// Field for thin bridge section
Field[3] = Distance;
Field[3].CurvesList = {3, 9};

Field[4] = Threshold;
Field[4].InField = 3;
Field[4].SizeMin = 0.005;
Field[4].SizeMax = 0.02;
Field[4].DistMin = 0.01;
Field[4].DistMax = 0.05;

// Combine fields
Field[5] = Min;
Field[5].FieldsList = {2, 4};

Background Field = 5;