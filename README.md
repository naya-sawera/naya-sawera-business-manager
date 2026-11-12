# Naya Sawera Halla — Cloud Business Manager v2.0

A mobile-friendly browser app scaffold using Supabase Auth + Postgres. It supports general bookkeeping and non-hazardous goods (e.g. seeds, tools and ordinary shop supplies). It does not support pesticide sales, use, storage or distribution workflows.

## What is included
- `index.html` — browser app
- `schema.sql` — database tables and Row Level Security policies
- Supabase email/password sign-in and account creation
- Cloud-backed general inventory, customer list, invoices and expenses
- PKR summaries and responsive dark UI

## Setup
1. Create a Supabase project at https://supabase.com/.
2. In the Supabase Dashboard, open **SQL Editor**, paste `schema.sql`, and run it.
3. In **Project Settings → API** (or API Keys), copy the Project URL and the **anon/public** key (or publishable key). Never use a `service_role` or secret key in the browser.
4. Open `index.html` in a browser. Enter the Project URL and anon/public key on the first setup screen.
5. Create an account with an email address and password. If email confirmation is enabled, confirm the email before signing in.
6. Deploy `index.html` to a static HTTPS host to access it from other devices. Each device uses the same Supabase project and account.

## Important security and deployment notes
- Row Level Security is enabled. Each signed-in user can only access rows whose `owner_id` matches their authenticated user ID.
- Keep your Supabase project URL and anon/public key in the app; do not place a service-role/secret key in client code.
- For a real production deployment, enable email confirmation, configure password reset and SMTP, restrict Auth redirect URLs to your deployed domain, and review Supabase Auth rate limits.
- Back up your Supabase database regularly.
- The browser app is a starter implementation, not a certified accounting, tax, or invoicing product.
- The app requires internet access and the Supabase project to be active. It is not an offline-first app.
- Existing v1 browser records are not automatically migrated. Export/retain your v1 backup separately.

## Current limitations
- Invoice lines are entered as a single general-goods description and amount.
- No PDF generator, payment gateway, staff roles, or automated tax calculations yet.
- This app is intentionally limited to general bookkeeping and non-hazardous inventory.
