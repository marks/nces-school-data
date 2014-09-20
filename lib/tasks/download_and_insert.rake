# for each of the following three URLs:
# - "school_districts" - http://nces.ed.gov/ccd/pubagency.asp (Local Education Agency (School District) Universe Survey Data)
# - "schools" - http://nces.ed.gov/ccd/pubschuniv.asp (Public Elementary/Secondary School Universe Survey Data)
# - "school_district_finances" - http://nces.ed.gov/ccd/f33agency.asp (Local Education Agency (School District) Finance Survey (F-33) Data)
 
# do the following
# - get the "flat file" ZIP file and download it for each year
# - unzip the zip file; there should be one CSV
# - with that CSV, import it into the corresponding table

namespace :download_and_insert do

	task :school_districts do
		puts settings.data_pages_to_scrape["school_districts"].inspect
	end

	task :school_district_finances do

	end

	task :schools do

	end

end
