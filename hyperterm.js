module.exports = {
  config: {
    updateChannel: 'canary',

    // default font size for all tabs
    fontSize: 18,

    // font family with optional fallbacks
    fontFamily: 'OperatorMono-Book, Menlo, "DejaVu Sans Mono", "Lucida Console", monospace',

    // terminal cursor background color
    // cursorColor: 'rgba(32,187,252,0.7)',

    cursorShape: 'UNDERLINE',

    // terminal background color
    backgroundColor: 'rgba(4, 9, 15, 0.8)',

    // show menu on Linux
    showHamburgerMenu: true,

    // padding: '0 0',

    windowSize: [1200, 800],

    css: '',

    termCSS: '',

    // some color overrides. see http://bit.ly/29k1iU2 for
    // the full list
    // Tomorrow Night 80s
    colors: {
      black: '#000000',
      red: '#f78d8c',
      green: '#a8d4a9',
      yellow: '#ffd479',
      blue: '#78aad6',
      magenta: '#d7acd6',
      cyan: '#76d4d6',
      white: '#ffffff',
      lightBlack: '#000000',
      lightRed: '#f78d8c',
      lightGreen: '#a8d4a9',
      lightYellow: '#ffd479',
      lightBlue: '#78aad6',
      lightMagenta: '#d7acd6',
      lightCyan: '#76d4d6',
      lightWhite: '#ffffff'
    }
  },

  plugins: [
    'hyper-simple-vibrancy'
  ]
}
