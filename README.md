# Crossmint NFT System (Cloudflare Worker + D1)

Turn‑key API for collections, creators, vendors, subscriptions, and minting via Crossmint.

## Quick start

```bash
# 1) Install deps
npm i

# 2) Create a D1 database and bind it
wrangler d1 create toiaf-crossmint
# Copy the database_id into wrangler.toml (under [[d1_databases]])

# 3) Run migrations
npm run migrate

# 4) Set secrets
wrangler secret put CROSSMINT_CLIENT_SECRET
wrangler secret put CROSSMINT_PROJECT_ID   # or set as var if not secret
wrangler secret put SERVICE_AUTH_TOKEN     # optional simple bearer for POSTs

# 5) Dev
npm run dev
```

The worker exposes these endpoints:

- `GET /` → health
- `GET,POST /api/collections` → list or create a collection (provisions at Crossmint and stores locally)
- `GET,POST /api/vendors` → manage vendor records
- `GET,POST /api/creators` → manage creators
- `GET,POST /api/subscriptions` → manage subscriptions (simple example table)
- `POST /api/mint` → mint NFT(s) via Crossmint

### Example curl

```bash
# Create vendor
curl -X POST $URL/api/vendors -H "Authorization: Bearer $SERVICE_AUTH_TOKEN" -H "content-type: application/json" -d '{"slug":"topnotch","display_name":"TopNotch","payout_address":"0x..."}'

# Create creator
curl -X POST $URL/api/creators -H "Authorization: Bearer $SERVICE_AUTH_TOKEN" -H "content-type: application/json" -d '{"username":"toiaf","display_name":"TOIAF"}'

# Create collection
curl -X POST $URL/api/collections -H "Authorization: Bearer $SERVICE_AUTH_TOKEN" -H "content-type: application/json" -d '{"name":"TOIAF Genesis","chain":"polygon","metadata_uri":"ipfs://..."}'

# Mint
curl -X POST $URL/api/mint -H "Authorization: Bearer $SERVICE_AUTH_TOKEN" -H "content-type: application/json" -d '{"collection_id":1,"recipient":"email:someone@example.com","quantity":1,"metadata":{"name":"Badge #1"}}'
```

### Notes

- This is a **starter** — flesh out auth/validation, error handling, and webhook handling per your needs.
- Crossmint API paths may evolve; adjust `src/utils/crossmint.js` accordingly.
- Prefer to keep `CROSSMINT_CLIENT_SECRET` as a secret (via `wrangler secret`).

### License

MIT
