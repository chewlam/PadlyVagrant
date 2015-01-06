require File.dirname(__FILE__)+'/../Application'

require 'sinatra/base'
require 'json'

require MODEL+'/MongoPad'
require MODEL+'/Monster'


require SERVER+'/AdminServer'
require SERVER+'/PadlyServer'

run Rack::URLMap.new('/' => PadlyServer.new,
                     '/admin' => AdminServer.new)

