## 5.0.0

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
