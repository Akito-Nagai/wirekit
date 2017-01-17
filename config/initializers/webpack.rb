Rails.application.config.assets.webpack_manifest =
  if File.exist?(Rails.root.join('public', 'dist', 'webpack-manifest.json'))
    JSON.parse(File.read(Rails.root.join('public', 'dist', 'webpack-manifest.json')))
  end
