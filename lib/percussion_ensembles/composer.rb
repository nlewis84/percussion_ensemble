class PercussionEnsembles::Composer
    attr_accessor :name, :songs, :duration, :level, :personnel

    @@all = []

    def initialize(name)
        @name = name
        @songs = []
        @@all << self
    end
    
    def self.create(name)
        composer = Composer.new(name)
        composer
    end

    def add_song(song)
        song.composer = self unless song.composer
        songs << song unless songs.include?(song)
    end

    def self.all
        @@all
    end

    def difficulties
        self.songs.collect {|song| song.difficulty}.uniq
    end
end