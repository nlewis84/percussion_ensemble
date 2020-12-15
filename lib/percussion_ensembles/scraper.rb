require 'watir'

class PercussionEnsembles::Scraper
    def scrape(site)
        # browser = Watir::Browser.new :chrome#, headless: true
        # browser.goto site

        # # # Counts the Divs and Tracks this so the whole page can be scraped
        # div_count = browser.divs(:class => "catalog-list2").count - 2
        # puts div_count
        # last_div = browser.divs(:class => "catalog-list2")[div_count]
    
        # # Watir Actions
        # # while div_count < 269
        #     last_div.scroll.to :top
        #     browser.div(class: "catalog-list2").wait_until(timeout: 5, message: "Oops not there")
        #     div_count = browser.divs(:class => "catalog-list2").count - 2
        # # end
        
        # browser.close

        doc = Nokogiri::HTML(open(site))

        ensembles = []

        doc.css("div.catalog-list2").each do |card|
            current_ensemble = {}

            ensemble_title = card.css("div.catalog-product-image img").first["title"]
            composer_name = card.css("div.catalog-product-title a:nth-of-type(2)").first["title"]
            more_info = card.css("div.catalog-fields")

            current_ensemble.merge!(:name => ensemble_title, :composer => composer_name)
            more_info.each do |info|
                full_details = {}
                info.text.split(" | ").each do |details|
                    key, value = details.split ': ', 2
                    full_details.merge!(key.downcase.to_sym => value)
                    current_ensemble.merge!(full_details)
                end
            end
            ensembles << current_ensemble
        end
        ensembles
    end
end