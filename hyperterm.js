module.exports = {
  config: {
    // default font size for all tabs
    fontSize: 18,

    // font family with optional fallbacks
    fontFamily: 'OperatorMono-Book, Menlo, "DejaVu Sans Mono", "Lucida Console", monospace',

    // terminal cursor background color
    cursorColor: 'rgba(32,187,252,0.7)',

    // terminal background color
    backgroundColor: '#000',

    padding: '0 0',

    windowSize: [1200, 800],

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

  plugins: [
    'hyperpower',
    'hyperlinks'
  ]
}
