namespace sap.btp.demo;
using { managed, cuid } from '@sap/cds/common';

// ─── Authors ────────────────────────────────────────────────
entity Authors : cuid, managed {
  name       : String(100) @mandatory;
  email      : String(100);
  country    : String(50);
  books      : Composition of many Books on books.author = $self;
}

// ─── Books ──────────────────────────────────────────────────
entity Books : cuid, managed {
  title      : String(150) @mandatory;
  descr      : String(1000);
  author     : Association to Authors;
  genre      : String(50);
  stock      : Integer default 0;
  price      : Decimal(9,2);
  currency   : String(3) default 'USD';
  status     : String(20) default 'AVAILABLE';
  orders     : Composition of many OrderItems on orders.book = $self;
}

// ─── Orders ─────────────────────────────────────────────────
entity Orders : cuid, managed {
  orderNo    : String(20);
  customer   : String(100) @mandatory;
  email      : String(100);
  status     : String(20) default 'PENDING';
  total      : Decimal(9,2);
  currency   : String(3) default 'USD';
  items      : Composition of many OrderItems on items.order = $self;
}

// ─── Order Items ─────────────────────────────────────────────
entity OrderItems : cuid {
  order      : Association to Orders;
  book       : Association to Books;
  quantity   : Integer default 1;
  unitPrice  : Decimal(9,2);
  netAmount  : Decimal(9,2);
}

// ─── Integration Log (BTP Integration Suite simulation) ──────
entity IntegrationLogs : cuid, managed {
  source     : String(50);
  target     : String(50);
  messageId  : String(100);
  status     : String(20) default 'SUCCESS';
  payload    : LargeString;
  direction  : String(10) default 'OUTBOUND';
}
