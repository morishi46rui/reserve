const { environment } = require('@rails/webpacker')

module.exports = environment

environment.toWebpackConfig().merge({
  resolve: {
    alias: {
      'jquery': 'jquery/src/jquery'
    }
  }
});