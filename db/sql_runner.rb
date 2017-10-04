require 'pg'

class SQLRunner
  def self.run(sql, values)
    db = PG.connect({ dbname: 'music_collection', host: 'localhost' })
    db.prepare('temporary', sql)
    results = db.exec_prepared('temporary', values)
    db.close
    results
  end
end
