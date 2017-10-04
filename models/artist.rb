require_relative '../db/sql_runner'

class Artist
  attr_accessor :name
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def to_s
    "ID: #{@id} and Name: #{@name}."
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

  def self.delete_all
    SQLRunner.run('DELETE FROM artists;', [])
  end

  def update
    sql = 'UPDATE artists SET (name) = ($2) WHERE id = $1;'
    values = [@id, @name]
    SQLRunner.run(sql, values)
  end

  def delete
    sql = 'DELETE FROM artists WHERE id = $1;'
    values = [@id]
    SQLRunner.run(sql, values)
  end

  def self.find(match)
    sql = 'SELECT * FROM artists;'
    results = SQLRunner.run(sql, [])

    finds = results.find_all { |artist_hash| artist_hash.values.include?(match) }
    finds.map { |artist_hash| Artist.new(artist_hash) }
  end
end
