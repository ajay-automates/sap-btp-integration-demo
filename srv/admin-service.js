const cds = require('@sap/cds');

module.exports = class AdminService extends cds.ApplicationService {
  async init() {
    await super.init();

    const { Books, Orders, OrderItems, IntegrationLogs } = this.entities;

    // ── Before CREATE Books: validate stock ──────────────────
    this.before('CREATE', Books, (req) => {
      if (req.data.stock < 0) {
        req.error(400, 'Stock cannot be negative');
      }
      if (!req.data.price || req.data.price <= 0) {
        req.error(400, 'Price must be greater than 0');
      }
    });

    // ── After UPDATE Books: update status based on stock ─────
    this.after('UPDATE', Books, async (book, req) => {
      if (book.stock === 0) {
        await UPDATE(Books).set({ status: 'OUT_OF_STOCK' }).where({ ID: book.ID });
      } else if (book.stock <= 5) {
        await UPDATE(Books).set({ status: 'LOW_STOCK' }).where({ ID: book.ID });
      } else {
        await UPDATE(Books).set({ status: 'AVAILABLE' }).where({ ID: book.ID });
      }
    });

    // ── Action: placeOrder ────────────────────────────────────
    this.on('placeOrder', async (req) => {
      const { bookId, quantity, customer, email } = req.data;

      // Read the book
      const book = await SELECT.one.from(Books).where({ ID: bookId });
      if (!book) return req.error(404, `Book ${bookId} not found`);
      if (book.stock < quantity) return req.error(400, `Insufficient stock. Available: ${book.stock}`);

      const netAmount = book.price * quantity;
      const orderNo = `ORD-${Date.now()}`;

      // Create order
      const order = await INSERT.into(Orders).entries({
        orderNo,
        customer,
        email,
        status: 'PENDING',
        total: netAmount,
        currency: book.currency
      });

      // Create order item
      await INSERT.into(OrderItems).entries({
        order_ID: order.ID || orderNo,
        book_ID: bookId,
        quantity,
        unitPrice: book.price,
        netAmount
      });

      // Reduce stock
      await UPDATE(Books).set({ stock: book.stock - quantity }).where({ ID: bookId });

      // Log integration event (simulate BTP Integration Suite outbound)
      await INSERT.into(IntegrationLogs).entries({
        source: 'CAP-OrderService',
        target: 'S4HANA-SD',
        messageId: `MSG-${Date.now()}`,
        status: 'SUCCESS',
        direction: 'OUTBOUND',
        payload: JSON.stringify({ orderNo, customer, bookId, quantity, total: netAmount })
      });

      return { orderNo, customer, total: netAmount, status: 'PENDING' };
    });

    // ── Action: triggerIntegration (BTP Integration Suite sim) ─
    this.on('triggerIntegration', async (req) => {
      const { source, target, payload } = req.data;

      const log = await INSERT.into(IntegrationLogs).entries({
        source,
        target,
        messageId: `IFLOW-${Date.now()}`,
        status: 'SUCCESS',
        direction: 'OUTBOUND',
        payload
      });

      console.log(`[BTP Integration] iFlow triggered: ${source} → ${target}`);
      return log;
    });

    // ── Function: stockSummary ────────────────────────────────
    this.on('stockSummary', async () => {
      const result = await SELECT
        .from(Books)
        .columns('status', { count: 'ID', as: 'count' })
        .groupBy('status');
      return result;
    });
  }
};
