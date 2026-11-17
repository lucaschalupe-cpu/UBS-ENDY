# Gestão UBS - ENDY FIGUEIRA

Primeira entrega de desenvolvimento: interface responsiva, navegação, dados fictícios, cadastro demonstrativo e exportação Excel inicial.

## Atenção
Esta entrega **não é um prontuário clínico pronto para produção**. A seção de prontuários é apenas informativa. Não insira dados reais de pacientes. Ainda faltam evoluções clínicas completas, retificações auditáveis, anexos privados, relatórios PDF, agenda transacional, auditoria robusta, testes de segurança e homologação institucional.

## Executar localmente
Requisitos: Node.js 20.9+ e npm.

```bash
npm install
cp .env.example .env.local
npm run dev
```

Sem variáveis Supabase, o sistema abre em modo demonstração com dados fictícios em memória. Cadastros dessa demonstração desaparecem ao recarregar a página.

## Ativar Supabase
1. Criar projeto Supabase sob controle institucional.
2. Avaliar contrato, localização dos dados, subprocessadores, backups e requisitos LGPD.
3. Preencher `.env.local` com URL e chave pública/anon.
4. Executar `supabase/schema.sql` no SQL Editor.
5. Criar conta individual no Supabase Authentication usando e-mail e senha temporária.
6. Configurar MFA, recuperação de conta e políticas de sessão.
7. Testar as políticas RLS com contas autorizadas e não autorizadas.

O identificador de usuário textual não autentica por si só no Supabase: é necessário um e-mail administrado pela instituição. A senha deve ser cadastrada diretamente no provedor, não no código. Nunca coloque a chave `service_role` no frontend.

## Antes da produção
Exigir revisão técnica de segurança, aprovação institucional, definição de controlador/operador e finalidade, base legal, retenção, plano de incidentes, testes de backup/restauração e homologação do profissional responsável.
