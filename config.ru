require "rubygems"
require "sinatra"
require "./app"

use WordpressRedirects
run Nesta::App
