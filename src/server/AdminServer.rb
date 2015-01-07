require 'open-uri'

class AdminServer < Sinatra::Base
  set :root, ROOT

  get '/' do
    erb :mongo
  end


  get '/mongo/collections' do
    content_type :json
    MongoPad.collections.to_json
  end

  get '/mongo/databases' do
    content_type :json
    MongoPad.databases.to_json
  end

  def handle_data(data_type, data_set) 
    ret = JSON.parse data_set
    new_ret = []
    case data_type
      when :evolutions
        ret.each do |row|
          new_ret << { :monster_id => row[0], :evolutions => row[1]} 
        end
      when :skillups
        ret['monsters'].each do |monster_id, skillup_ids|
          new_ret << { :monster_id => monster_id, :skillup_monster_ids => skillup_ids }
        end
      when :monsters
        @monster_images = {}
        padherderUrl = "https://www.padherder.com";
        pdxImgUrl = "http://www.puzzledragonx.com/en/img/monster/";

        elements = Monster::ELEMENTS
        types = Monster::TYPES

        ret.each do |row|
          monster_id = row['id']
          row['monster_id'] = monster_id
          @monster_images["#{monster_id}.60x60.png"] = "#{padherderUrl}#{row["image60_href"]}"
          @monster_images["#{monster_id}.40x40.png"] = "#{padherderUrl}#{row["image40_href"]}"
          @monster_images["#{monster_id}.full.png"] = "#{pdxImgUrl}MONS_#{monster_id}.jpg"
          row['type_sub'] = row['type2'] || nil
          row['element_sub'] = row['element2'] || nil
          row.delete 'id'
          row.delete 'element2'
          row.delete 'type2'
        end
    end

    new_ret.count > 0 ? new_ret : ret

  end

  post '/mongo/setup' do
    data = {
      :active_skills => 'https://www.padherder.com/api/active_skills/',
      :awakenings => 'https://www.padherder.com/api/awakenings/',
      :evolutions => 'https://www.padherder.com/api/evolutions/',
      :leader_skills => 'https://www.padherder.com/api/leader_skills/',
#      :materials => 'https://www.padherder.com/api/materials/',
      :monsters => 'https://www.padherder.com/api/monsters/',
      :skillups => 'https://www.padherder.com/api/food/'
    }

    data.each do |name, url|
      puts "Processing #{name}"
      MongoPad.drop_collection(name.to_s)

      file = open url
      file_data = file.read
      file_data = handle_data(name, file_data)
      file_data.each do |row|
        MongoPad.insert(name.to_s, row)
      end
    end

    "OK"
  end
end

