require_relative "../config/application"
require "rake"
Rails.application.load_tasks

ThemizerSpec = Module.new()

def precompiled_css(name)
  precompiled_css_path = "public/" + ActionController::Base.helpers.asset_path("#{name}.css")
  precompiled_css_content = open(precompiled_css_path).read
  precompiled_css_content = precompiled_css_content
    .gsub(/\/\*.*\*\/\n/, "")
    .gsub("\n\n", "\n")
    .strip
  precompiled_css_content << "\n" if precompiled_css_content[-1] != "\n"
  precompiled_css_content
end

def fixture_css(name)
  open("spec/fixtures/stylesheets/#{name}.css").read
end
