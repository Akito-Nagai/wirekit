var webpack = require("webpack");
const ExtractTextPlugin = require('extract-text-webpack-plugin');
const ManifestPlugin = require('webpack-manifest-plugin');

filename = process.env.NODE_ENV === 'production' ? '[name]-[hash]' : '[name]'

module.exports = [{

  entry: {
    application: './src/javascripts/application.js'
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
          presets: ['es2016']
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
    application: './src/stylesheets/application.css.scss'
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
      },
      {
        test: /\.scss$/,
        loader: ExtractTextPlugin.extract('style-loader', 'css-loader!sass-loader')
      }
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
