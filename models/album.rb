require_relative '../db/sql_runner'

class Album
  def initialize(options)
    @id = options['id'].to_i if options['id']
    @artist_id = options['artist_id']
    @title = options['title']
    @genre = options['genre']
  end

  def save
    sql = 'INSERT INTO albums (artist_id, title, genre)\
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
    result[0]['name']
  end
end
