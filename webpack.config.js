const path = require('path');

module.exports = {
  entry: './src/index.coffee',
  mode: 'development',
  module: {
    rules: [
      {
        test: /node_modules\/npm\/bin\/npm-cli\.js$/,
        loaders: ['shebang', 'babel'],
      },
      {
        test: /\.coffee$/,
        loader: "coffee-loader"
      },
      {
        test: /\.css$/,
        loaders: ['style-loader', 'css-loader'],
      },
      {
        test: /\.less$/,
        loaders: ['style-loader', 'css-loader', 'less-loader'],
      },
      {
        test: /\.sass$/,
        use: [{
          loader: "style-loader"
        }, {
          loader: "css-loader"
        }, {
          loader: "sass-loader",
          options: {
            indentedSyntax: true
          }
        }]
      },

      // Images:
      {
        test: /\.png$/,
        loader: 'file-loader'
      },
      {
        test: /\.svg$/,
        loader: 'svg-inline-loader'
      },

      // Fonts:
      {
        test: /\.woff(2)?(\?v=[0-9]\.[0-9]\.[0-9])?$/,
        loader: 'url-loader?mimetype=application/font-woff'
      },
      {
        test: /\.(ttf|eot|svg)(\?v=[0-9]\.[0-9]\.[0-9])?$/,
        loader: 'file-loader'
      }
    ]
  },
  optimization: {
    minimize: false
  },
  output: {
    filename: 'bundle.js',
    path: path.resolve(__dirname, 'dist'),
    publicPath: '/dist/'
  },
  resolve: {
    extensions: [".coffee", ".js"]
  }
};
