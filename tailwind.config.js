module.exports = {
  prefix: "kommandant-",
  content: [
    './public/*.html',
    './app/helpers/kommandant/**/*.rb',
    './app/javascript/kommandant/**/*.js',
    './app/views/kommandant/**/*.{erb,haml,html,slim}',
  ],
  theme: {
    extend: {}
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
  ],
  corePlugins: {
    preflight: false,
  }
}
