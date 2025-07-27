import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";

const serverPort = process.env.PORT || 3000;
console.log(`api need to run on ${serverPort} for vite server`);
// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
  server: {
    proxy: {
      "/api": `https://plantscape-cxpu.onrender.com`,
    },
  },
});

//CRITICAL NOTE: UPDATED API TO NEW DEPLOYMENT.  ORIGINAL API WAS `https://plantscape-cxpu.onrender.com`, REVERT IF MOVING BACK TO PREVIOUS DEPLOYED SITE.
