-- Level Up sync storage.
-- Lives in its own private schema (levelup), which the public API cannot reach directly.
-- Each device holds a random 32-character sync code; only a SHA-256 hash of the code is stored.
-- The app reads and writes only through the two functions below.

create extension if not exists pgcrypto with schema extensions;

create schema if not exists levelup;
revoke all on schema levelup from public, anon, authenticated;

create table levelup.docs (
  key_hash   text        not null,
  doc_id     text        not null,
  body       jsonb       not null,
  updated_at timestamptz not null default now(),
  primary key (key_hash, doc_id),
  constraint docs_doc_id_format check (doc_id ~ '^(tasks|d-[0-9]{4}-[0-9]{2}-[0-9]{2})$')
);
comment on table levelup.docs is 'Level Up habit tracker: synced task lists and day check-ins, keyed by a hashed sync code.';

alter table levelup.docs enable row level security;
revoke all on table levelup.docs from public, anon, authenticated;

-- Read every document saved under a sync code.
create function public.levelup_pull(sync_key text)
returns table (doc_id text, body jsonb, updated_at timestamptz)
language plpgsql
security definer
set search_path = ''
as $$
begin
  if sync_key is null or sync_key !~ '^[A-Za-z0-9]{32,64}$' then
    raise exception 'invalid sync key' using errcode = '22023';
  end if;
  return query
    select d.doc_id, d.body, d.updated_at
    from levelup.docs d
    where d.key_hash = encode(extensions.digest(sync_key, 'sha256'), 'hex');
end;
$$;

-- Save one document (the task list, or one day) under a sync code. Last write wins.
create function public.levelup_push(sync_key text, doc text, data jsonb)
returns timestamptz
language plpgsql
security definer
set search_path = ''
as $$
declare
  h  text;
  ts timestamptz := now();
begin
  if sync_key is null or sync_key !~ '^[A-Za-z0-9]{32,64}$' then
    raise exception 'invalid sync key' using errcode = '22023';
  end if;
  if doc is null or doc !~ '^(tasks|d-[0-9]{4}-[0-9]{2}-[0-9]{2})$' then
    raise exception 'invalid document id' using errcode = '22023';
  end if;
  if data is null or jsonb_typeof(data) <> 'object' or octet_length(data::text) > 65536 then
    raise exception 'invalid document body' using errcode = '22023';
  end if;
  h := encode(extensions.digest(sync_key, 'sha256'), 'hex');
  if not exists (select 1 from levelup.docs d where d.key_hash = h and d.doc_id = doc)
     and (select count(*) from levelup.docs d where d.key_hash = h) >= 4000 then
    raise exception 'too many documents for this sync code' using errcode = '54000';
  end if;
  insert into levelup.docs (key_hash, doc_id, body, updated_at)
  values (h, doc, data, ts)
  on conflict (key_hash, doc_id) do update
    set body = excluded.body, updated_at = excluded.updated_at;
  return ts;
end;
$$;

comment on function public.levelup_pull(text) is 'Level Up habit tracker sync (separate from the rest of this project).';
comment on function public.levelup_push(text, text, jsonb) is 'Level Up habit tracker sync (separate from the rest of this project).';

revoke execute on function public.levelup_pull(text) from public, anon, authenticated;
revoke execute on function public.levelup_push(text, text, jsonb) from public, anon, authenticated;
grant execute on function public.levelup_pull(text) to anon, authenticated;
grant execute on function public.levelup_push(text, text, jsonb) to anon, authenticated;
