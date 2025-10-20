# sose

*Spatial ops on **SO/SE** — a tiny, fast 2D/3D Lie-group toolkit for robotics.*

[![PyPI](https://img.shields.io/pypi/v/sose.svg)](https://pypi.org/project/sose/) [![crates.io](https://img.shields.io/crates/v/sose.svg)](https://crates.io/crates/sose) [![CI](https://img.shields.io/github/actions/workflow/status/pikld/sose/ci.yml)](https://github.com/pikld/sose/actions) [![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](#license)

---

## Why **sose**?

- **Lie-native**: clean APIs for **SO(2)**, **SO(3)**, **SE(2)**, **SE(3)** (and n-D generics where it makes sense).
- **Robotics-ready**: `exp/log`, `hat/vee`, **adjoint**, left/right **Jacobians**, interpolation (slerp, De Casteljau on manifolds), distances (geodesic, chordal, Frobenius).
- **Friendly & familiar**: mirrors parts of `scipy.spatial.transform.Rotation` where applicable.
- **Composable**: typed transforms, batched ops, and differentiable-friendly interfaces.

Goal: Python front end with Rust core (SIMD-aware) and optional Array API backends (NumPy / CuPy / PyTorch / JAX). For now it is Numpy-native
---

## Install

**Python**
```bash
pip install numpy
pip install sose
```
---

## Quick start

### Python (SO(3) + SE(3))
```python
import numpy as np
import sose as S

# SO(3) from axis–angle (rad) and back
R = S.SO3.exp([0.1, 0.2, 0.3])      # exp: so(3) -> SO(3)
rvec = R.log()                      # log: SO(3) -> so(3)

# Compose poses in SE(3)
T1 = S.SE3.from_Rt(R, t=[0.5, 0.0, 0.0])
T2 = S.SE3.exp([0, 0, 0, 0, 0, 0.2])  # small z-translation in twist coords
T  = T1 @ T2

# Adjoint & Jacobians
Adj = T.adjoint()
Jl  = S.SO3.J_exp_left(rvec)
dist = S.SO3.geodesic_distance(R, S.SO3.I())
print(Adj.shape, Jl.shape, dist)
```

---

## Features (snapshot)

- **Groups**: SO2, SO3, SE2, SE3 (+ generic so(n)/se(n) helpers).
- **Ops**: `exp`, `log`, `hat`, `vee`, `adjoint`, `inv`, `@` composition.
- **Jacobians**: left/right of `exp/log`, boxplus/boxminus.
- **Interpolation**: slerp; Bézier/De Casteljau on manifolds.
- **Metrics**: geodesic/chordal/Frobenius; pose/rotation means.
- **Uncertainty**: first-order propagation via \(J\,\Sigma\,J^	op\).
---

## Design notes

- **SciPy-friendly**: where it fits, `SO3` exposes methods akin to `Rotation` (e.g., `as_matrix`, `from_matrix`, `as_quat`, `from_quat`), with batch support.
- **Ergonomics first**: clear names, minimal surprises, vectorized where possible.
---

## Roadmap

## Getting started with your project

### 1. Create a New Repository

First, create a repository on GitHub with the same name as this project, and then run the following commands:

```bash
git init -b main
git add .
git commit -m "init commit"
git remote add origin git@github.com:pikld/sose.git
git push -u origin main
```

### 2. Set Up Your Development Environment

Then, install the environment and the pre-commit hooks with

```bash
make install
```

This will also generate your `uv.lock` file

### 3. Run the pre-commit hooks

Initially, the CI/CD pipeline might be failing due to formatting issues. To resolve those run:

```bash
uv run pre-commit run -a
```

### 4. Commit the changes

Lastly, commit the changes made by the two steps above to your repository.

```bash
git add .
git commit -m 'Fix formatting issues'
git push origin main
```

You are now ready to start development on your project!
The CI/CD pipeline will be triggered when you open a pull request, merge to main, or when you create a new release.

To finalize the set-up for publishing to PyPI, see [here](https://fpgmaas.github.io/cookiecutter-uv/features/publishing/#set-up-for-pypi).
For activating the automatic documentation with MkDocs, see [here](https://fpgmaas.github.io/cookiecutter-uv/features/mkdocs/#enabling-the-documentation-on-github).
To enable the code coverage reports, see [here](https://fpgmaas.github.io/cookiecutter-uv/features/codecov/).

## Releasing a new version

- Create an API Token on [PyPI](https://pypi.org/).
- Add the API Token to your projects secrets with the name `PYPI_TOKEN` by visiting [this page](https://github.com/pikld/sose/settings/secrets/actions/new).
- Create a [new release](https://github.com/pikld/sose/releases/new) on Github.
- Create a new tag in the form `*.*.*`.

For more details, see [here](https://fpgmaas.github.io/cookiecutter-uv/features/cicd/#how-to-trigger-a-release).

---

## License

MIT © pikld.
