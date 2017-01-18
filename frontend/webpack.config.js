var webpack = require("webpack");
const ExtractTextPlugin = require('extract-text-webpack-plugin');
const ManifestPlugin = require('webpack-manifest-plugin');

var filename = '[name]-[hash]'
if (process.env.NODE_ENV !== 'production') { filename = '[name]'; }

module.exports = [{

  entry: {
    application: './src/javascripts/application.js',
    lounge: './src/javascripts/lounges.js'
  },
  output: {
    path:'../public/dist',
    filename: filename + '.js',
  },
  module: {
    loaders: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        loader: 'babel',
        query:{
          presets: ['es2015', 'es2016']
        }
      }
    ]
  },
  plugins: [
    new webpack.DefinePlugin({
      'process.env.NODE_ENV': JSON.stringify(process.env.NODE_ENV),
    }),
    new ManifestPlugin()
  ]
},

{
  entry: {
    application: './src/stylesheets/application.scss'
  },
  output: {
    path:'../public/dist',
    filename: filename + '.css',
  },
  module: {
    loaders: [
      {
        test: /\.(gif|png|jpg|woff2?|ttf|eot|svg)$/,
        loader: 'file'
      }, {
        test: /\.scss$/,
        loader: ExtractTextPlugin.extract('style-loader', 'css-loader!sass-loader')
      },
      { test: /\.svg(\?v=\d+\.\d+\.\d+)?$/, loader: 'url-loader?mimetype=image/svg+xml' },
      { test: /\.woff(\d+)?(\?v=\d+\.\d+\.\d+)?$/, loader: 'url-loader?mimetype=application/font-woff' },
      { test: /\.eot(\?v=\d+\.\d+\.\d+)?$/, loader: 'url-loader?mimetype=application/font-woff' },
      { test: /\.ttf(\?v=\d+\.\d+\.\d+)?$/, loader: 'url-loader?mimetype=application/font-woff' }
    ]
  },
  plugins: [
    new webpack.DefinePlugin({
      'process.env.NODE_ENV': JSON.stringify(process.env.NODE_ENV),
    }),
    new ExtractTextPlugin(filename + '.css'),
    new ManifestPlugin()
  ]

}]
