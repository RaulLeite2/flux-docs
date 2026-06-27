# Endpoints da API

Base URL: `https://api.seu-dominio.com/api/v1`

## Auth (flux-auth :8100)

| Método | Endpoint | Descrição |
|--------|----------|-----------|
| POST | /api/v1/auth/register | Cadastro |
| POST | /api/v1/auth/login | Login |
| POST | /api/v1/auth/refresh | Renovar tokens |
| POST | /api/v1/auth/logout | Revogar refresh token |

## Users (flux-api :8000)

| Método | Endpoint | Descrição |
|--------|----------|-----------|
| GET | /api/v1/users/me | Perfil atual |
| PATCH | /api/v1/users/me | Atualizar perfil |

## Servers

| Método | Endpoint | Descrição |
|--------|----------|-----------|
| POST | /api/v1/servers | Criar servidor |
| GET | /api/v1/servers | Listar servidores |
| POST | /api/v1/servers/{id}/invites | Gerar convite |

## Channels

| Método | Endpoint | Descrição |
|--------|----------|-----------|
| POST | /api/v1/channels | Criar canal |
| GET | /api/v1/channels/{server_id} | Listar canais |

## Messages

| Método | Endpoint | Descrição |
|--------|----------|-----------|
| POST | /api/v1/messages | Enviar mensagem |
| GET | /api/v1/messages/{channel_id} | Listar mensagens |

## Friends

| Método | Endpoint | Descrição |
|--------|----------|-----------|
| POST | /api/v1/friends/invite/{user_id} | Solicitar amizade |
| GET | /api/v1/friends | Listar amigos |

## Roles (RBAC)

| Método | Endpoint | Descrição |
|--------|----------|-----------|
| POST | /api/v1/roles?server_id= | Criar role |
| GET | /api/v1/roles?server_id= | Listar roles |
| POST | /api/v1/roles/{id}/assign | Atribuir role |

## Uploads

| Método | Endpoint | Descrição |
|--------|----------|-----------|
| POST | /api/v1/uploads | Upload de arquivo (max 10MB) |

## Settings

| Método | Endpoint | Descrição |
|--------|----------|-----------|
| GET | /api/v1/settings | Configurações do usuário |

## WebSocket (flux-gateway :8200)

```
ws://gateway:8200/ws?user=<user_id>
```

### Eventos enviados pelo cliente

```json
{ "type": "message",  "data": { "channel_id": "...", "content": "..." } }
{ "type": "typing",   "data": { "channel_id": "..." } }
{ "type": "notification", "data": { "target_user_id": "...", "content": "..." } }
```

### Eventos recebidos

```json
{ "type": "presence",     "user": "...", "status": "online|offline" }
{ "type": "message",      "from": "...", "data": { ... } }
{ "type": "typing",       "from": "...", "data": { ... } }
{ "type": "notification", "from": "...", "data": { ... } }
```
