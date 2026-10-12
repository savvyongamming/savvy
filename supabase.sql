-- Rode este script uma vez no SQL Editor do Supabase.
create table if not exists public.scores (
  id bigint generated always as identity primary key,
  created_at timestamptz not null default now(),
  name  text not null check (char_length(name) between 2 and 24),
  age   int  not null check (age between 6 and 110),
  topic text not null check (char_length(topic) between 1 and 20),
  mode  int  not null check (mode in (4,7,10)),
  pct   int  not null check (pct between 0 and 100),
  title text not null check (char_length(title) between 1 and 30)
);
create index if not exists scores_rank_idx on public.scores (topic, mode, pct desc, created_at);

alter table public.scores enable row level security;
create policy "ler ranking" on public.scores for select to anon using (true);
create policy "enviar pontuacao" on public.scores for insert to anon with check (true);
grant select, insert on public.scores to anon;
