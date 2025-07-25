// server/db/index.js
const fs = require("fs").promises;
const client = require("./client"); // Ensure this correctly imports your database client

const seed = async () => {
  try {
    console.log("Starting database seeding from seed.sql...");
    await client.connect(); // Connect to the database
    console.log("Connected to the database.");

    const seedSqlContent = await fs.readFile("./seed.sql", "utf8");
    await client.query(seedSqlContent);
    console.log("Data inserted from seed.sql successfully!");
  } catch (error) {
    if (error.code === "23505") {
      console.warn(
        "Seed data already exists (unique constraint violation). Skipping duplicate inserts from seed.sql."
      );
    } else {
      console.error("Error executing seed.sql:", error);
      throw error; // Re-throw to indicate a critical seeding failure
    }
  } finally {
    await client.end(); // Disconnect from the database
    console.log("Database seeding process complete and client disconnected.");
  }
};

// This immediately invokes the seed function when the script is run
seed().catch((err) => {
  console.error("Fatal error during seeding:", err);
  process.exit(1); // Exit with an error code
});
