
#####If the app does not work, install the below packages mannualy#########################################################
list.of.packages = c("shiny", "shinydashboard" ,"DBI","RPostgreSQL" , "DT", "dplyr", "dbplyr") 
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages) > 0) {install.packages(new.packages)}
lapply(list.of.packages, require, character.only=T)

library(shiny)
library(shinydashboard)
library(DBI)
library(RPostgreSQL)
library(DT)
library(dplyr)
library(dbplyr)

#####Please set the working directory to the code folder before running the app#######################################
#setwd("/Users/PeterC/Documents/gt/6400/Data_Warehouse_App_Testing/CODE")
#setwd("/Users/daron/OneDrive/CSE_6400/Data_Warehouse_App_Testing/Phase 3/CODE")

#These are fields in add/delete settings tabs
fields <- c("holidaydate", "holidayname")
fields2 <- c("manageremail", "managername")
fields3 <- c("manageremail2", "storenumber")
fields4 <- c("cityname", "state", "population")

pool <- dbConnect(
  drv = dbDriver("PostgreSQL"),
  dbname = "postgres",
  host = "localhost",
  user = "postgres",
  password = "XXXXXXX")

#Used as drop down for manager selection
manager_emails = function(){
  return (dbGetQuery(pool, "SELECT manageremail FROM manager"))
}

#Used as drop down for store selection
store_numbers = dbGetQuery(pool, "SELECT storenumber FROM store")

#Used as drop down for report 4
states_report4 = dbGetQuery(pool, "SELECT DISTINCT state from store")

#Used as drop down for report 6
#states_report6 = dbGetQuery(pool, "SELECT DISTINCT sale_date from report6_view_summary")
states_report6 = dbGetQuery(pool, "SELECT DISTINCT sale_date from RPT_6 order by sale_date")
#######################################################################################################################
ui <- dashboardPage(
  dashboardHeader(title = "S&E Data Warehouse"),
  dashboardSidebar(sidebarMenu(id = "tabs",
    menuItem("Main Menu", tabName = "mainMenu", icon = icon("dashboard"),
      menuItem('View Statistics', tabName = "viewStats", icon = icon("table")), 
        menuItem('Settings', tabName = "settings", icon = icon("cog"),
        menuSubItem('Add Holiday Information', tabName = "holidayEntry", icon = icon("keyboard")),
        menuSubItem('Add Manager Information', tabName = "managerEntry", icon = icon("keyboard")),
        menuSubItem('Assign Manger to Store', tabName = "assignManager", icon = icon("keyboard")),
        menuSubItem('Add City Population', tabName = "cityPopEntry", icon = icon("keyboard")))),
    menuItem("Report 1", tabName = "report1", icon = icon("table")),
    menuItem("Report 2", tabName = "report2", icon = icon("table")),
    menuItem("Report 3", tabName = "report3", icon = icon("table")),
    menuItem("Report 4", tabName = "report4", icon = icon("table")),
    menuItem("Report 5", tabName = "report5", icon = icon("table")),
    menuItem("Report 6", tabName = "report6", icon = icon("table")),
    menuItem("Report 7", tabName = "report7", icon = icon("table")))),   
    
  dashboardBody(tabItems(
    tabItem(tabName = "viewStats",
      fluidRow(column(12, includeMarkdown("Other/viewStats.html"))), tableOutput("countStat"),
      tags$head(tags$style("#countStat table {background-color: white; }", media="screen", type="text/css")),
      fluidRow(column(12, includeMarkdown("Other/reportButtons.html"))),                                       
      actionButton('jumpToR1', "Switch to Report 1"),
      actionButton('jumpToR2', "Switch to Report 2"),
      actionButton('jumpToR3', "Switch to Report 3"),
      actionButton('jumpToR4', "Switch to Report 4"),
      actionButton('jumpToR5', "Switch to Report 5"),
      actionButton('jumpToR6', "Switch to Report 6"),
      actionButton('jumpToR7', "Switch to Report 7"),
      actionButton('jumpToHAD', "Switch to Add Holiday Information"),
      actionButton('jumpToMAD', "Switch to Add Manager Information"),
      actionButton('jumpToAMAD', "Switch to Assign Manager to Store"),
      actionButton('jumpToCAD', "Switch to Add City Information")),  
      
    tabItem(tabName = "holidayEntry",
      actionButton('jumpToviewStats0.1', "Switch to Main Menu"), 
      h3("Add or Delete Holiday Information"),
      DT::dataTableOutput("holidays"), tags$hr(),
      h5("To delete, type the exact field information and click the delete button"),
      h5("Please enter date in YYYY-MM-DD format only"),
      textInput("holidaydate", "Holiday Date", ""),
      textInput("holidayname", "Holiday Name", ""),
      actionButton("add", "Add"),
      actionButton("delete", "Delete")),   
    
    tabItem(tabName = "managerEntry",
      actionButton('jumpToviewStats0.2', "Switch to Main Menu"), 
      h3("Add or Delete Manager Information"),
      DT::dataTableOutput("addmanager"), tags$hr(),
      h5("To delete, type the exact field information and click the delete button"),
      h5("Please enter a valid email address"),
      textInput("manageremail", "Manager Email", ""),
      textInput("managername", "Manager Name", ""),
      actionButton("add2", "Add"),
      actionButton("delete2", "Delete"),
      actionButton("activeinactive", "Manager Active/Inactive")),
    
    tabItem(tabName = "assignManager",
      actionButton('jumpToviewStats0.3', "Switch to Main Menu"),
      h3("Assign Manager to Store"),
      DT::dataTableOutput("assignmanager"), tags$hr(),
      #h5("To delete, type the exact field information and click the delete button"),
      #h5("Please enter a valid email address"),
      #textInput("manageremail", "Manager Email", ""),
      selectInput(inputId= "manageremail2",
                  label = "Select email from the below drop down",
                  choices = manager_emails()[1]),
      selectInput(inputId= "storenumber",
                  label = "Select store number from the below drop down",
                  choices = store_numbers[1]),
      #textInput("storenumber", "Store Number", ""),
      actionButton("add3", "Add"),
      actionButton("delete3", "Delete")),
            
    tabItem(tabName = "cityPopEntry",
      actionButton('jumpToviewStats0.4', "Switch to Main Menu"), 
      h3("Add or Update City Information"),
      DT::dataTableOutput("addCityInfo"), tags$hr(),
      h5("To update, type the exact field information and click the update button"),
      textInput("cityname", "City", ""),
      h5("Please enter state code only. Ex: GA or FL."),
      textInput("state", "State", ""),
      h5("Please enter integer only with no commas. Ex: 30000."),
      textInput("population", "Population", ""),
      actionButton("update", "Update")),             
            
    tabItem("report1", 
      actionButton('jumpToviewStats1', "Switch to Main Menu"), 
      h3("Report 1 - Manufacturer's Product Report"),
      h5("Please ensure to click on Open in Browser to download as CSV"),
      DTOutput("tbl1"),
      verbatimTextOutput("selected_manufacturer"),
      DTOutput("tbl1DD")),
      
    tabItem(tabName = "report2",
      actionButton('jumpToviewStats2', "Switch to Main Menu"),
      h3("Report 2 - Category Report"),
      h5("Please ensure to click on Open in Browser to download as CSV"),
      DTOutput("tbl2")),       
                         
    tabItem(tabName = "report3", 
      actionButton('jumpToviewStats3', "Switch to Main Menu"),
      h3("Report 3 - Actual versus Predicted Revenue for GPS units"),
      h5("Please ensure to click on Open in Browser to download as CSV"),
      DTOutput("tbl3")),
    
    tabItem(tabName = "report4", 
      actionButton('jumpToviewStats4', "Switch to Main Menu"),
      h3("Report 4 - Store Revenue by Year by State"),
      selectInput(inputId= "state",
        label = "Select state from the below drop down",
        choices = states_report4[1]),
      h5("Please ensure to click on Open in Browser to download as CSV"),
      DTOutput("tbl4")),
            
    tabItem(tabName = "report5",
      actionButton('jumpToviewStats5', "Switch to Main Menu"),
      h3("Report 5 - Air Conditioners on Groundhog Day"),
      h5("Please ensure to click on Open in Browser to download as CSV"),
      dataTableOutput("summary5")),      
    
    tabItem(tabName = "report6", 
      actionButton('jumpToviewStats6', "Switch to Main Menu"),
      h3("Report 6 - State with Highest Volume for each Category"),
      selectInput(inputId= "sale_date",
        label = "Select from the dropdown below",
        choices = states_report6[1]),
      DTOutput("tbl6"),
      verbatimTextOutput("selected_state"),
      DTOutput("tbl6DD")),
      
    tabItem(tabName = "report7",
      actionButton('jumpToviewStats7', "Switch to Main Menu"),
      h3("Report 7 - Revenue by Population"),
      h5("Please ensure to click on Open in Browser to download as CSV"),
      DTOutput("tbl7")) 
            
)))

####################################################################################################################################
server <- function(input, output, session){

  #View Statistics
  output$countStat <- renderTable({
    sqlString <- paste(readLines('Other/Sql/view_stats.sql'), collapse=' \n ')
    dbGetQuery(pool, sqlString)})
  
  #Buttons in Main Menu to Switch Tabs
  observeEvent(input$jumpToR1, 
               {newtab <- switch(input$tabs,"report1")
               updateTabItems(session, "tabs", newtab)}) 
  
  observeEvent(input$jumpToR2, 
               {newtab <- switch(input$tabs,"report2")
               updateTabItems(session, "tabs", newtab)})              
  
  observeEvent(input$jumpToR3, 
               {newtab <- switch(input$tabs,"report3")
               updateTabItems(session, "tabs", newtab)})                                   
  
  observeEvent(input$jumpToR4, 
               {newtab <- switch(input$tabs,"report4")
               updateTabItems(session, "tabs", newtab)})   
  
  observeEvent(input$jumpToR5, 
               {newtab <- switch(input$tabs,"report5")
               updateTabItems(session, "tabs", newtab)})   
  
  observeEvent(input$jumpToR6, 
               {newtab <- switch(input$tabs,"report6")
               updateTabItems(session, "tabs", newtab)})  
  
  observeEvent(input$jumpToR7, 
               {newtab <- switch(input$tabs,"report7")
               updateTabItems(session, "tabs", newtab)})  
  
  observeEvent(input$jumpToHAD, 
               {newtab <- switch(input$tabs,"holidayEntry")
               updateTabItems(session, "tabs", newtab)})  
  
  observeEvent(input$jumpToMAD, 
               {newtab <- switch(input$tabs,"managerEntry")
               updateTabItems(session, "tabs", newtab)}) 
  
  observeEvent(input$jumpToCAD, 
               {newtab <- switch(input$tabs,"cityPopEntry")
               updateTabItems(session, "tabs", newtab)}) 
  
  #Buttons from Reports to Switch back to Main Menu
  observeEvent(input$jumpToviewStats0.4,
               {newtab <- switch(input$tabs,"viewStats")
               updateTabItems(session, "tabs", newtab)})
  
  observeEvent(input$jumpToAMAD,
               {newtab <- switch(input$tabs,"assignManager")
               updateTabItems(session, "tabs", newtab)})
  
  observeEvent(input$jumpToviewStats0.1, 
               {newtab <- switch(input$tabs,"viewStats")
               updateTabItems(session, "tabs", newtab)}) 
  
  observeEvent(input$jumpToviewStats0.2, 
               {newtab <- switch(input$tabs,"viewStats")
               updateTabItems(session, "tabs", newtab)}) 
  
  observeEvent(input$jumpToviewStats0.3, 
               {newtab <- switch(input$tabs,"viewStats")
               updateTabItems(session, "tabs", newtab)}) 
  
  observeEvent(input$jumpToviewStats1, 
               {newtab <- switch(input$tabs,"viewStats")
               updateTabItems(session, "tabs", newtab)})  
  
  observeEvent(input$jumpToviewStats2, 
               {newtab <- switch(input$tabs,"viewStats")
               updateTabItems(session, "tabs", newtab)})  
  
  observeEvent(input$jumpToviewStats3, 
               {newtab <- switch(input$tabs,"viewStats")
               updateTabItems(session, "tabs", newtab)}) 
  
  observeEvent(input$jumpToviewStats4, 
               {newtab <- switch(input$tabs,"viewStats")
               updateTabItems(session, "tabs", newtab)}) 
  
  observeEvent(input$jumpToviewStats5, 
               {newtab <- switch(input$tabs,"viewStats")
               updateTabItems(session, "tabs", newtab)}) 
  
  observeEvent(input$jumpToviewStats6, 
               {newtab <- switch(input$tabs,"viewStats")
               updateTabItems(session, "tabs", newtab)}) 
  
  observeEvent(input$jumpToviewStats7, 
               {newtab <- switch(input$tabs,"viewStats")
               updateTabItems(session, "tabs", newtab)})  
  
  #---------Add/Delete Holiday------------#
  addData <- function(data) {
    query <- paste0("INSERT INTO Holiday (holidayDate,holidayname) VALUES ($1, $2)")
    
    #Error handling
    results = tryCatch({
      #Sending query
      dbSendQuery(pool, query, params=data)
      
      #If error on query send, this will catch and update won't be executed.
    }, error = function(e){
      print('Got error expected')
      print('Holiday already exists')
      showNotification("Holiday already exists", type = "warning")
    }
    )
    
    
  }
  
  deleteData <- function(data) {
    query <- paste0("DELETE FROM Holiday where holidayDate = $1 and holidayname = $2")
    dbSendQuery(pool, query, params=data)
  }
  loadData <- function() {
    query <- sprintf("SELECT * FROM Holiday ORDER BY holidaydate DESC") 
    data <- dbGetQuery(pool, query)
  }
  
  # Whenever a field is filled, aggregate all form data
  formData <- reactive({
    data <- sapply(fields, function(x) input[[x]])
    data
  })
  
  # When the Submit button is clicked, save the form data
  observeEvent(input$add, {
    addData(formData())
  })
  
  observeEvent(input$delete, {
    deleteData(formData())
  })
  
  # Show the previous responses
  # (update with current response when Submit is clicked)
  output$holidays <- DT::renderDataTable({
    input$add
    input$delete
    loadData()
  })
 
  
  
  #-------------Add Manager Information-----------#
  addData2 <- function(data) {
    query <- paste0("INSERT INTO manager (manageremail, managername, activeinactive) VALUES ($1, $2, 'Y')")
    print(data)
    #Error handling
    results = tryCatch({
      #Sending query
      dbSendQuery(pool, query, params=data)
      showNotification("Manager successfully added", type = "message") #Success notification
      
      #Update dropdown for assign manager tab. manager_emails() funciton is defined at top of script.
      updateSelectInput(session,
                        inputId= "manageremail2",
                        label = "Select email from the below drop down",
                        choices = manager_emails()[1])
      
      #If error on query send, this will catch and update won't be executed.
    }, error = function(e){
      print('Got error expectedhttp://127.0.0.1:7334/#shiny-tab-report6')
      print('Manager already exists')
      showNotification("Manager already exists", type = "warning")
    }
    )
  }
  
  deleteData2 <- function(data) {
    #Get unique manager emails who are managing stores. Turn into vector of emails.
    #This prevents from deleting manager who is still assigned to stores.
    query0 <- sprintf("SELECT DISTINCT manageremail FROM manages") 
    data2 <- dbGetQuery(pool, query0)
    store_managers <- data2[,c('manageremail')]

    check <- data[1] %in% store_managers
    if(check){
      showNotification("Can't delete manager who is managing a store", type = "warning")
    }else{
      query <- paste0("DELETE FROM manager where manageremail = $1 and managername = $2")
      dbSendQuery(pool, query, params=data)
      
      #Update dropdown for assign manager tab. manager_emails() function is defined at top of script.
      updateSelectInput(session,
                        inputId= "manageremail2",
                        label = "Select email from the below drop down",
                        choices = manager_emails()[1])
    }
  }
  
  #------------- Code To make manager Active/Inactive --------------------------#
  activeinactiveData2 <- function(data) {
    #Get unique manager emails who are managing stores. Turn into vector of emails.
    #This prevents from deleting manager who is still assigned to stores.
    query0 <- sprintf("SELECT DISTINCT manageremail FROM manages") 
    data2 <- dbGetQuery(pool, query0)
    store_managers <- data2[,c('manageremail')]
    print(store_managers)
    check <- data[1] %in% store_managers
    if(check){
      showNotification("Can't update manager status who is managing the store !!", type = "warning")
    }else{
      query <- paste0("update manager set activeinactive = CASE WHEN activeinactive = 'Y' THEN 'N' ELSE 'Y' END where manageremail = $1 and managername = $2")
      dbSendQuery(pool, query, params=data)
      showNotification("Manager status updated successfully !!", type = "warning")
      
      #Update dropdown for assign manager tab. manager_emails() function is defined at top of script.
      updateSelectInput(session,
                        inputId= "manageremail2",
                        label = "Select email from the below drop down",
                        choices = manager_emails()[1])
    }
  }
  
  loadData2 <- function() {
    query <- sprintf("SELECT * FROM manager") 
    data <- dbGetQuery(pool, query)}
  
  formData2 <- reactive({
    data <- sapply(fields2, function(x) input[[x]])
    data})
  
  observeEvent(input$add2, {
    addData2(formData2())})
  
  observeEvent(input$delete2, {
    deleteData2(formData2())})
  
  #------------- Code To make manager Active/Inactive --------------------------#
  observeEvent(input$activeinactive, {
    activeinactiveData2(formData2())})
  
  output$addmanager <- DT::renderDataTable({
    input$add2
    input$delete2
    input$activeinactive
    loadData2()})
  
  #-------------------------- Assign/Unassign managers from stores ----------------#
  addData3 <- function(data) {
    data_only_email = data[1]
  query0 <- sprintf("SELECT activeinactive from Manager where manageremail = $1")
  dataMG <- dbGetQuery(pool, query0,params=data_only_email)
  Manager_Active <- dataMG[,c('activeinactive')]
  print(Manager_Active)
  check <- 'N' == Manager_Active  
  if(check){
    showNotification("Can't assign manager who is Inactive !!", type = "warning")
  }else{
      query <- paste0("INSERT INTO manages (manageremail, storenumber) VALUES ($1, $2)")
      print(data)
      #Error handling
      results = tryCatch({
        #Sending query
        q = dbSendQuery(pool, query, params=data)
        showNotification("Manager successfully assigned to store", type = "message")
        
        #If error on query send, this will catch and update won't be executed.
      }, error = function(e){
        print('Got error expected')
        print('Manager already assigned to')
        showNotification("Manager already assigned to store", type = "warning")
      })
    }	
  } 
  
  deleteData3 <- function(data) {
    query <- paste0("DELETE FROM manages where manageremail = $1 and storenumber = $2")
    dbSendQuery(pool, query, params=data)}
  
  loadData3 <- function() {
    query <- sprintf("SELECT * FROM manages ORDER BY storenumber") 
    data <- dbGetQuery(pool, query)}
  
  formData3 <- reactive({
    data <- sapply(fields3, function(x) input[[x]])
    data})
  
  observeEvent(input$add3, {
    addData3(formData3())})
  
  observeEvent(input$delete3, {
    deleteData3(formData3())})
  
  output$assignmanager <- DT::renderDataTable({
    input$add3
    input$delete3
    loadData3()})
   
  #-------------------Add/Delete City Entry---------------------#
  updateData <- function(data) {
    query <- paste0("UPDATE city SET population = $3 WHERE cityname = $1 AND state = $2")
    dbSendQuery(pool, query, params=data)}
   
  loadData4 <- function() {
    query <- sprintf("SELECT * FROM city") 
    data <- dbGetQuery(pool, query)}
  
  formData4 <- reactive({
    data <- sapply(fields4, function(x) input[[x]])
    data})
  
  observeEvent(input$update, {
    updateData(formData4())})
  
  output$addCityInfo <- DT::renderDataTable({
    input$update
    loadData4()})
  
  
  #Report 1 
  myValue <- reactiveValues(manufacturer = '')
  shinyInput <- function(FUN, len, id, ...) {
    
    inputs <- character(len)
    for (i in seq_len(len)) {
      inputs[i] <- as.character(FUN(paste0(id, i), ...))
    }
    inputs
  }
  
  sqlString <- paste(readLines('Other/Sql/report1.sql'), collapse=' \n ')
  df <- data.frame(dbGetQuery(pool, sqlString))
  actions = shinyInput(actionButton, nrow(df), 'button_', label = "Drill Down", onclick = 'Shiny.onInputChange(\"select_button\",  this.id)' )
  df <- cbind(df, actions)
  
  output$tbl1 <- DT::renderDataTable(
    df, server = FALSE, escape = FALSE, selection = 'none', filter = 'top',rownames = FALSE, extensions = 'Buttons',options = list(dom = 'Bfrtip',buttons = c('copy', 'print', 'csv'))
  )
  
  observeEvent(input$select_button, {
    selectedRow <- as.numeric(strsplit(input$select_button, "_")[[1]][2])
    myValue$manufacturer_name <- df[selectedRow,1]
    maxdisc_sql_string <- paste0("SELECT * FROM manufacturer WHERE manufacturername = $1")
    maxdisc_df <- dbGetQuery(pool, maxdisc_sql_string, params=myValue$manufacturer_name)

    output$selected_manufacturer <- renderText({
      #Source: https://stackoverflow.com/questions/39882618/paste-text-with-a-newline-return-in-formatted-text
      paste(paste("Manufacturer Name: ", df[selectedRow, 1]), 
            paste("Max Discount: ", maxdisc_df[1, 2]), 
            paste("Total Products: ", df[selectedRow, 2]),
            paste("Average Retail Price: ", df[selectedRow, 3]), 
            paste("Min Retail Price: ", df[selectedRow, 4]), 
            paste("Max Retail Price: ", df[selectedRow, 5]), 
            sep='\n')
      
    })
    sqlString <- paste(readLines('Other/Sql/report1DD.sql'), collapse=' \n ')
    sqlString2 <- sub("<manufacturername>", myValue$manufacturer_name, sqlString)
    df2 <- data.frame(dbGetQuery(pool, sqlString2))
    output$tbl1DD <- DT::renderDataTable(
      df2, server = FALSE, rownames = FALSE, escape = FALSE, selection = 'none')})

  #Report 2
  output$tbl2 <- renderDT({
    sqlString <- paste(readLines('Other/Sql/report2.sql'), collapse=' \n ')
    dbGetQuery(pool, sqlString)}, filter = 'top',rownames = FALSE, extensions = 'Buttons', options = list(dom = 'Bfrtip',buttons = c('copy', 'print', 'csv')))

  #Report 3
  output$tbl3 <- renderDT({
    sqlString <- paste(readLines('Other/Sql/report3.sql'), collapse=' \n ')
    dbGetQuery(pool, sqlString)}, filter = 'top',rownames = FALSE, extensions = 'Buttons', options = list(dom = 'Bfrtip',buttons = c('copy', 'print', 'csv')))

  #Report 4
  output$tbl4 <- renderDT({
    sqlString <- paste(readLines('Other/Sql/report4.sql'), collapse=' \n ')
    sqlString2 <- sub("<state>", paste("'",input$state,"'",sep=""), sqlString)
    print(sqlString2)
    dbGetQuery(pool, sqlString2)}, filter = 'top',rownames = FALSE, extensions = 'Buttons', options = list(dom = 'Bfrtip',buttons = c('copy', 'print', 'csv')))

  #Report 5 
  output$summary5 <- renderDT({
    sqlString5 <- paste(readLines('Other/Sql/report5.sql'), collapse=' \n ')
    dbGetQuery(pool, sqlString5)}, filter = 'top',rownames = FALSE, extensions = 'Buttons', options = list(dom = 'Bfrtip',buttons = c('copy', 'print', 'csv')))

  
  
  
  #--------Report 6-------##
  #Create reactive values as action buttons
  myValue2 <- reactiveValues(state = '')
  
  #Create reactive value to store main dataframe.
  #This allows us to use the data frame outside of the observeEvent function.
  reactiveFrame = reactiveValues(dfr6 = '')
  
  ##Create action buttions for drill downs
  shinyInput2 <- function(FUN, len, id, ...) {
    inputs <- character(len)
    for (i in seq_len(len)) {
      inputs[i] <- as.character(FUN(paste0(id, i), ...))
    }
    inputs
  }
  
  #Listen for year/month drop down change. On change generate main report for year/month.
  observeEvent(input$sale_date, {
    
    output$selected_state <- renderText({
      ""
    })
    
    output$tbl6DD <- DT::renderDataTable(
      data.frame()
    )
    
    #Sub sale_date from drop down into query
    sqlStringr6 <- paste(readLines('Other/Sql/report6.sql'), collapse=' \n ')
    sqlStringr6_2 <- sub("<sale_date>", input$sale_date, sqlStringr6)
    
    
    ##OLD WAY##
    #sqlStringr6 <- paste(readLines('Other/Sql/report6.sql'), collapse=' \n ')
    #sqlStringr6_2 <- sub("<sale_date>", input$sale_date, sqlStringr6)
    #sqlStringr6_2 <- sub("<sale_date>", input$sale_date, sqlStringr6_2)
    
    #Create dataframe for query
    reactiveFrame$dfr6 <- data.frame(dbGetQuery(pool, sqlStringr6_2))
    
    #Create action buttons and column bind to data frame
    actions = shinyInput2(actionButton, nrow(reactiveFrame$dfr6), paste0('button_', input$sale_date, "_") ,label = "Drill Down", onclick = 'Shiny.onInputChange(\"select_button6\",  this.id)' )
    reactiveFrame$dfr6 <- cbind(reactiveFrame$dfr6, actions)
    
    ##Create data table for main report.
    output$tbl6 <- DT::renderDataTable(
      reactiveFrame$dfr6, options=list(columnDefs = list(list(visible=FALSE, targets=c(1,2)))), server = FALSE, escape = FALSE, selection = 'none')
  })
  
  #Event listener for drilldown button selectiond
  observeEvent(input$select_button6, {
    
    #Select row
    selectedRow <- as.numeric(strsplit(input$select_button6, "_")[[1]][3])
    #Set first column from row as scs_code variable
    myValue2$state <- reactiveFrame$dfr6[selectedRow,4]
    print(reactiveFrame$dfr6[selectedRow, ])
    
    output$selected_state <- renderText({
      #Source: https://stackoverflow.com/questions/39882618/paste-text-with-a-newline-return-in-formatted-text
      paste(paste("Category Name: ", reactiveFrame$dfr6[selectedRow,3]), 
            paste("State: ", reactiveFrame$dfr6[selectedRow,4]), 
            paste("Year/Month: ", reactiveFrame$dfr6[selectedRow,2]), 
            sep='\n')
      
    })
    
    #Sub state from above into query
    sqlStringr6 <- paste(readLines('Other/Sql/report6DD.sql'), collapse=' \n ')
    sqlStringr62 <- sub("<state>", myValue2$state, sqlStringr6)
    print(sqlStringr62)
    

    
    #Create and output drill down dataframe.
    dfr62 <- data.frame(dbGetQuery(pool, sqlStringr62))
    print(dfr62)
    dfr62$manager_name <- ifelse(is.na(dfr62$manager_name), "No Manager For Store", dfr62$manager_name)
    dfr62$manageremail <- ifelse(is.na(dfr62$manageremail), "No Manager For Store", dfr62$manageremail)
    output$tbl6DD <- DT::renderDataTable(
      dfr62, server = FALSE, escape = FALSE, selection = 'none'
    )}
    
  )
    
  #Report 7
  output$tbl7 <- renderDT({
    sqlString <- paste(readLines('Other/Sql/report7.sql'), collapse=' \n ')
    dbGetQuery(pool, sqlString)}, filter = 'top', rownames = FALSE, extensions = 'Buttons', options = list(dom = 'Bfrtip',buttons = c('copy', 'print', 'csv')))
    
  
}

shinyApp(ui, server)

