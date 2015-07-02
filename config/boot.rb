require 'rubygems'
require 'bundler/setup'
require 'dotenv'
require 'rom-sql'

Dotenv.load

Bundler.require :default, ENV['RACK_ENV']
