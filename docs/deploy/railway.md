# Deploy no Railway

## Pré-requisitos

1. Conta no [Railway](https://railway.app)
2. CLI: `npm install -g @railway/cli`
3. Login: `railway login`

## Variáveis de Ambiente Obrigatórias

### flux-auth
```env
DATABASE_URL=postgresql+psycopg://...
REDIS_URL=redis://...
JWT_SECRET=<string longa e aleatória>
CORS_ORIGINS=https://seu-dominio.com
```

### flux-api
```env
DATABASE_URL=postgresql+psycopg://...
REDIS_URL=redis://...
JWT_SECRET=<mesma secret do auth>
CORS_ORIGINS=https://seu-dominio.com
STORAGE_BACKEND=s3
S3_ENDPOINT_URL=<url do MinIO ou S3>
S3_BUCKET_NAME=flux-uploads
S3_ACCESS_KEY=...
S3_SECRET_KEY=...
```

### flux-gateway
```env
REDIS_URL=redis://...
```

### flux-web
```env
VITE_API_URL=https://api.seu-dominio.com
VITE_AUTH_URL=https://auth.seu-dominio.com
VITE_GATEWAY_URL=wss://gateway.seu-dominio.com/ws
```

## Deploy Automatizado

Cada repositório contém `.github/workflows/deploy.yml`.
Configure o secret `RAILWAY_TOKEN` no repositório GitHub:
```
Settings → Secrets → Actions → RAILWAY_TOKEN
```

## Health Checks

Todos os serviços expõem:
- `GET /health` → liveness (sempre 200)
- `GET /health/ready` → readiness (verifica DB e Redis)
