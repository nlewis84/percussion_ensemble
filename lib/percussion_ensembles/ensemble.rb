class PercussionEnsembles::Ensemble
    attr_accessor :name, :composer, :duration, :level, :personnel

    @@all = []

    def initialize(ensemble_hash)
        ensemble_hash.each do |key, value|
            self.send("#{key}=", value)
        end
        @@all << self
    end

    def self.all
        @@all
    end
  
    def self.create_from_collection(ensemble_array)
        ensemble_array.map {|ensemble| PercussionEnsembles::Ensemble.new(ensemble)}
    end

end