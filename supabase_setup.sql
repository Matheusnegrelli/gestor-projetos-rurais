-- Cole tudo isto no Supabase: menu "SQL Editor" > "New query" > Run
create table if not exists public.registros (
  col text not null,
  id text not null,
  data jsonb not null,
  atualizado_em timestamptz default now(),
  primary key (col, id)
);
alter table public.registros enable row level security;
drop policy if exists "acesso_publico_leitura" on public.registros;
drop policy if exists "acesso_publico_escrita" on public.registros;
drop policy if exists "acesso_publico_edicao" on public.registros;
drop policy if exists "acesso_publico_exclusao" on public.registros;
create policy "acesso_publico_leitura" on public.registros for select to anon using (col in ('projetos','avaliacoes'));
create policy "acesso_publico_escrita" on public.registros for insert to anon with check (col in ('projetos','avaliacoes'));
create policy "acesso_publico_edicao" on public.registros for update to anon using (col in ('projetos','avaliacoes')) with check (col in ('projetos','avaliacoes'));
create policy "acesso_publico_exclusao" on public.registros for delete to anon using (col in ('projetos','avaliacoes'));
alter publication supabase_realtime add table public.registros;
