# SAP BTP Integration Demo — CAP + RAP + Integration Suite

Full-stack SAP BTP project demonstrating:
- **CAP (Cloud Application Programming Model)** — OData V4 services
- **RAP** — ABAP RESTful Application Programming architecture patterns
- **BTP Integration Suite** — iFlow simulation and logging
- **Fiori UI5** — Fiori Horizon theme app

## Project Structure

```
sap-btp-integration-demo/
├── db/
│   ├── schema.cds          ← CDS entities: Books, Authors, Orders, IntegrationLogs
│   └── data/               ← CSV seed data
├── srv/
│   ├── catalog-service.cds ← Read-only CatalogService (public)
│   ├── catalog-service.js  ← Handler
│   ├── admin-service.cds   ← Full CRUD + Actions (placeOrder, triggerIntegration)
│   └── admin-service.js    ← Business logic, validation, integration logging
├── app/
│   └── webapp/
│       ├── demo-standalone.html  ← Open directly in browser (no server needed)
│       └── index.html            ← Full CAP-connected Fiori app
├── mta.yaml                ← BTP Cloud Foundry deployment descriptor
├── xs-security.json        ← XSUAA roles and scopes
└── package.json
```

## Quick Start

### Option 1: Open standalone demo in browser (no install needed)
Just open `app/webapp/demo-standalone.html` in any browser.

### Option 2: Run with CAP server locally
```bash
npm install
cds watch
# → Open http://localhost:4004
```

### Option 3: Open in SAP Business Application Studio
1. Clone this project into BAS workspace
2. Open terminal → `npm install && cds watch`
3. BAS auto-exposes port 4004 with preview URL

### Option 4: Deploy to BTP Cloud Foundry
```bash
npm install -g mbt
cds build --production
mbt build
cf login
cf deploy mta_archives/*.mtar
```

## OData Endpoints (when running locally)

| Endpoint | Description |
|----------|-------------|
| `GET /catalog/Books` | All available books |
| `GET /catalog/Authors` | All authors |
| `GET /admin/Orders` | All orders (auth required) |
| `POST /admin/placeOrder` | Place a book order |
| `POST /admin/triggerIntegration` | Trigger BTP iFlow |
| `GET /admin/stockSummary()` | Stock summary by status |
| `GET /catalog/$metadata` | OData EDMX metadata |

## Technologies
- SAP CAP (CDS + Node.js)
- SAP HANA Cloud (production) / SQLite (dev)
- SAP BTP Integration Suite (iFlow simulation)
- SAP Fiori UI5 (Horizon theme)
- XSUAA for authentication
- MTA for deployment
