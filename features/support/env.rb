require 'ruby-jmeter'
require 'factory_girl'
require_relative 'performance_helper'

World(FactoryGirl::Syntax::Methods)

# -- Set ENV Browser ---
ENV['COUNT'] 
ENV['LOOP'] 
ENV['RAMPUP']

