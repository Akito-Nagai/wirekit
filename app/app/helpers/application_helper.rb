module ApplicationHelper

  def webpack_path(path)
    if Rails.env.development?
      return "/dist/#{path}"
    end
    host = Rails.application.config.action_controller.asset_host
    manifest = Rails.application.config.assets.webpack_manifest
    path = manifest[path] if manifest && manifest[path].present?
    "#{host}/dist/#{path}"
  end

end
