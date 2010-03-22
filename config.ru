require "rubygems"
require "sinatra"
require "app"

use WordpressRedirects
run Sinatra::Application
