# Start local Supabase stack (Postgres, API, Auth, Storage, etc.)
supabase start

# Create a new migration file
supabase migration new add_users_table

# Edit the migration SQL
vim supabase/migrations/<timestamp>_add_users_table.sql

# Apply migrations to local DB
supabase db push

# Dump schema for sharing or backup
supabase db dump > schema.sql

# Reset local database (drops DB, reapplies migrations, reseeds if seed.sql exists)
supabase db reset

# Stop local Supabase stack
supabase stop

# Update Supabase CLI to latest version (recommended regularly)
npm install -g supabase@latest

# Check Supabase status & connection info
supabase status


BACKEND API:
docker compose up --build --remove-orphans

FRONTEND:
pnpm dev