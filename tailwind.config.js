/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
      "./src/main/webapp/WEB-INF/views/*.jsp",
      "./src/main/webapp/WEB-INF/views/Components/*.jsp",
      "./src/main/webapp/WEB-INF/views/Pages/*.jsp",
      "./src/main/webapp/WEB-INF/views/template.html",
      "./src/main/resources/static/*.html"
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}

