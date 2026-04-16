const cds = require('@sap/cds');

module.exports = class CatalogService extends cds.ApplicationService {
  async init() {
    await super.init();

    // Log all reads for demo purposes
    this.before('READ', 'Books', (req) => {
      console.log(`[CatalogService] Reading Books - User: ${req.user?.id || 'anonymous'}`);
    });
  }
};
