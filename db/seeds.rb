# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'
file_name = ['melon_sample_2011.csv', 'melon_sample.csv']
file_name.each do |name|
  csv_text = File.read(Rails.root.join('lib', 'seeds', name))
  csv = CSV.parse(csv_text, headers: true, encoding: 'UTF-8')
  csv.each do |row|
    # row: 아티스트, 노래,앨범명, 좋아요수
    artists = row[0].split(',')
    artists.each do |a|
      ar = Artist.find_or_create_by!(name: a.to_s)
      ab = Album.find_or_create_by!(title: row[2].to_s)
      m = Music.find_or_create_by!(title: row[1].to_s, like_count: row[3].to_i, album_id: ab.id)
      MusicArtist.find_or_create_by!(music_id: m.id, artist_id: ar.id)
    end
  end
end

%W[\uAC15\uD638\uB3D9 \uC720\uC7AC\uC11D \uC190\uC11D\uAD6C \uC190\uC608\uC9C4 \uD55C\uAC00\uC778 \uAE40\uD0DC\uD76C
   \uC774\uBCD1\uD5CC \uC1A1\uD61C\uAD50].each_with_index do |name, i|
  user = User.find_or_create_by!(name: name)
  group = Group.find_or_create_by!(name: "#{name}_그룹")
  UserGroup.find_or_create_by!(user_id: user.id, group_id: group.id)
  UserGroup.find_or_create_by!(user_id: i, group_id: group.id) unless i.zero?
end
