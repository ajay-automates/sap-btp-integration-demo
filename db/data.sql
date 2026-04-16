-- Suppliers
INSERT INTO sap_btp_demo_Suppliers (ID, name, email, country, status, createdAt, modifiedAt) VALUES
('s001-0000-0000-0001', 'TechParts GmbH', 'contact@techparts.de', 'DEU', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('s001-0000-0000-0002', 'Global Electronics Inc', 'sales@globalelec.com', 'USA', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('s001-0000-0000-0003', 'Asia Pacific Supplies', 'info@apsupplies.sg', 'SGP', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Categories
INSERT INTO sap_btp_demo_Categories (ID, name, description) VALUES
('c001-0000-0000-0001', 'Electronics', 'Electronic components and devices'),
('c001-0000-0000-0002', 'Software Licenses', 'SAP and third-party software'),
('c001-0000-0000-0003', 'Hardware', 'Servers, laptops, and peripherals');

-- Products
INSERT INTO sap_btp_demo_Products (ID, name, description, price, currency, stock, status, supplier_ID, category_ID, createdAt, modifiedAt) VALUES
('p001-0000-0000-0001', 'SAP BTP Subscription', 'SAP Business Technology Platform license', 5000.00, 'USD', 999, 'ACTIVE', 's001-0000-0000-0002', 'c001-0000-0000-0002', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('p001-0000-0000-0002', 'Integration Suite Add-on', 'SAP Integration Suite premium package', 2500.00, 'USD', 500, 'ACTIVE', 's001-0000-0000-0002', 'c001-0000-0000-0002', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('p001-0000-0000-0003', 'Dell PowerEdge Server', 'Enterprise grade rack server', 8999.00, 'USD', 45, 'ACTIVE', 's001-0000-0000-0001', 'c001-0000-0000-0003', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('p001-0000-0000-0004', 'Fiori UX Design License', 'SAP Fiori Elements UI kit', 1200.00, 'USD', 200, 'ACTIVE', 's001-0000-0000-0002', 'c001-0000-0000-0002', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('p001-0000-0000-0005', 'Network Switch 48-port', 'Enterprise managed switch', 3400.00, 'USD', 30, 'ACTIVE', 's001-0000-0000-0003', 'c001-0000-0000-0003', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Orders
INSERT INTO sap_btp_demo_Orders (ID, orderNumber, customerName, customerEmail, status, totalAmount, currency, createdAt, modifiedAt) VALUES
('o001-0000-0000-0001', 'ORD-2026-001', 'Acme Corp', 'procurement@acme.com', 'CONFIRMED', 7500.00, 'USD', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('o001-0000-0000-0002', 'ORD-2026-002', 'Siemens AG', 'orders@siemens.de', 'PROCESSING', 17998.00, 'USD', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('o001-0000-0000-0003', 'ORD-2026-003', 'TCS Mumbai', 'purchase@tcs.com', 'DRAFT', 2500.00, 'USD', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Integration Logs (simulates iFlow execution logs)
INSERT INTO sap_btp_demo_IntegrationLogs (ID, timestamp, source, target, messageType, status, payload, errorMsg) VALUES
('l001-0000-0000-0001', CURRENT_TIMESTAMP, 'S/4HANA', 'Salesforce', 'Customer_Sync', 'SUCCESS', '{"customerId":"C001","action":"CREATE"}', NULL),
('l001-0000-0000-0002', CURRENT_TIMESTAMP, 'SuccessFactors', 'S/4HANA', 'Employee_Replication', 'SUCCESS', '{"empId":"E12345","costCenter":"CC01"}', NULL),
('l001-0000-0000-0003', CURRENT_TIMESTAMP, 'Ariba', 'S/4HANA', 'PO_Transfer', 'FAILED', '{"poNumber":"PO-9001"}', 'Connection timeout after 30s'),
('l001-0000-0000-0004', CURRENT_TIMESTAMP, 'S/4HANA', 'Ariba', 'Invoice_Push', 'SUCCESS', '{"invoiceId":"INV-2026-441"}', NULL);
