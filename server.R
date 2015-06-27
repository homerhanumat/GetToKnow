library(shiny)
library(magrittr)
library(DT)
library(leaflet)
library(dismo)

# for markers
iconURL <- "Tiger_head_solo.png"

# read in previous responses
if (file.exists("responses.csv")) {
  responses <- read.csv(file = "responses.csv", header = TRUE, stringsAsFactors = TRUE)
  responses$time <- as.POSIXct(as.character(responses$time))
} else {
  address <- "198 Hiawatha Trail, Georgetown KY 40324, USA"
  location <- geocode(address, oneRecord = TRUE)
  leaders <- data.frame(name = "Homer",
                        age = 52,
                        address = address,
                        major = "Philosophy",
                        height = 74.8,
                        ideal_ht = 74.8,
                        fastest = 85,
                        sleep = 7,
                        love_first = "yes",
                        et_life = "yes",
                        sex = "male",
                        time = "2015-06-25 12:00:00 EDT",
                        latitude = location$lat,
                        longitude = location$lon)
  write.csv(leaders, file = "responses.csv", row.names = FALSE)
}

function(input,output) {
  
  observeEvent(input$submit,{
    location <- geocode(input$adress, oneRecord = TRUE)
    gather <- c(input$name,
                input$age,
                input$major,
                input$height,
                input$ideal_ht,
                input$fastest,
                input$sleep,
                input$seat,
                input$love_first,
                input$extra_life,
                input$sex,
                Sys.time(),
                latitude = location$lat,
                longitude = location$lon
    )
    response <- as.matrix(t(gather))
    write.table(response, file = "responses.csv", 
                append = TRUE, row.names = FALSE, sep = ",",
                col.names = FALSE)
  })
  
  observe({
    input$update1
    input$update2
    input$update3
    input$submit
    responses <<- read.csv(file = "responses.csv", header = TRUE)
    responses$time <<- as.POSIXct((as.character(responses$time)))
  })
  
  output$map <- renderLeaflet({
    input$update1
    var <- input$varMap
    latitude <- responses$latitude
    longitude <- responses$longitude
    info <- paste(responses$name,":  ",responses[,var])
    m <- leaflet(responses) %>%
      addTiles() %>%
      addMarkers(lat = latitude, lng = longitude, popup = info, 
                 icon = list(iconUrl = iconURL, iconSize = c(40,40)))
    m
  })
  
  output$responses <- DT::renderDataTable({
    input$update3
    responses2 <- responses
    responses2$address <- NULL
    responses2$latitude <- NULL
    responses2$longitude <- NULL
    datatable(responses2,rownames = FALSE, 
              caption = "Here are all the responses:",
              filter = "bottom") %>%
      formatStyle(
        'name',
        backgroundColor = styleEqual(input$name, 'lightblue'))
  })
  
}