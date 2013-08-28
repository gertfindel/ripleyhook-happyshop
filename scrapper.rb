class RipleyScrapper
  @@urls = {}
  @@base = "http://www.ripley.cl/webapp/wcs/stores/servlet"
  @@default = "/categoria-TVRipley-10051-001772-130000-ESP-N-MAYOR--si-1-"

  def self.setup
    
    @@urls["f"] = {}
    @@urls["m"] = {}
    @@urls.default= @@default
    @@urls["f"].default = @@default
    @@urls["m"].default = @@default

    ## Mujeres
    (1..100).each do |a|
      @@urls["f"][a.to_s] = 
      [
"/categoria-TVRipley-10051-Onduladores-970000-ESP-N-MAYOR--si-1-"  
        ].sample
    end 
    
    (1..100).each do |a|
      @@urls["m"][a.to_s] = 
      [ 
"/categoria-TVRipley-10051-002345-130000-ESP-N"
              
      ].sample
    end 
  end

  def self.get_contents(gender = "", age= "")
    
    self.setup
    if gender.nil? or age.nil?
      url = @@default
    elsif
      url = @@urls[gender][age] || @@default
    end
    
    contents = self.extract @@base+url    
    contents
  end


  private 

    def self.extract(url)
      doc = Nokogiri::HTML(open(url))
      contents = []
      count = 0
      doc.css(".contProd").first(3).each do |item|
        el = {}
        el[:title]  = item.at_css(".nomProd").text.strip!
        el[:description] = (el[:title] + " - " + item.at_css(".descrip p").text.strip + "\n Precio: " + item.at_css(".rojo strong").text.strip).to_s
        img_tag = item.at_css("a img")
        el[:image_url] = "http://www.ripley.cl"+URI.escape(img_tag[:src])
        el[:url] = URI.escape(@@base+ "/"+item.at_css("a")[:href])
        el[:exp_date] = 9372564800
        
        contents << el
      end

      contents
    end
end
