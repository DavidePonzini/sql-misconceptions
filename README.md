# Description
This tool automatically executes a query and tries to identify which errors are present in it.

# Requirements
- Local PostgreSQL database
- `dav_tools` python package (`python -m pip install dav_tools`)

# Installation
- Ensure packages and database are already installed
- Execute `db_setup.sql` as admin on the database

# Notes
- Queries must not specify a schema, otherwise they won't be executed correctly
- ChatGTP was given query requests in English, even if the original request was in Italian