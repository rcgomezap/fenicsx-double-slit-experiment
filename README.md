# Double Slit Experiment - FEniCSx Simulation

This project simulates the classic double slit experiment using the finite element method with FEniCSx. The simulation solves the Helmholtz equation to model acoustic wave propagation through a domain with two narrow slits, demonstrating wave interference patterns.

## Project Structure

- **`double_slit.ipynb`** - Main notebook containing the complete simulation
- **`double_slit_mesh.geo`** - GMSH geometry file for the double slit domain
- **`double_slit_mesh.msh`** - Generated mesh file (created from .geo file)
- **`.devcontainer/`** - Development container configuration

## Prerequisites

This project runs in a **development container** (devcontainer) that provides all necessary dependencies including:
- FEniCSx (DOLFINx v0.9.0)
- Python with scientific computing libraries
- GMSH for mesh generation
- Jupyter notebooks support

## Setup and Usage

### 1. Development Container

Open this project in VS Code with the Dev Containers extension. The devcontainer will automatically:
- Build the DOLFINx environment
- Install Python dependencies (matplotlib, nbconvert, notebook)
- Configure the complex mode for FEniCSx

### 2. Mesh Generation

Before running the simulation, generate the 2D mesh using GMSH:

```bash
gmsh -2 double_slit_mesh.geo -o double_slit_mesh.msh
```

This command:
- `-2` generates a 2D mesh
- `double_slit_mesh.geo` is the input geometry file
- `-o double_slit_mesh.msh` specifies the output mesh file

The geometry includes:
- A rectangular domain with inlet and outlet boundaries
- Two narrow slits separated by a central bridge
- Refined meshing around the slit region for accurate wave simulation

### 3. Running the Simulation

Open and run the **`double_slit.ipynb`** notebook:
1. Execute all cells in sequence
2. The simulation solves the Helmholtz equation with:
   - Incident wave at the inlet boundary
   - Absorbing boundary conditions at the outlet
   - Hard wall conditions on solid boundaries
3. Results are saved to `solution.pvd` for visualization

### 4. Visualization

**ParaView** is recommended for visualizing the results:
1. Open ParaView
2. Load the `solution.pvd` file
3. Visualize the pressure field to see:
   - Wave propagation from the inlet
   - Diffraction through the double slits
   - Interference patterns in the far field
   - Both amplitude and phase information

## Physical Parameters

The simulation uses realistic acoustic parameters:
- **Frequency**: 3 kHz (ω = 6π × 1000 rad/s)
- **Medium**: Air (ρ = 1.225 kg/m³, c = 340 m/s)
- **Slit dimensions**: 3 mm width, 0.4 m height
- **Domain**: 5m × 5m rectangular region

## Mathematical Model

The simulation solves the **Helmholtz equation**:
```
∇²p + k²p = 0
```

where:
- `p` is the complex acoustic pressure
- `k = ω/c` is the wave number
- Complex arithmetic captures both amplitude and phase

## Key Features

- **Time-harmonic analysis** using complex-valued finite elements
- **Higher-order elements** (4th order Lagrange) for wave accuracy
- **Absorbing boundary conditions** to simulate infinite domain
- **Adaptive mesh refinement** around the slit region
- **MPI-parallel** computation support

## Dependencies

The devcontainer includes all required packages:
- DOLFINx (FEniCSx finite element library)
- PETSc (linear algebra backend)
- GMSH (mesh generation)
- NumPy, Matplotlib (scientific computing)
- Jupyter (notebook environment)

## Output Files

After running the simulation:
- `solution.pvd` - ParaView format for visualization
- `solution*.vtu` - VTK unstructured grid files
- Result images and plots within the notebook

## Author

Roberto Carlos Gómez Araque

## References

### Documentation and Tutorials
- [DOLFINx Tutorial - Helmholtz Equation](https://jsdokken.com/dolfinx-tutorial/chapter2/helmholtz.html) - Comprehensive tutorial on solving the Helmholtz equation with DOLFINx
- [DOLFINx v0.9.0 Documentation](https://docs.fenicsproject.org/dolfinx/v0.9.0/python/index.html) - Official DOLFINx Python API documentation

### Concepts Demonstrated
This simulation demonstrates fundamental concepts in:
- Computational acoustics
- Wave propagation and diffraction
- Finite element methods for complex-valued PDEs
- Classical wave interference experiments
