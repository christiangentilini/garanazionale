-- Lavagna Progetti: schema Supabase.
-- Esegui tutto il file una volta in Supabase > SQL Editor.

create table if not exists public.lavagna_docs (
  collection text not null check (collection in ('items', 'people', 'cats')),
  id         text not null,
  data       jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now(),
  primary key (collection, id)
);

create or replace function public.lavagna_touch() returns trigger
language plpgsql as $$
begin
  new.updated_at := now();
  return new;
end $$;

drop trigger if exists lavagna_touch on public.lavagna_docs;
create trigger lavagna_touch before update on public.lavagna_docs
  for each row execute function public.lavagna_touch();

-- Accesso senza login: chiunque abbia l'indirizzo della pagina (e quindi la chiave pubblica) legge e scrive.
alter table public.lavagna_docs enable row level security;
grant select, insert, update, delete on public.lavagna_docs to anon;

drop policy if exists "lavagna lettura" on public.lavagna_docs;
drop policy if exists "lavagna inserimento" on public.lavagna_docs;
drop policy if exists "lavagna modifica" on public.lavagna_docs;
drop policy if exists "lavagna eliminazione" on public.lavagna_docs;
create policy "lavagna lettura"      on public.lavagna_docs for select to anon using (true);
create policy "lavagna inserimento"  on public.lavagna_docs for insert to anon with check (true);
create policy "lavagna modifica"     on public.lavagna_docs for update to anon using (true) with check (true);
create policy "lavagna eliminazione" on public.lavagna_docs for delete to anon using (true);

-- Aggiornamenti in tempo reale tra chi ha la pagina aperta.
do $$
begin
  alter publication supabase_realtime add table public.lavagna_docs;
exception when duplicate_object then null;
end $$;
