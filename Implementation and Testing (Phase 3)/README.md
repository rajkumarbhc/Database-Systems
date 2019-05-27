# Data Warehouse Description
This is a data warehouse application which allows users to read and make changes to the postgres database. This application has been built in shiny rstudio. 

![demo_gif](https://github.gatech.edu/storage/user/23640/files/fcde9b80-5a0e-11e9-9a94-70799b3ac02f)

# Prerequisites
- Install the latest version of PostgreSQL & pgAdmin 4.<br/>
- Install the latest version of R and R studio on your computer. 

# Software Installation
- PostgreSQL & pgAdmin 4 Installation Instructions for Windows Users and Mac Users:
1. Download PostgreSQL from this link: https://www.enterprisedb.com/downloads/postgres-postgresql-downloads.
2. While installing, choose a password to access the database.
3. Ensure that you install pgadmin4 during installation.

- R and RStudio Installation Instructions:<br/>
- Windows Users:  <br/>
1. Open an internet browser and go to www.r-project.org.
2. Click the "download R" link in the middle of the page under "Getting Started."
3. Select a CRAN location (a mirror site) and click the corresponding link.  
4. Click on the "Download R for Windows" link at the top of the page.  
5. Click on the "install R for the first time" link at the top of the page.
6. Click "Download R for Windows" and save the executable file somewhere on your computer.  Run the .exe file and follow the installation instructions.  
7. Now that R is installed, you need to download and install RStudio. 
<br/>To Install RStudio:
1. Go to www.rstudio.com and click on the "Download RStudio" button.
2. Click on "Download RStudio Desktop."
3. Click on the version recommended for your system, or the latest Windows version, and save the executable file.  Run the .exe file and follow the installation instructions.  
   
- Mac Users: 
1. Open an internet browser and go to www.r-project.org.
2. Click the "download R" link in the middle of the page under "Getting Started."
3. Select a CRAN location (a mirror site) and click the corresponding link.
4. Click on the "Download R for (Mac) OS X" link at the top of the page.
5. Click on the file containing the latest version of R under "Files."
6. Save the .pkg file, double-click it to open, and follow the installation instructions.
7. Now that R is installed, you need to download and install RStudio.
<br/>To Install RStudio:
1. Go to www.rstudio.com and click on the "Download RStudio" button.
2. Click on "Download RStudio Desktop."
3. Click on the version recommended for your system, or the latest Mac version, save the .dmg file on your computer, double-click it to open, and then drag and drop it to your applications folder.

# Datawhrehouse App Testing Information
- Clone our entire app repository to your computer. <br/>

- Open pgAdmin do the following: 
1. Go to the CODE\Other\Schemas folder
2. Create the tables schemas in TablesSchema_postgres.sql 
3. Copy the csv files in the team08_sampleData folder to postgres using the code in CreatePresentationData.sql
4. Create the views in ViewsSchema_postgres.sql <br/>

- Test the Shiny App: 
5. Go to Phase 3\CODE and open DataWarehouseApp.r
6. Set the working directory to the CODE folder. You can do this by going to session>set working directory> choose a directory or edit this code in the r file, setwd("C:\\Users\\Divya\\Desktop\\Spring_2019\\DBMS\\Phase 3\\CODE"). To verify your directory type getwd() in the console below. 
7. Installation of required packages has been automated. If the packages does not automatically install, please install it mannualy. 
8. Click on Run App. (You can run the app in R or open in your local browser) 
