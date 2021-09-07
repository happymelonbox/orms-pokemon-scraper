require 'pry'
class Pokemon

    attr_accessor :name, :type
    attr_reader :db, :id
    def initialize(name:, type:, db:, id: nil)
        @name = name
        @type = type
        @db = db
        @id = id
    end

    def self.save(name, type, db)
            sql = <<-SQL
            INSERT INTO pokemon(name, type)
            VALUES (?,?);
            SQL
            db.execute(sql, name, type)
            id = "SELECT last_insert_rowid() FROM pokemon"
            @id = db.execute(id)[0][0]
    end

    def self.find(id_number, db)
        sql = <<-SQL
        SELECT * FROM pokemon
        WHERE id = ?
        LIMIT 1
        SQL
        pokemon = db.execute(sql, id_number)[0]
        new_pokemon = self.new(id: pokemon[0], name: pokemon[1], type: pokemon[2], db: db)
        new_pokemon
    end
end
