class PercussionEnsembles::Composer
    attr_accessor :name, :duration, :level, :personnel
    attr_reader :songs

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
        @songs << song unless songs.include?(song)
    end

    def self.all
        @@all
    end
    # TRY THIS PART to make composers create as long as they don't exist already...it runs in CLI.make_composers1
    def self.create_from_collection(ensemble_array)
        binding.pry
        ensemble_array.map do |ensemble|
            composer = PercussionEnsembles::Composer.new(ensemble.composer)
            composer
            composer.add_song(ensemble)
        end
    end

    def difficulties
        self.songs.collect {|song| song.difficulty}.uniq
    end
end

## iterate through ensemble_array.each
# composer = PercussionEnsembles::Composer.new(ensemble_array[0].composer)
# composer
# composer.add_song(ensemble_array[0])