require 'mongo'

class MongoPad
  include Mongo

  attr_reader :db, :conn

  def initialize
    @conn = MongoClient.new(ENV["MONGODB_PORT_27017_TCP_ADDR"], ENV["$MONGODB_PORT_27017_TCP_PORT"])
    @db = conn.db('padly')
  end

  @@instance = MongoPad.new
  
  def self.instance
    @@instance
  end
  
  def self.collections
    @@instance.db.collection_names
  end

  def self.databases
    @@instance.conn.database_names
  end

  def self.insert(collection, row)
    begin
      @@instance.db[collection].insert row
    rescue Exception => e
      puts "Error inserting into #{name.to_s}"
      puts JSON.generate row
      raise e
    end
  end

  def self.drop_collection(collection)
    @@instance.db[collection].drop
  end

end

