import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";

const serverPort = process.env.PORT || 3000;
console.log(`api need to run on ${serverPort} for vite server`);

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
  server: {
    proxy: {
      // Use an environment variable for the API proxy target.
      // In local development, you'll set VITE_APP_API_BASE_URL in a .env file.
      // Example: VITE_APP_API_BASE_URL=https://your-backend-dev.onrender.com
      "/api": "https://plantscape-2aqa.onrender.com",
    },
  },
});

//CRITICAL NOTE: UPDATED API TO NEW DEPLOYMENT.  ORIGINAL API WAS `https://plantscape.onrender.com`, REVERT IF MOVING BACK TO PREVIOUS DEPLOYED SITE.
//webservices: https://plantscape-2aqa.onrender.com

//CRITICAL NOTE: WE CURRENTLY HAVE THE API HARDCODED HERE WHICH IS NOT IDEAL. LETS KEEP THIS STRATEGY FOR NOW BECAUSE WE DONT ALL HAVE DOTENV WORKING
//PREVIOUS CODE SNIPPET: '/api': `https://plantscape.onrender.com`

//CURRENT CODE SNIPPET:
// "/api": "https://plantscape-2aqa.onrender.com",
//FUTURE OPTIMIZATION:
//  "/api":
//         process.env.VITE_APP_API_BASE_URL ||
//         `http://localhost:${serverPort || 3000}`

//client/.env <--- create this file on your local to contain: VITE_APP_API_BASE_URL=https://plantscape-2aqa.onrender.com

//THIS CONFIG WILL ALLOW FOR FLEXIBILITY IN WORKING IN THE LOCAL SERVER FOR DEBUGGING.
// IT REQUIRES A LOCAL .ENV FILE IN CLIENT/.ENV
// (DONE BY COMMENTING OUT THE VITE_APP_API_BASE_URL VARIABLE IN YOUR CLIENT/.ENV FILE)
// OR BY DEFAULT USING THE WEB SERVICES API. SINCE WE DONT ALL HAVE DOTENV WORKING, LETS HOLD OFF ON THIS CHANGE.
