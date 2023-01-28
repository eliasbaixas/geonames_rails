class GeonamesRails::Csv

  include Enumerable

  attr_accessor :parsed

  HEADERS = [
    [:geonameid,'integer id of record in geonames database'],
    [:name,'name of geographical point (utf8) varchar(200)'],
    [:asciiname,'name of geographical point in plain ascii characters, varchar(200)'],
    [:alternatenames,'alternatenames, comma separated, ascii names automatically transliterated, convenience attribute from alternatename table, varchar(8000)'],
    [:latitude,'latitude in decimal degrees (wgs84)'],
    [:longitude,'longitude in decimal degrees (wgs84)'],
    [:feature_class,'see http://www.geonames.org/export/codes.html, char(1)'],
    [:feature_code,'see http://www.geonames.org/export/codes.html, varchar(10)'],
    [:country_code,'ISO-3166 2-letter country code, 2 characters'],
    [:cc2,'alternate country codes, comma separated, ISO-3166 2-letter country code, 60 characters'],
    [:admin1_code,'fipscode )'],
    [:admin2_code,'code for the second administrative division, a county in the US, see file admin2Codes.txt; varchar(80) '],
    [:admin3_code,'code for third level administrative division, varchar(20)'],
    [:admin4_code,'code for fourth level administrative division, varchar(20)'],
    [:population,'bigint (8 byte int) '],
    [:elevation,'in meters, integer'],
    [:dem,'digital elevation model, srtm3 or gtopo30, average elevation of 3''x3'' (ca 90mx90m) or 30''x30'' (ca 900mx900m) area in meters, integer. srtm processed by cgiar/ciat.'],
    [:timezone,'the timezone id (see file timeZone.txt) varchar(40)'],
    [:modification_date,'date of last modification in yyyy-MM-dd format']
  ]

  def initialize(file_path,opts={col_sep: "\t", headers: HEADERS.map(&:first), quote_char: "%"})
    @parsed=[]
    ::CSV.read(file_path, **opts).each do |r|
      if block_given?
        @parsed << r if yield(r)
      else
        @parsed << r
      end
    end
  end

  def each(&block)
    @parsed.each(&block)
  end

end
