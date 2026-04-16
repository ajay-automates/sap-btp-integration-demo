using sap.btp.demo as db from '../db/schema';

// ─── Catalog Service (Read-Only Public) ──────────────────────
@path: '/catalog'
service CatalogService {

  @readonly
  entity Books as projection on db.Books {
    *,
    author.name as authorName,
    author.country as authorCountry
  } where status != 'DISCONTINUED';

  @readonly
  entity Authors as projection on db.Authors;
}

// ─── Admin Service (Full CRUD) ───────────────────────────────
@path: '/admin'
@requires: 'authenticated-user'
service AdminService {

  entity Books   as projection on db.Books;
  entity Authors as projection on db.Authors;
  entity Orders  as projection on db.Orders;
  entity OrderItems as projection on db.OrderItems;
  entity IntegrationLogs as projection on db.IntegrationLogs;

  // Custom action to place an order
  action placeOrder(
    bookId    : UUID,
    quantity  : Integer,
    customer  : String,
    email     : String
  ) returns Orders;

  // Custom action to trigger integration (simulate BTP Integration Suite)
  action triggerIntegration(
    source  : String,
    target  : String,
    payload : String
  ) returns IntegrationLogs;

  // Function to get stock summary
  function stockSummary() returns array of {
    status : String;
    count  : Integer;
  };
}
