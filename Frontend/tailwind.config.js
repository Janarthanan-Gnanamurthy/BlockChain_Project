/** @type {import('tailwindcss').Config} */
export default {
  content: ['./src/**/*.{vue,js,ts}'],
  daisyui: {
    themes: ["light"],
  },
  plugins: [
    require('daisyui'),
  ],
}

