// server/db/seed.js (or wherever you want to put this logic)
const fs = require("fs").promises; // Use fs.promises for async file reading
const client = require("./index"); // Assuming your pg client setup is in server/db/index.js

async function seed() {
  try {
    console.log("Starting database seeding...");

    // Read the SQL file content
    const sql = await fs.readFile("./seed.sql", "utf8");

    // Connect to the database
    await client.connect();

    // Execute the SQL commands from the file
    await client.query(sql);

    console.log("Database seeding completed successfully!");
  } catch (error) {
    console.error("Error during database seeding:", error);
    throw error; // Re-throw to indicate failure
  } finally {
    // Ensure the client is always ended
    await client.end();
  }
}

// If this script is run directly, execute the seed function
if (require.main === module) {
  seed()
    .then(() => process.exit(0))
    .catch((err) => {
      console.error("Seed script failed:", err);
      process.exit(1);
    });
}

// Export the seed function if you want to call it from another file (e.g., your main server file)
module.exports = seed;
