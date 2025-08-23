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

Point(13) = {0.52, 0.52, 0, 0.02};
Point(14) = {0.48, 0.52, 0, 0.02};
Point(15) = {0.48, 0.48, 0, 0.02};
Point(16) = {0.52, 0.48, 0, 0.05};

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
Line(13) = {13, 14};
Line(14) = {14, 15};
Line(15) = {15, 16};
Line(16) = {16, 13};

// Define curve loop and surface
Curve Loop(1) = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12};
Plane Surface(1) = {1};

Curve Loop(2) = {13, 14, 15, 16};
Plane Surface(2) = {2};


// Physical groups for boundaries
Physical Curve("outer_boundary", 13) = {1, 5, 6, 7, 11, 12};
Physical Curve("bridge_boundaries", 14) = {2, 3, 4, 8, 9, 10};

BooleanDifference{ Surface{1}; Delete; }{ Surface{2}; Delete; }