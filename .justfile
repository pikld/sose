# Clean build artifacts
clean:
    @echo "🚀 Removing build artifacts"
    @rm -rf dist
    @rm -rf .venv
    @rm -rf uv.lock

# Install the virtual environment and install the pre-commit hooks
install:
    @echo "🚀 Creating virtual environment using uv"
    @uv sync
    @uv run pre-commit install

# Run code quality tools
check:
    @uvx ruff format
    @uvx ruff check --fix
    @echo "🚀 Checking lock file consistency with 'pyproject.toml'"
    @uv lock --locked
    @echo "🚀 Linting code: Running pre-commit"
    @uvx pre-commit run -a
    @echo "🚀 Static type checking: Running ty"
    @uvx ty check

# Test the code with pytest
test:
    @echo "🚀 Testing code: Running pytest"
    @uv sync --extra dev
    @uv run python -m pytest --cov --cov-config=pyproject.toml --cov-report=xml



# Build wheel file
build:
    @echo "🚀 Creating wheel file"
    @uvx --from build pyproject-build --installer uv

# Publish a release to PyPI
publish:
    @echo "🚀 Publishing."
    @uvx twine upload --repository-url https://upload.pypi.org/legacy/ dist/*


# Test if documentation can be built without warnings or errors
docs-test:
    @uv run mkdocs build -s

# Build and serve the documentation
docs:
    @uv sync --extra docs
    @uv run mkdocs serve

# Show documented tasks (acts like `make help`)
help:
    @just --list
