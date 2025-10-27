

Duplicate year directory and index.html.
- Edit that year.html to include the appropriate copy at the top (amount of responses, etc.)
- Edit any pointers within the file to use the correct data file (.csv) and output URLs (ex: change 2023 to 2025 throughout)
- update the _config.yml to include new directory path


Create a new data file that lists the Districts that are active for the new election cycle. Use naming convention yyyy-districts.csv

Use the following columns:
esd,esd_name,district,type,response

For the Q and A data file, create a .csv with the naming convention yyyy-candidate-q-and-a.csv 

Use the following columns:

esd
esd_name
    - use just the number i.e. "189" not "ESD189"
district
    - must be just base name of district i.e. "Lynden" not "Lynden School District #504". Double-check these names against the existing names identified in the yyyy-districts.csv file. Example "Seattle Public Schools" must be just "Seattle".
type
position
name
question1
response1
question2
response2
question3
response3
question4
response4
question5
response5
question6
response6


The questions from the questionnaire should be added to the new .csv data file into the respective questions columns. 
- 2023 only had five questions
- 2025 had six question
- future years may need to adjust code for more questions


When you add/update a new year or data file, you must run this script to parse the data files and build individual response pages:
ruby scripts/generate_responses.rb
- before you run, edit this script to include the years you want to generate individual response pages:
    - YEARS = %w[2023 2025]


To start the local server at command line:
bundle exec jekyll serve 