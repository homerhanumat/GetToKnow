surveyVarChoices <- c("Age" = "age",
                      "Address" = "address",
                      "Major" = "major",
                      "Height" = "height",
                      "Ideal height" = "ideal_ht",
                      "Fastest speed ever driven" = "fastest",
                      "average amount of sleep" = "sleep",
                      "Seating preference" = "seat",
                      "Belief in love at first sight" = "love_first",
                      "Belief in extraterrestrial life" = "et_life",
                      "Sex" = "sex")

ui = navbarPage(
  title = "Ice-Breaker Survey",
  tabPanel(
    title = "Survey",
    fluidPage(
    column(width = 6,
      textInput("name", "Name", ""),
    sliderInput("age", "Your Age", 0, 100, 0, step = 1,ticks = FALSE),
    textInput("address", "Your Address", ""),
    selectInput("major", "Intended Major",
                choices = c("","Accounting","Athletic Training","Art","Biology",
                            "Business",
                            "Chemistry",
                            "Communication",
                            "Criminal Justice",
                            "Economics",
                            "English",
                            "Environmental Science",
                            "History",
                            "Kinesiology","Math",
                            "Political Science",
                            "Psychology",
                            "Physics","Religion",
                            "Sociology","Spanish",
                            "Sports Administration",
                            "Theater",
                            "Other Major",
                            "I Have No Idea!"),
                selected = ""),
    sliderInput("height","Your height (in inches)",0,90,40,
                step = 0.1,ticks = FALSE),
    sliderInput("ideal_ht","Your ideal height (in inches)",0,90,40,
                step = 0.1,ticks = FALSE),
    sliderInput("fastest","Fastest speed you ever drove a car (in mph)",0,200,40,
                step = 1,ticks = FALSE),
    sliderInput("sleep","Average amount of sleep at night (hours)",0,20,4,
                step = 0.1,ticks = FALSE)
    ),
    column(width = 6,
      selectInput("seat","Where you prefer to sit in a classroom:",
                  choices = c("","front","middle","back"),
                  selected = ""),
      selectInput("love_first","Do you believe in love at first sight?",
                  choices = c("","yes","no"),selected = ""),
      selectInput("et_life","Do you believe in extraterrestrial life?",
                  choices = c("","yes","no"), selected = ""),
      selectInput("sex","I am a:",choices = c("","female","male"), selected = ""),
      actionButton("submit", "Submit", class = "btn-primary")
    )
  )
  ),
  tabPanel(
    title = "Map",
    fluidPage(
      sidebarPanel(
        selectInput("varMap", "Variable to Display",
                    choices = surveyVarChoices,selected = "age"),
        actionButton("update1","Update (as others enter data)")
      ),
      mainPanel(
        leafletOutput("map")
      )
    )
  ),
  tabPanel(
    title = "Summary",
    fluidPage(
      sidebarPanel(
        selectInput("varSummary", "Variable to Display",
                    choices = surveyVarChoices,selected = "age"),
        actionButton("update2","Update (as others enter data)")
      ),
      mainPanel(
        plotOutput("graph"),
        tableOutput("summary")
      )
    )
  ),
  tabPanel(
    title = "Responses",
    actionButton("update3", "Update (as others enter data)"),
    HTML("<p> </p>"),
    DT::dataTableOutput("responses")
  )
)