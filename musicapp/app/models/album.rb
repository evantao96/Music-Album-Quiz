require 'open-uri'
require 'rest-client'
require 'json'


class Album < ActiveRecord::Base

  has_many :album_tests, dependent: :destroy
  has_many :tests, through: :albums_tests

  validates :name, presence: true
  validates :artist, presence: true, uniqueness: { scope: :name, message: "Name and artist should be unique" }

  validate :cap_name

  validate :cap_artist

  validate :in_spotify

  grant = Base64.encode64("4426f03c25e345a0b604f2d4f19c1678:8a034e7a27e44e4ea0d520de19869f47").delete("\n")
  respond = RestClient.post('https://accounts.spotify.com/api/token',
                       {'grant_type' => 'client_credentials'},
                       {"Authorization" => "Basic #{grant}"})
  token_ext =  respond.split(',')
  token_ext2 = token_ext[0].split(':')
  only_token = token_ext2[1].delete_prefix('"').delete_suffix('"')
  $header = {'Authorization': "Bearer #{only_token}"}

  def cap_name
    unless name.nil? || name.empty? || name[0].capitalize == name[0]
      errors.add(:name, 'is not capitalized')
    end
  end

  def cap_artist
    unless artist.nil? || artist.empty? || artist[0].capitalize == artist[0]
      errors.add(:artist, 'is not capitalized')
    end
  end


  def in_spotify
    if name.nil? || name.empty?
      errors.add(:album, 'does not exist in Spotify')
    else
      my_hash = JSON.parse(RestClient.get("https://api.spotify.com/v1/search?q=#{album_search}&type=album", $header))
      if my_hash['albums']['items'].empty?
        errors.add(:album, 'does not exist in Spotify')
      end
    end
  end
  
  def album_format 
    name + " by " + artist 
  end

  def rand_four
    ans = [ self ]    

    while ans.size < 4 
      offset = rand(Album.count)
      rand_album = Album.offset(rand(Album.count)).first
      ans << rand_album unless ans.include?(rand_album)
    end

    ans.shuffle
  end

  def album_eq(album)
    equal?(album) ? "true" : "false"
  end

  def spotify_uri
    my_hash = JSON.parse(RestClient.get("https://api.spotify.com/v1/search?q=#{album_search}&type=album", $header))
    p my_hash['albums']['items'][0]['images'][0]['url']
  end


  def album_search
    artist.tr(' ', '+') + '+' + name.tr(' ', '+')
  end

end
