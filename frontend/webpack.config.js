var webpack = require('webpack');
const ExtractTextPlugin = require('extract-text-webpack-plugin');
const ManifestPlugin = require('webpack-manifest-plugin');

var filename = '[name]-[hash]';
if (process.env.NODE_ENV !== 'production') { filename = '[name]'; }

module.exports = [{

  entry: {
    application: './src/javascripts/application.js',
    lounges: './src/javascripts/lounges.js'
  },
  output: {
    path:'../public/dist',
    filename: filename + '.js',
  },
  module: {
    preLoaders: [
       {
          test: /\.tag$/,
          exclude: /node_modules/,
          loader: 'riotjs-loader'
       }
    ],
    loaders: [
      {
        test: /\.(js|tag)$/,
        exclude: /node_modules/,
        loader: 'babel-loader',
        query: {
          presets: ['es2015-riot', 'es2015', 'es2016', 'es2017']
        }
      }
    ]
  },
  resolve: {
     extensions: ['', '.js', '.tag']
  },
  plugins: [
    new ManifestPlugin(),
    new webpack.optimize.OccurenceOrderPlugin(),
    new webpack.ProvidePlugin({ riot: 'riot' }),
    new webpack.DefinePlugin({
      'process.env.NODE_ENV': JSON.stringify(process.env.NODE_ENV),
    })
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
        test: /\.(scss|sass)$/,
        loader: ExtractTextPlugin.extract('style-loader', 'css-loader!sass-loader')
      },
      { test: /\.svg(\?v=\d+\.\d+\.\d+)?$/, loader: 'url-loader?mimetype=image/svg+xml' },
      { test: /\.woff(\d+)?(\?v=\d+\.\d+\.\d+)?$/, loader: 'url-loader?mimetype=application/font-woff' },
      { test: /\.eot(\?v=\d+\.\d+\.\d+)?$/, loader: 'url-loader?mimetype=application/font-woff' },
      { test: /\.ttf(\?v=\d+\.\d+\.\d+)?$/, loader: 'url-loader?mimetype=application/font-woff' }
    ]
  },
  plugins: [
    new ManifestPlugin(),
    new ExtractTextPlugin(filename + '.css'),
    new webpack.DefinePlugin({
      'process.env.NODE_ENV': JSON.stringify(process.env.NODE_ENV),
    })
  ]

}]
