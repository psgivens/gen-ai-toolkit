# Mission: CSV to JSON Converter

## What I Want to Build

A command-line tool that converts CSV files to JSON format with flexible configuration options.

## Problem I'm Solving

I frequently need to convert CSV data exports into JSON for API consumption and data processing pipelines. Current tools either lack flexibility or require complex configurations. I want a simple, reliable tool that handles common edge cases.

## Success Criteria

- Converts CSV files to JSON accurately
- Handles different CSV formats (with/without headers, different delimiters)
- Provides options for JSON output format (array of objects, nested structures)
- Handles large files efficiently (streaming)
- Includes proper error handling and validation
- Easy to use from command line

## Context

- **Language preference**: Python (I'm familiar with it)
- **Target users**: Myself and my team (developers)
- **Environment**: Linux command line, also needs to work on Windows
- **Integration**: Should work in bash scripts and automated pipelines
- **Data scale**: Files range from 100 rows to 1M+ rows

## Constraints

- Should be a single executable script or installable package
- No GUI needed
- Must handle malformed CSV gracefully
- Should not require external services
