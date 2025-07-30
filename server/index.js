require("dotenv").config(); // MUST be at the very top!
const { client, seed } = require("./db");

const express = require("express");
const app = express();
const cors = require("cors"); // NEW: Import cors middleware for deployment
const path = require("path"); // NEW: Import path for potential static serving or fallback on deployment

// NEW: CORS Middleware - IMPORTANT: Configure this before your routes
// For production, it's best to specify the exact origin of your frontend:
app.use(
  cors({
    origin: "https://plantscape-cxpu.onrender.com", // Replace with your actual frontend URL
    credentials: true, // If you're sending cookies or authorization headers
  })
);

app.use(express.json());

// Content-Security-Policy - Ensure this is permissive enough for all your assets
// The previous CSP was quite restrictive. This one is a bit more open for common cases.
// If you have specific external domains for images/scripts, you'll need to add them.
app.use((req, res, next) => {
  res.setHeader(
    "Content-Security-Policy",
    "default-src 'self'; " +
      "img-src 'self' data: https:; " + // Allows images from self, data URIs, and any https source
      "script-src 'self' 'unsafe-inline' 'unsafe-eval'; " + // 'unsafe-inline' and 'unsafe-eval' are often needed for development/some libraries, but review for production
      "style-src 'self' 'unsafe-inline' https:; " + // Allows styles from self, inline, and any https source
      "font-src 'self' https:; " + // Allows fonts from self and any https source
      "connect-src 'self' https://plantscape-2aqa.onrender.com; " + // Explicitly allow connections to your backend
      "object-src 'none';" // Disallow <object>, <embed>, <applet>
  );
  next();
});

//REPLACED THIS CODE WITH ABOVE
// app.use((req, res, next) => {
//   res.setHeader(
//     "Content-Security-Policy",
//     "default-src 'self'; img-src 'self' https:; script-src 'self'; style-src 'self' 'unsafe-inline'; font-src 'self' https:;"
//   );
//   next();
// });

app.use("/api", require("./api"));

// Optional: A simple root route for your backend's base URL
app.get("/", (req, res) => {
  res.send("Welcome to the PlantScape API!");
});

// Serve static assets from the 'dist' folder (if you were serving frontend from backend)
// This is commented out because your frontend is a separate Static Site on Render.
// app.use(express.static(path.join(__dirname, '..', 'dist')));

// Error handling middleware
app.use((err, req, res, next) => {
  console.error(err);
  res.status(err.status || 500).send(err.message || "Internal server error.");
});

const init = async () => {
  // Chelsea's comment
  // const PORT = process.env.PORT || 10000; // Render sets PORT to 10000 by default
  const PORT = process.env.PORT || 3000; // Local port is set to 3000 by default (Render sets PORT to 10000 by default)
  await client.connect();
  console.log("connected to database");

  // Now call seed *without* it connecting/disconnecting itself
  // Pass false to indicate the connection is already managed by Server/index.js
  await seed(false); // Pass false so it doesn't try to connect/disconnect again

  app.listen(PORT, () => {
    console.log(`listening on port ${PORT}`);
  });
};
init();
