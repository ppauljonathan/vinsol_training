# frozen_string_literal: true

require_relative 'car'
m = Car.new('benz', 'red')
m.start_engine

require_relative 'car'
m.start_engine

sleep 10

require_relative 'car'
m.start_engine
