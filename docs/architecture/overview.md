# Arquitetura do Flux

## Visão Geral

O Flux é construído como um conjunto de microsserviços independentes:

```
                  ┌──────────────────────────────────────────────────┐
                  │                   CLIENT                         │
                  │    flux-web (React + Vite)    Electron Desktop   │
                  └───────────┬───────────────────────────┬──────────┘
                              │ REST                      │ WebSocket
                    ┌─────────▼──────────┐     ┌──────────▼──────────┐
                    │     flux-api       │     │   flux-gateway      │
                    │  REST API domínio  │     │  WebSocket Gateway  │
                    │  :8000             │     │  :8200              │
                    └─────────┬──────────┘     └──────────┬──────────┘
                              │                           │
                    ┌─────────▼──────────┐               │
                    │    flux-auth       │◄──────────────┘
                    │  JWT / Auth        │
                    │  :8100             │
                    └─────────┬──────────┘
                              │
              ┌───────────────┼────────────────┐
              │               │                │
      ┌───────▼──────┐ ┌──────▼─────┐ ┌───────▼──────┐
      │  PostgreSQL  │ │   Redis    │ │    MinIO     │
      │  dados       │ │  cache /   │ │  uploads     │
      │  relacionais │ │  presença  │ │  (S3-compat) │
      └──────────────┘ └────────────┘ └──────────────┘
```

## Repositórios

| Repo | Porta | Responsabilidade |
|------|-------|-----------------|
| flux-web | 3000 (prod) / 5173 (dev) | React SPA + Electron |
| flux-api | 8000 | REST API de domínio |
| flux-auth | 8100 | Autenticação, JWT, refresh |
| flux-gateway | 8200 | WebSocket realtime |
| flux-database | — | Schema SQL + compose infra |
| flux-docs | 8300 | Documentação |

## Fluxo de Autenticação

```
1. Usuário chama POST /api/v1/auth/register (flux-auth)
2. Recebe access_token (15 min) + refresh_token (7 dias)
3. Usa access_token no header Authorization: Bearer <token>
4. flux-api valida localmente o JWT (sem chamar flux-auth)
5. Ao expirar: POST /api/v1/auth/refresh (flux-auth)
6. Logout: POST /api/v1/auth/logout revoga refresh_token no Redis
```

## Fluxo WebSocket

```
1. Cliente conecta em ws://gateway:8200/ws?user=<user_id>
2. Gateway autentica via token query param
3. Evento presence:online broadcast para todos
4. Mensagens roteadas por canal_id
5. Typing indicators broadcast por canal
6. Disconnect: presence:offline broadcast
```
