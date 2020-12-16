class PercussionEnsembles::Ensemble
    attr_accessor :name, :composer, :duration, :level, :personnel

    @@all = []

    def initialize(ensemble_hash)
        ensemble_hash.each do |key, value|
            self.send("#{key}=", value)
        end
        if @@all.none? {|ensemble| ensemble.name == self.name}
            @@all << self
        end
        self.composer.add_song(self)
        @@all.sort_by {|obj| obj.name}
    end

    def self.all
        @@all
    end
  
    def self.create_from_collection(ensemble_array)
        ensemble_array.map {|ensemble| PercussionEnsembles::Ensemble.new(ensemble)}
    end
end