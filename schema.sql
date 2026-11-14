-- Naya Sawera Halla Cloud Business Manager v2.0
-- Run this entire script in Supabase Dashboard > SQL Editor.
-- Scope: general bookkeeping and non-hazardous inventory only.

create extension if not exists pgcrypto;

create table if not exists public.products (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  name text not null,
  category text not null check (category in ('Seeds','Tools','General goods','Other')),
  quantity integer not null default 0 check (quantity >= 0),
  unit_cost numeric(12,2) not null default 0 check (unit_cost >= 0),
  unit_price numeric(12,2) not null default 0 check (unit_price >= 0),
  created_at timestamptz not null default now()
);
create table if not exists public.customers (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  name text not null,
  phone text,
  notes text,
  created_at timestamptz not null default now()
);
create table if not exists public.invoices (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  invoice_number text not null,
  invoice_date date not null default current_date,
  customer_name text not null,
  description text not null,
  quantity integer not null check (quantity > 0),
  unit_price numeric(12,2) not null check (unit_price >= 0),
  total numeric(12,2) not null check (total >= 0),
  created_at timestamptz not null default now()
);
create table if not exists public.expenses (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  expense_date date not null default current_date,
  category text not null check (category in ('Rent','Utilities','Transport','Staff','Other')),
  note text,
  amount numeric(12,2) not null check (amount > 0),
  created_at timestamptz not null default now()
);

alter table public.products enable row level security;
alter table public.customers enable row level security;
alter table public.invoices enable row level security;
alter table public.expenses enable row level security;

drop policy if exists "owner manages products" on public.products;
create policy "owner manages products" on public.products
for all to authenticated using (owner_id = auth.uid()) with check (owner_id = auth.uid());

drop policy if exists "owner manages customers" on public.customers;
create policy "owner manages customers" on public.customers
for all to authenticated using (owner_id = auth.uid()) with check (owner_id = auth.uid());

drop policy if exists "owner manages invoices" on public.invoices;
create policy "owner manages invoices" on public.invoices
for all to authenticated using (owner_id = auth.uid()) with check (owner_id = auth.uid());

drop policy if exists "owner manages expenses" on public.expenses;
create policy "owner manages expenses" on public.expenses
for all to authenticated using (owner_id = auth.uid()) with check (owner_id = auth.uid());

grant usage on schema public to authenticated;
grant select, insert, update, delete on public.products, public.customers, public.invoices, public.expenses to authenticated;
