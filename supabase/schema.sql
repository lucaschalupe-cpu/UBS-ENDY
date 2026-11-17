-- Schema inicial; revisar com profissional de segurança antes de produção.
create extension if not exists pgcrypto;
create table if not exists public.patients(
 id uuid primary key default gen_random_uuid(),
 name text not null,
 record_number text unique,
 birth_date date,
 phone text,
 status text not null default 'Ativo' check(status in('Ativo','Inativo')),
 created_by uuid not null references auth.users(id),
 created_at timestamptz not null default now()
);
alter table public.patients enable row level security;
create policy "patient_select_owner" on public.patients for select using(created_by=auth.uid());
create policy "patient_insert_owner" on public.patients for insert with check(created_by=auth.uid());
create policy "patient_update_owner" on public.patients for update using(created_by=auth.uid()) with check(created_by=auth.uid());

create table if not exists public.appointments(
 id uuid primary key default gen_random_uuid(),
 patient_id uuid not null references public.patients(id),
 appointment_date date not null,
 appointment_time time not null,
 slot_code text not null default 'A',
 status text not null default 'Agendado' check(status in('Agendado','Presente','Faltou','Cancelado')),
 created_by uuid not null references auth.users(id),
 created_at timestamptz not null default now(),
 unique(appointment_date,appointment_time,slot_code)
);
alter table public.appointments enable row level security;
create policy "appointment_select_owner" on public.appointments for select using(created_by=auth.uid());
create policy "appointment_insert_owner" on public.appointments for insert with check(created_by=auth.uid());
create policy "appointment_update_owner" on public.appointments for update using(created_by=auth.uid()) with check(created_by=auth.uid());

create table if not exists public.clinical_records(
 id uuid primary key default gen_random_uuid(),
 patient_id uuid not null references public.patients(id),
 appointment_id uuid references public.appointments(id),
 referral text, complaint text, observation text, diagnostic_hypothesis text,
 status text not null default 'Rascunho' check(status in('Rascunho','Finalizado','Retificado')),
 created_by uuid not null references auth.users(id),
 created_at timestamptz not null default now(),
 finalized_at timestamptz
);
alter table public.clinical_records enable row level security;
create policy "clinical_select_owner" on public.clinical_records for select using(created_by=auth.uid());
create policy "clinical_insert_owner" on public.clinical_records for insert with check(created_by=auth.uid());
-- Sem UPDATE/DELETE de registros clínicos nesta base inicial: retificações exigem fluxo auditável.
