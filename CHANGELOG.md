## 14.0.0

### Enhancements
- **General Changes**
  - Navigation has been updated to break down long document menu into tabs
  - Add settings page to allow users to update their email and password
  - Members can now upload profile pictures
  - Members can now search across documents, users, and sites
  - Members now have a username
  - Update styling of registration emails
  - All files in a folder can be downloaded as a single zip file
  - Editors can now upload zip files
- **Admin Changes**
  - User index now has search filters
  - Updated editor and admin setup interface
- **Site Changes**
  - Editors can now assign numbers to sites
- **Gem Changes**
  - Update to ruby 2.6.1
  - Update to rails 6.0.0.beta1
  - Update to pg 1.1.4
  - Update to bootstrap 4.2.1
  - Update to carrierwave 1.3.1
  - Update to font-awesome-sass 5.6.1

## 13.0.0 (October 16, 2018)

### Enhancements
- **General Changes**
  - Add updated Privacy Policy
- **Gem Changes**
  - Update to rails 5.2.1
  - Update to pg 1.1.3
  - Update to bootstrap 4.1.3
  - Update to carrierwave 1.2.3
  - Update to devise 4.5.0
  - Update to jquery-rails 4.3.3

## 12.1.1 (May 3, 2018)

### Enhancements
- **General Changes**
  - Improved contrast of support email link on landing page
  - Removed leading zeros in "data last updated" string
  - Improved password autocomplete
  - PATS logo no longer wraps on small screens
- **Gem Changes**
  - Updated to bootstrap 4.1.1

## 12.1.0 (April 18, 2018)

### Enhancements
- **Gem Changes**
  - Updated to ruby 2.5.1
  - Updated to rails 5.2.0
  - Updated to bootstrap 4.1.0

## 12.0.0 (March 23, 2018)

### Enhancements
- **General Changes**
  - Updated layout of internal sidebar
- **Gem Changes**
  - Updated to ruby 2.5.0
  - Updated `Gemfile` to `gems.rb`
  - Updated to rails 5.2.0.rc2
  - Updated to pg 1.0.0
  - Updated to bootstrap 4.0.0
  - Updated to carrierwave 1.2.2
  - Updated to devise 4.4.3
  - Updated to haml 5.0.4
  - Updated to kaminari 1.1.1
  - Updated to simplecov 0.16.1

## 11.0.0 (May 16, 2017)

### Enhancements
- **General Changes**
  - Added a Signal Quality Grades graph to the Data Quality page
  - Login cookies are now cross subdomain and work between www and non-www URLs
- **Report Changes**
  - Added a new report card that grades sites by data completion percentage
  - Added a new unscheduled events report that shows adverse events, protocol
    deviations, and unblinding events by site by month
  - Added a new report that displays a table of data inconsistencies by site
- **Gem Changes**
  - Updated to Ruby 2.4.1
  - Updated to rails 5.1.1
  - Updated to devise 4.3.0
  - Updated to pg 0.20.0
  - Updated to carrierwave 1.1.0
  - Updated to haml 5.0.1
  - Updated to kaminari 1.0.1
  - Updated to jquery-rails 4.3.1
  - Updated to simplecov 0.14.1
  - Added autoprefixer-rails

### Bug Fix
- Fixed a bug that caused JavaScript functions to run twice in browsers that
  supported Turbolinks

## 10.0.1 (January 9, 2017)

### Bug Fix
- Fixed an issue with a document uploader test that would fail intermittently

## 10.0.0 (January 9, 2017)

### Enhancements
- **General Changes**
  - Reduced number of alerts and messages from devise during login and logout
- **Gem Changes**
  - Updated to Ruby 2.4.0
  - Updated to rails 5.0.1
  - Updated to jquery-rails 4.2.2
  - Updated bootstrap-sass to 3.3.7
  - Updated to carrierwave 1.0.0

## 9.0.0 (December 20, 2016)

### Enhancements
- **General Changes**
  - Expanded the race breakdown on the demographics page
  - Added a data quality report page
  - Tooltips on charts now display all values even when series overlap
  - Improved display of percentages in tables
  - Dashboard now highlights randomizations
  - Demographics now defaults to display randomized subjects
- **Gem Changes**
  - Dropped support for Ruby 2.2
  - Updated to Ruby 2.3.3

### Bug Fixes
- Rails model errors are now again correctly styled using Bootstrap CSS classes

## 8.0.0 (October 24, 2016)

### Enhancements
- **General Changes**
  - Added a page that shows eligibility status for consented
  - Cleaned up navigation menu
  - Cumulative consented replaces cumulative screened on dashboard
  - Document and video tables now display better on smaller devices
  - Improved friendly forwarding to internal pages
- **Setup Changes**
  - Improved display of users index and added number of total users
  - DSMB member flag changed to Unblinded flag
- **Gem Changes**
  - Updated to rails 5.0.0.1
  - Updated to pg 0.19.0
  - Updated to jquery-rails 4.2.1

### Bug Fix
- Fixed a bug with pagination when documents and videos were archived

## 7.0.0 (August 3, 2016)

### Enhancements
- **General Changes**
  - Improved links on landing page
  - Updated title slide on landing page
  - Improved underlying user interface layout
  - Hovering mouse over tables now also highlights the corresponding column
  - Added Eligibility Status report to navigation menu
- **Gem Changes**
  - Updated to rails 5.0.0
  - Updated to coffee-rails 4.2
  - Updated to jbuilder 2.5
  - Updated to jquery-rails 4.1.1
  - Updated to bootstrap-sass 3.3.6
  - Added rails-controller-testing

### Refactoring
- Updated kaminari pagination views to use haml

### Bug Fix
- Fixed emails in forked processes from not being sent
- Fixed back navigation not working after viewing a PDF
- Fixed a bug that prevented users from logging in correctly with an expired
  authenticity token

## 6.0.0 (July 12, 2016)

### Enhancements
- **General Changes**
  - Added a demographics report page
    - Demographics report pages displays charts for age by gender, and gender
      by race
  - Added a eligibility status report page
  - Document sizes no longer wrap across multiple lines
- **Gem Changes**
  - Updated to turbolinks 5
  - Updated to devise 4.2.0
  - Updated to kaminari 0.17.0
  - Updated to simplecov 0.12.0

## 5.0.0 (June 27, 2016)

### Enhancements
- **General Changes**
  - Logged in users now see their Staff ID next to their name in the menu
  - Recruitment charts and tables are now displayed on the internal landing page
    - Added individual pages detailing charts and tables for:
      - Screened
      - Consented
      - Eligible
      - Randomized
  - Adjusted how menu is displayed on mobile devices
- **Email Changes**
  - Styling has been added to all emails
- **Setup Changes**
  - Editors can now set members as archived to hide the member from the
    directory
  - Editor document lists are now sortable by name and upload time
  - Embed URLs no longer autocomplete when adding videos as an editor
- **Gem Changes**
  - Updated to Ruby 2.3.1
  - Updated to rails 4.2.6
  - Updated to carrierwave 0.11.2

## 4.0.1 (March 1, 2016)

### Enhancements
- **Gem Changes**
  - Updated to rails 4.2.5.2

## 4.0.0 (February 29, 2016)

### Enhancements
- **General Changes**
  - Improved layout for smaller screen sizes
- **Calculator Changes**
  - Increased the number of characters for height and weight to account for
    decimals
- **Category Changes**
  - Categories can now set their top level folder name
  - Videos can now be embedded on categories
  - Categories can be set to be only viewable by DSMB members
- **Setup Changes**
  - Admin and editor setup pages are now more consistent and have an updated
    user interface
- **User Changes**
  - Users can be set as DSMB members

### Bug Fix
- Fixed a bug preventing editors from viewing sites in project setup
- Fixed a bug preventing users from accessing password reset page

## 3.0.1 (February 16, 2016)

### Enhancements
- **Calculator Changes**
  - Changed the ordering of height and weight on the Pediatric BMI Z-Score
    Calculator

## 3.0.0 (February 9, 2016)

### Enhancements
- **General Changes**
  - Several UI consistency changes
- **Member Changes**
  - Members can now be assigned a Staff ID
- **Calculators Added**
  - Added a Body Mass Index Z-Score calculator based on:
    - http://www.cdc.gov/growthcharts/percentile_data_files.htm
    - http://www.cdc.gov/growthcharts/data/zscore/bmiagerev.csv
  - Added a Blood Pressure Percentile calculator based on:
    - http://www.cdc.gov/growthcharts/percentile_data_files.htm
    - http://www.cdc.gov/growthcharts/data/zscore/statage.csv
  - BMI Z-Score also provides the BMI Percentile as output
- **NDC Drug Search Added**
  - Added a search page for NDC drug codes
- **Gem Changes**
  - Updated to Ruby 2.3.0
  - Updated to rails 4.2.5.1
  - Updated to pg 0.18.4
  - Updated to simplecov 0.11.2
  - Updated to web-console 3.0.0

## 2.0.0 (November 6, 2015)

### Enhancements
- **User Changes**
  - Added admin, editor, and viewer roles for internal pages of website
  - Users must be approved before being able to complete login
- **Admin Changes**
  - Admins can create and update generic username and password viewer logins
  - Viewer logins have read-only access to the internal site
- **Directory Changes**
  - Editors can now create and update member listings in the directory
  - Approved viewers can view the directory from their dashboard
  - Members in directory are grouped by site
- **Committee Changes**
  - Editors can now create and update committees
  - Editors can add and remove members from committees
  - Editors can set members as committee chairs
  - Viewers can view committees from their dashboard
- **Site Changes**
  - Editors can now created and update sites
  - Editors can add members to sites
  - Editors can specify the center type for sites
    - ex: Recruiting Center, Coordinating Center
  - Editors can add contact information to sites
- **Document Changes**
  - Editors can now create and update document categories to organize documents
  - Editors can now upload documents to categories
  - Editors can archive existing documents and categories
  - Viewers can now download documents
- **General Changes**
  - Public home page includes:
    - Information about the study
    - Information on how to participate
    - List of participating sites
    - General contact information
    - Internal login link for study staff
  - Added link to ClinicalTrials.gov
  - Public list of participating sites added
  - Public contact page added

## 1.0.0 (October 20, 2015)

- Skeleton files to initialize Rails application with testing framework and
  continuous integration
- Started work on initial color scheme, font family, and user interface
