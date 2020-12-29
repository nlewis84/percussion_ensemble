class PercussionEnsembles::Composer
    attr_accessor :name
    attr_reader :songs, :duration, :level, :personnel

    @@all = []

    def initialize(name)
        @name = name
        @songs = []
        @@all << self
    end

    def self.all
        @@all
    end

    def self.find_or_create_by(name)
        if composer = self.all.find {|comp| comp.name == name}
            composer
        else
            PercussionEnsembles::Composer.new(name)
        end
    end

    def add_song(song)
        song.composer(self) unless song.composer
        @songs << song unless @songs.include?(song)
    end
end