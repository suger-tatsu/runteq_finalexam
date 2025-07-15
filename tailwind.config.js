module.exports = {
  purge: {
    content: [
      './app/**/*.html.erb',
      './app/**/*.html',
      './app/**/*.js',
      './app/assets/stylesheets/**/*.css'
    ],
    options: {
      safelist: [
        'md:hidden',
        'md:block',
        'fixed',
        'inset-y-0',
        'left-0',
        'z-50',
        'w-64',
        'bg-white',
        'shadow',
        'transform',
        '-translate-x-full',
        'transition-transform',
        'h-screen',
        'min-h-screen',
        'flex',
        'flex-1',
        'flex-col',
        'overflow-y-auto'
      ]
    }
  },
  darkMode: false,
  theme: {
    extend: {},
  },
  variants: {
    extend: {},
  },
  plugins: [],
}
  