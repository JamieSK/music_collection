require_relative '../db/sql_runner'

class Album
  attr_accessor :artist_id, :title, :genre

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @artist_id = options['artist_id']
    @title = options['title']
    @genre = options['genre']
  end

  def to_s
    "ID: #{@id}, Artist ID: #{@artist_id}, Title: #{@title} and Genre: #{@genre}."
  end

  def save
    sql = 'INSERT INTO albums (artist_id, title, genre)
    VALUES ($1, $2, $3) RETURNING id;'
    values = [@artist_id, @title, @genre]
    @id = SQLRunner.run(sql, values)[0]['id'].to_i
  end

  def self.list_all
    sql = 'SELECT * FROM albums;'
    results = SQLRunner.run(sql, [])
    results.map { |album_hash| Album.new(album_hash) }
  end

  def artist
    sql = 'SELECT * FROM artists WHERE id = $1;'
    values = [@artist_id]
    result = SQLRunner.run(sql, values)
    Artist.new(result[0])
  end

  def self.delete_all
    SQLRunner.run('DELETE FROM albums;', [])
  end

  def update
    sql = 'UPDATE albums SET (artist_id, title, genre) = ($2,$3,$4) WHERE id = $1;'
    values = [@id, @artist_id, @title, @genre]
    SQLRunner.run(sql, values)
  end

  def delete
    sql = 'DELETE FROM albums WHERE id = $1;'
    values = [@id]
    SQLRunner.run(sql, values)
  end

  def self.find(match)
    sql = 'SELECT * FROM albums;'
    results = SQLRunner.run(sql, [])

    finds = results.find_all { |album_hash| album_hash.values.include?(match) }
    finds.map { |album_hash| Album.new(album_hash) }
  end
end
