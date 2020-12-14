class PercussionEnsembles::Composer
    attr_accessor :name
    attr_reader :songs, :duration, :level, :personnel

    # @@all = []

    # def initialize(name)
    #     @name = name
    #     @songs = []
    #     @@all << self
    #     binding.pry
    # end

    # def self.all
    #     @@all
    # end

    # def self.create(name)
    #     composer = Composer.new(name)
    #     composer
    # end

    # def add_song(song)
    #     song.composer(self) unless song.composer
    #     @songs << song unless @songs.include?(song)
    # end

    # def songs
    #     PercussionEnsembles::Ensemble.all.select {|ensemble| ensemble.composer == self}
    # end

    # def difficulties
    #     self.songs.collect {|song| song.difficulty}.uniq
    # end
end

## iterate through ensemble_array.each
# composer = PercussionEnsembles::Composer.new(ensemble_array[0].composer)
# composer
# composer.add_song(ensemble_array[0])