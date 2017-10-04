require_relative 'models/artist'
require_relative 'models/album'

Album.delete_all
Artist.delete_all

artist1 = Artist.new ({
  'name' => 'Radiohead'
  })
artist1.save

artist2 = Artist.new ({
  'name' => 'Nirvana'
  })
artist2.save

artist3 = Artist.new ({
  'name' => 'Frightened Rabbit'
  })
artist3.save

album1 = Album.new ({
  'artist_id' => artist1.id,
  'title' => 'OK Computer',
  'genre' => 'Electronic'
  })
album1.save

album2 = Album.new ({
  'artist_id' => artist2.id,
  'title' => 'In Utero',
  'genre' => 'Grunge'
  })
album2.save

album3 = Album.new ({
  'artist_id' => artist2.id,
  'title' => 'Nevermind',
  'genre' => 'Grunge'
  })
album3.save

album4 = Album.new ({
  'artist_id' => artist2.id,
  'title' => 'MTV Unplugged In New York',
  'genre' => 'Grunge'
  })
album4.save

album5 = Album.new ({
  'artist_id' => artist3.id,
  'title' => 'Sing the Greys',
  'genre' => 'Indie Rock'
  })
album5.save

puts 'Albums:'
puts Album.list_all, ''

puts 'Artists:'
puts Artist.list_all, ''

puts 'Albums by Nirvana:'
puts artist2.list_albums, ''

puts 'Artist of Sing the Greys:'
puts album5.artist, ''

puts 'Change Sing the Greys genre to Rainy Scottish Tunes:'
album5.genre = 'Rainy Scottish Tunes'
album5.update
puts album5, ''

puts 'Change Frightened Rabbit to Bold Duck:'
artist3.name = 'Bold Duck'
artist3.update
puts artist3, ''

puts 'Delete Sing the Greys:'
album5.delete
puts Album.list_all, ''

puts 'Delete Bold Duck:'
artist3.delete
puts Artist.list_all, ''

puts 'Find In Utero:'
puts Album.find('In Utero'), ''

puts 'Find Grunge albums:'
puts Album.find('Grunge'), ''

puts 'Find Nirvana:'
puts Artist.find('Nirvana')
