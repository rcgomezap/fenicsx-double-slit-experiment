// Parametrized Gmsh project for double slit geometry
SetFactory("OpenCASCADE");

// Geometry parameters
domain_width = 5;
domain_height = 5.0;
slit_width = 0.003;  // Width of each slit opening
slit_height = 0.4;  // Height of each slit opening
bridge_height = 0.3;  // Height of central bridge
wall_thickness = 0.0;  // Can be increased for thicker walls

// Mesh size parameters
mesh_size_coarse = 0.08;
mesh_size_fine = 0.05;
mesh_size_bridge = 0.001;

// Calculated positions
center_x = domain_width / 2.0;
center_y = domain_height / 2.0;
half_slit = slit_width / 2.0;
half_bridge = bridge_height / 2.0;
slit_bottom = center_y - slit_height / 2.0;
slit_top = center_y + slit_height / 2.0;

// Define points
Point(1) = {0.0, domain_height - 0.1, 0, mesh_size_coarse};
Point(2) = {center_x - half_slit, domain_height - 0.1, 0, mesh_size_fine};
Point(3) = {center_x - half_slit, slit_top, 0, mesh_size_fine};
Point(4) = {center_x + half_slit, slit_top, 0, mesh_size_fine};
Point(5) = {center_x + half_slit, domain_height - 0.1, 0, mesh_size_fine};
Point(6) = {domain_width, domain_height - 0.1, 0, mesh_size_coarse};
Point(7) = {domain_width, 0.1, 0, mesh_size_coarse};
Point(8) = {center_x + half_slit, 0.1, 0, mesh_size_fine};
Point(9) = {center_x + half_slit, slit_bottom, 0, mesh_size_fine};
Point(10) = {center_x - half_slit, slit_bottom, 0, mesh_size_fine};
Point(11) = {center_x - half_slit, 0.1, 0, mesh_size_fine};
Point(12) = {0.0, 0.1, 0, mesh_size_coarse};

Point(13) = {center_x + half_slit, center_y + half_bridge, 0, mesh_size_fine};
Point(14) = {center_x - half_slit, center_y + half_bridge, 0, mesh_size_fine};
Point(15) = {center_x - half_slit, center_y - half_bridge, 0, mesh_size_fine};
Point(16) = {center_x + half_slit, center_y - half_bridge, 0, mesh_size_coarse};

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

BooleanDifference{ Surface{1}; Delete; }{ Surface{2}; Delete; }//+
Physical Curve("inlet", 29) = {18};
//+
Physical Curve("outlet", 30) = {27};
//+
Physical Curve("wall", 31) = {17, 19, 20, 22, 24, 15, 14, 16, 13, 23, 26, 28, 25, 21};

// Field for refined meshing around bridge
Field[1] = Box;
Field[1].Thickness = 1;
Field[1].XMin = center_x - half_slit;
Field[1].XMax = center_x + half_slit;
Field[1].YMin = slit_bottom;
Field[1].YMax = slit_top;
Field[1].ZMin = 0;
Field[1].ZMax = 0;
Field[1].VIn = mesh_size_bridge;
Field[1].VOut = mesh_size_fine;
Background Field = 1;

//+
Show "*";
//+
Physical Surface("domain", 32) = {1};
