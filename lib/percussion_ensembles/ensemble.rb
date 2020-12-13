class PercussionEnsembles::Ensemble
    attr_accessor :name, :composer, :duration, :level, :personnel

    @@all = []

    def initialize(ensemble_hash)
        ensemble_hash.each do |key, value|
            self.send("#{key}=", value)
        end
        @@all << self
    end
    
    def self.create_from_collection(ensemble_array)
        ensemble_array.map {|ensemble| PercussionEnsembles::Ensemble.new(ensemble)}
    end

    # def add_ensemble_attributes(attributes_hash)
    #     attributes_hash.each do |k,v|
    #         instance_variable_set("@#{k}", v) unless v.nil?
    #     end
    # end

    def self.all
        @@all
    end
end