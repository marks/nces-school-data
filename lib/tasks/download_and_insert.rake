# for each of the following three URLs:
# - "school_districts" - http://nces.ed.gov/ccd/pubagency.asp (Local Education Agency (School District) Universe Survey Data)
# - "schools" - http://nces.ed.gov/ccd/pubschuniv.asp (Public Elementary/Secondary School Universe Survey Data)
# - "school_district_finances" - http://nces.ed.gov/ccd/f33agency.asp (Local Education Agency (School District) Finance Survey (F-33) Data)
 
# do the following
# - get the "flat file" ZIP file and download it for each year
# - unzip the zip file; there should be one CSV
# - with that CSV, import it into the corresponding table

require 'csv'

namespace :download_and_insert do

  task :school_districts do
    scope = "school_districts"
    scope_settings = settings.data_pages_to_scrape[scope]
    puts scope_settings.inspect
    
    data_page_contents = RestClient.get(scope_settings["data_page"])
    data_page = Nokogiri::XML(data_page_contents.body)
    %x(mkdir -p tmp/#{scope})
    # find links in the "Data Set" column for "Flat File"s -- currently we only grab the most recent.
    # Remove ":nth-of-type(3)" to grab ALL years' flat files
    links_to_zip_files = data_page.css("table.data tr:nth-of-type(3) td:nth-of-type(2):contains('Flat File') a").map{|e| e.attr("href")}
    links_to_zip_files.each do |link_to_zip|
      zip_file = link_to_zip.split("/").last
      puts "Downloading and then unzipping tmp/#{scope}/#{zip_file} ... "
      %x(curl #{scope_settings["data_page"]}/../#{link_to_zip} -o tmp/#{scope}/#{zip_file})
      %x(cd tmp/#{scope} && unzip -o #{zip_file})
      %x(rm tmp/#{scope}/#{zip_file})
    end
    
    Dir["tmp/#{scope}/*.txt"].each do |file|
      filename = file.split("/").last
      puts "Importing #{scope} data from #{filename} ... "
      utf8_invalid_file_contents = File.read(file)
      ic = Iconv.new('UTF-8//IGNORE', 'UTF-8')
      valid_file_contents = ic.iconv(utf8_invalid_file_contents + ' ')[0..-2]
      if !valid_file_contents[0,1000].match(SchoolDistrict.important_header_key)
        puts "!!!! #{file} has no header row, cannot insert"
        next
      end
      CSV.parse(valid_file_contents, {:col_sep => "\t", :headers => true}).each do |row|
        attrs = row.to_hash
        school_district_for_this_year = SchoolDistrict.find_or_create_by({:SURVYEAR => attrs["SURVYEAR"], :"#{SchoolDistrict.important_header_key}" => attrs[SchoolDistrict.important_header_key], :_file => filename})
        school_district_for_this_year.update_attributes!(attrs)
      end
    end
  end

  task :school_district_finances do
    scope = "school_district_finances"
    scope_settings = settings.data_pages_to_scrape[scope]
    puts scope_settings.inspect
    
    data_page_contents = RestClient.get(scope_settings["data_page"])
    data_page = Nokogiri::XML(data_page_contents.body)
    %x(mkdir -p tmp/#{scope})
    # find links in the "Data Set" column for "Flat File"s -- currently we only grab the most recent.
    # Remove ":nth-of-type(3)" to grab ALL years' flat files
    links_to_zip_files = data_page.css("table.data tr:nth-of-type(3) td:nth-of-type(2):contains('Flat File') a").map{|e| e.attr("href")}
    links_to_zip_files.each do |link_to_zip|
      zip_file = link_to_zip.split("/").last
      puts "Downloading and then unzipping tmp/#{scope}/#{zip_file} ... "
      %x(curl #{scope_settings["data_page"]}/../#{link_to_zip} -o tmp/#{scope}/#{zip_file})
      %x(cd tmp/#{scope} && unzip -o #{zip_file})
      %x(rm tmp/#{scope}/#{zip_file})
    end
    
    Dir["tmp/#{scope}/*.txt"].each do |file|
      filename = file.split("/").last
      puts "Importing #{scope} data from #{filename} ... "
      utf8_invalid_file_contents = File.read(file)
      ic = Iconv.new('UTF-8//IGNORE', 'UTF-8')
      valid_file_contents = ic.iconv(utf8_invalid_file_contents + ' ')[0..-2]
      if !valid_file_contents[0,1000].match(SchoolDistrictFinance.important_header_key)
        puts "!!!! #{file} has no header row, cannot insert"
        next
      end
      CSV.parse(valid_file_contents, {:col_sep => "\t", :headers => true}).each do |row|
        attrs = row.to_hash
        school_district_finance_for_this_year = SchoolDistrictFinance.find_or_create_by({:SURVYEAR => attrs["SURVYEAR"], :"#{SchoolDistrictFinance.important_header_key}" => attrs[School.important_header_key], :_file => filename})
        school_district_finance_for_this_year.update_attributes!(attrs)
      end
    end

  end

  task :schools do
    scope = "schools"
    scope_settings = settings.data_pages_to_scrape[scope]
    puts scope_settings.inspect
    
    data_page_contents = RestClient.get(scope_settings["data_page"])
    data_page = Nokogiri::XML(data_page_contents.body)
    %x(mkdir -p tmp/#{scope})
    # find links in the "Data Set" column for "Flat File"s -- currently we only grab the most recent.
    # Remove ":nth-of-type(3)" to grab ALL years' flat files
    links_to_zip_files = data_page.css("table.data tr:nth-of-type(3) td:nth-of-type(2):contains('Flat File') a").map{|e| e.attr("href")}
    links_to_zip_files.each do |link_to_zip|
      zip_file = link_to_zip.split("/").last
      puts "Downloading and then unzipping tmp/#{scope}/#{zip_file} ... "
      %x(curl #{scope_settings["data_page"]}/../#{link_to_zip} -o tmp/#{scope}/#{zip_file})
      %x(cd tmp/#{scope} && unzip -o #{zip_file})
      %x(rm tmp/#{scope}/#{zip_file})
    end
    
    Dir["tmp/#{scope}/*.txt"].each do |file|
      filename = file.split("/").last
      puts "Importing #{scope} data from #{filename} ... "
      utf8_invalid_file_contents = File.read(file)
      ic = Iconv.new('UTF-8//IGNORE', 'UTF-8')
      valid_file_contents = ic.iconv(utf8_invalid_file_contents + ' ')[0..-2]
      if !valid_file_contents[0,1000].match(School.important_header_key)
        puts "!!!! #{file} has no header row, cannot insert"
        next
      end
      CSV.parse(valid_file_contents, {:col_sep => "\t", :headers => true}).each do |row|
        attrs = row.to_hash
        school_for_this_year = School.find_or_create_by({:SURVYEAR => attrs["SURVYEAR"], :"#{School.important_header_key}" => attrs[School.important_header_key], :_file => filename})
        school_for_this_year.update_attributes!(attrs)
      end
    end
  end

end
