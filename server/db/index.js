require("dotenv").config(); // THIS MUST BE THE VERY FIRST LINE HERE!

const fs = require("fs").promises;
const client = require("./client"); // Import the actual client instance
const path = require("path");

// Renamed to _seed internally to clearly show it's the core logic
// It takes a parameter to decide if it should manage its own connection
const _seed = async (shouldConnectAndDisconnect = true) => {
  try {
    console.log("Starting database seeding from seed.sql...");
    // This console.log will now show the correct DATABASE_URL
    console.log("DATABASE_URL being used:", process.env.DATABASE_URL);

    if (shouldConnectAndDisconnect) {
      await client.connect(); // Only connect if this is a standalone run
      console.log("Connected to the database.");
    }

    const seedSqlPath = path.join(__dirname, "seed", "seed.sql");
    const seedSqlContent = await fs.readFile(seedSqlPath, "utf8");
    await client.query(seedSqlContent);
    console.log("Data inserted from seed.sql successfully!");
  } catch (error) {
    if (error.code === "23505") {
      console.warn(
        "Seed data already exists (unique constraint violation). Skipping duplicate inserts from seed.sql."
      );
    } else {
      console.error("Error executing seed.sql:", error);
      throw error;
    }
  } finally {
    if (shouldConnectAndDisconnect) {
      await client.end(); // Only disconnect if this was a standalone run
      console.log("Database seeding process complete and client disconnected.");
    }
  }
};

// Export client and the _seed function (renamed for clarity)
module.exports = {
  client,
  seed: _seed, // Export it as 'seed'
};

// This block ensures _seed is called with `true` (connect/disconnect)
// ONLY when this file is run directly (e.g., via `npm run seed`)
if (require.main === module) {
  _seed(true) // Run with connect/disconnect
    .catch((err) => {
      console.error("Fatal error during standalone seeding:", err);
      process.exit(1);
    });
}
