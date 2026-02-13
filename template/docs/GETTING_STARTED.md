# Getting Started

This document provides setup and development instructions for developers working on this project without using Claude Code.

## Overview

[This section will be filled in based on your actual project]

This project [brief description of what the project does].

## Prerequisites

- [List prerequisites, e.g., Python 3.8+, Node.js 18+, etc.]
- [Development tools needed]
- [System dependencies]

## Installation

```bash
# Clone the repository
git clone [repository-url]
cd [project-directory]

# Install dependencies
[installation commands]

# Set up environment
[environment setup]
```

## Project Structure

```
[project-directory]/
├── [source-directory]/     # Source code
├── [test-directory]/       # Tests
├── [config-directory]/     # Configuration files
├── claude/                 # Claude workflow artifacts (optional)
├── docs/                   # Documentation
└── README.md              # Project README
```

### Claude Directory

The `claude/` directory contains workflow artifacts from Claude Code sessions organized by task:

```
claude/
├── task-template/                    # Template for new tasks
├── 2026-01-22-add-authentication/    # Example task folder
│   ├── MISSION.md                    # Task goals and context
│   ├── REQUIREMENTS.md               # Functional requirements
│   ├── DECISIONS.md                  # Architectural decisions
│   ├── DESIGN.md                     # System design
│   └── IMPLEMENTATION_PLAN.md        # Implementation steps
└── 2026-01-23-refactor-api/          # Another task folder
    └── ...
```

**Task Folder Structure:**
- Each feature/task has its own dated folder (format: `YYYY-MM-DD-description`)
- This allows parallel work on multiple features without conflicts
- Task folders document the complete workflow: mission → requirements → decisions → design → plan

You can reference these files to understand the project's requirements and design decisions, but they are not necessary for development.

## Development

### Running the Project

```bash
# Development mode
[run command]

# Production mode
[run command]
```

### Running Tests

```bash
# Run all tests
[test command]

# Run specific tests
[specific test command]

# Run with coverage
[coverage command]
```

### Code Style

[Describe code style conventions, linting setup, formatting tools, etc.]

```bash
# Lint code
[lint command]

# Format code
[format command]
```

## Architecture

[Brief overview of the system architecture]

### Key Components

[Describe major components and their responsibilities]

### Data Flow

[Explain how data flows through the system]

### Technology Stack

[List key technologies, frameworks, libraries]

## Contributing

### Workflow

1. Create a feature branch from `main`
2. Make your changes
3. Write/update tests
4. Run tests and linting
5. Commit with descriptive messages
6. Push and create a pull request

### Commit Messages

[Commit message conventions, if any]

### Pull Requests

[PR guidelines and review process]

## Testing

### Unit Tests

[How to write and run unit tests]

### Integration Tests

[How to write and run integration tests]

### Test Coverage

[Coverage requirements and how to check]

## Deployment

[Deployment instructions if applicable]

## Troubleshooting

### Common Issues

**Issue 1: [Description]**
- **Cause:** [What causes this]
- **Solution:** [How to fix it]

**Issue 2: [Description]**
- **Cause:** [What causes this]
- **Solution:** [How to fix it]

## Resources

- [Link to additional documentation]
- [Link to external resources]
- [Link to related projects]

## Getting Help

- **Issues:** [Link to issue tracker]
- **Discussions:** [Link to discussions or forum]
- **Contact:** [Contact information]

## License

[License information]

---

**Note:** This template should be customized for your specific project. Replace the placeholders with actual project information, commands, and guidelines.
