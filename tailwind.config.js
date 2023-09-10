/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./templates/*.{html,js,ts,jsx,tsx,eta}"],
  theme: {
    extend: {},
  },
  plugins: [require("@tailwindcss/typography")],
};
