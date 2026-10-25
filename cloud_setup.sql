-- Run in Supabase SQL Editor for your OWN project.
create table if not exists public.finance_data (
  user_id uuid primary key references auth.users(id) on delete cascade,
  data jsonb not null,
  updated_at timestamptz not null default now()
);
alter table public.finance_data enable row level security;
revoke all on public.finance_data from anon;
grant select, insert, update, delete on public.finance_data to authenticated;
create policy "read own finance" on public.finance_data for select to authenticated using ((select auth.uid()) = user_id);
create policy "insert own finance" on public.finance_data for insert to authenticated with check ((select auth.uid()) = user_id);
create policy "update own finance" on public.finance_data for update to authenticated using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
create policy "delete own finance" on public.finance_data for delete to authenticated using ((select auth.uid()) = user_id);
