# -*- coding: utf-8 -*-

require 'sinatra/base'
require 'haml'
require 'sass'
require 'compass'

$:.unshift "#{File.dirname(__FILE__)}/lib"

class Application < Sinatra::Base

  set :haml, format: :html5, escape_html: true, attr_wrapper: '"', ugly: production?
  set :scss, Compass.sass_engine_options.merge(style: production? ? :compressed : :nested)

  configure do
    set :site_title, ENV['SITE_TITLE']
  end

  get '/' do
    haml :index
  end

  get '/*.css' do |path|
    scss path.to_sym
  end

  get '/*.html' do |path|
    pass unless File.exist?(File.join(options.views, "#{path}.haml"))
    haml path.to_sym
  end

  get '/*' do |path|
    pass unless File.exist?(File.join(options.views, "#{path}.haml"))
    haml path.to_sym
  end

end
