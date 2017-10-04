require_relative '../db/sql_runner'

class Artist
  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save
    sql = 'INSERT INTO artists (name) VALUES ($1) RETURNING id;'
    values = [@name]
    @id = SQLRunner.run(sql, values)[0]['id'].to_i
  end

  def self.list_all
    sql = 'SELECT * FROM artists;'
    results = SQLRunner.run(sql, [])
    results.map { |artist_hash| Artist.new(artist_hash) }
  end

  def list_albums
    sql = 'SELECT * FROM albums WHERE artist_id = $1;'
    values = [@id]
    results = SQLRunner.run(sql, values)
    results.map { |album_hash| Album.new(album_hash) }
  end
end
