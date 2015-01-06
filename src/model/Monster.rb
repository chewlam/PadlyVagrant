
class Monster

  ELEMENTS = { 0 => 'Fire', 1 => 'Water', 2 => 'Wood', 3 => 'Light', 4 => 'Dark'}
  TYPES = { 0 => 'Evo Material', 1 => 'Balanced', 2 => 'Physical', 3 => 'Healer', 4 => 'Dragon', 5 => 'God', 6 => 'Attacker', 7 => 'Devil', 12 => 'Awoken Skill Material', 13 => 'Protected', 14 => 'Enhance Material'};

  def initialize
    @padly = MongoPad.instance.db['monsters']
  end

  def find(query, sort=nil)

    query['jp_only'] = false unless query['jp_only']
    query['name'] = /#{query['name']}/i if query['name']
    %w(element type).select{|f| query[f]}.each do |field|
      value = [query[field]]
      value = {:$in => value}

      sub = field + '_sub'
      query[:$and] = [] unless query[:$and] 
      query[:$and] << {:$or => [{field => value}, {sub => value}]}
      query.delete(field)
    end

    rows = @padly.find(query).to_a
    clean_output(rows)
  end

  def find_all
    find({})
  end

  def find_by_id(id)
    id = id.to_i
    find({'monster_id' => id})
  end

  def clean_output(rows)
    rows.map do |row|
      row.delete('_id') if row['_id']
      row.delete('name_jp') if row['name_jp']
      row
    end if rows.count > 0
  end

end

