module.exports = {
  config: {
    // default font size for all tabs
    fontSize: '18px',

    // font family with optional fallbacks
    fontFamily: '"Operator Mono Book", Menlo, "DejaVu Sans Mono", "Lucida Console", monospace',

    // terminal cursor background color
    cursorColor: '#F81CE5',

    // terminal background color
    backgroundColor: '#000',

    padding: '0 0',

    termCSS: `
     x-screen {
      -webkit-font-smoothing: subpixel-antialiased !important;
      text-rendering: optimizeLegibility;
     }
    `,

    // some color overrides. see http://bit.ly/29k1iU2 for
    // the full list
    // Tomorrow Night 80s
    colors: [
      '#000000',
      '#f78d8c',
      '#a8d4a9',
      '#ffd479',
      '#78aad6',
      '#d7acd6',
      '#76d4d6',
      '#ffffff',
      '#000000',
      '#f78d8c',
      '#a8d4a9',
      '#ffd479',
      '#78aad6',
      '#d7acd6',
      '#76d4d6',
      '#ffffff'
    ]
  },

  rows: 65,
  cols: 240,

  plugins: []
}
