#----------------------------------------------------------------------------#
# Import Library
#----------------------------------------------------------------------------#
library("shiny")
library("dplyr")
library("plotly")
library("ggplot2")
library("shinythemes")
library("DT")

#----------------------------------------------------------------------------#
# Import source
#----------------------------------------------------------------------------#

source("tab_panels/tab_introduction_panel.R", encoding="utf-8")


#----------------------------------------------------------------------------#
# Define content for the first page
#----------------------------------------------------------------------------#
page_one <- tabPanel(
  "Introduction", 
  tab_introduction_panel)

#----------------------------------------------------------------------------#
# First Chart
#----------------------------------------------------------------------------#

first_chart_sidebar <- sidebarPanel(
  
  # choose term - checkbox
  checkboxGroupInput(
    inputId = "select_term",
    label = h3("Term Filter:"),
    choices = list("anxiety",
                   "depression",
                   "insomnia",
                   "mental_health",
                   "ocd"
    ),
    selected = "anxiety"
  ),
  
  # choose time range - slider
  sliderInput(
    "Week_input",
    "Time Range:",
    min = as.Date("2021/01/03","%Y/%m/%d"),
    max = as.Date("2021/12/26","%Y/%m/%d"),
    value = c(as.Date("2021/01/03",timeFormat="%Y/%m/%d"), as.Date("2021/12/26", timeFormat="%Y/%m/%d"))
  ),
  
  br(),
  br(),
  br(),
  br(),
  plotOutput("box_plot_avg")
  
  
)

first_chart_main <- mainPanel(
  plotOutput("first_chart_plot"),
  br(),
  br(),
  br(),
  p("We can notice from the Line chart that around May mental health and 
  insomnia are searched pretty frequently, which might be related to the 
  encouragement of vaccination by the U.S. government. The increase of vaccination 
  rate might lead to an increasing concern of mental health related to possible 
  side-effects of the vaccine. However, the anxiety got smoother when time was 
  reaching July, which might be attributed to the confidence towards vaccine 
  protection and the revival of social life. The rising of interest on these 
  terms around September and October might be caused by the switch of working 
  and learning environment from online to in-person. Besides COVID-19, there are 
  many possible confounding factors like seasonal affective disorders and change 
  to winter time."),
  br(),
  p("From the searching average comparison graph, we can see that the two most 
  concerning terms are anxiety and depression, which can be used by search engines 
  to improve recommendation algorithms to help people relax. Recommended topics to 
  those users might be calm music, relaxing or funny videos, and so on. In addition, 
  financial investments in those fields can be potentially profitable, and activities 
  that help people cope with anxiety and mood issues are expected to be popular.")
  
)

first_chart_panel <- tabPanel(
  "Search Avg. and Trends",
  
  sidebarLayout(
    first_chart_sidebar,
    first_chart_main,
    position="right"
  )
)


#----------------------------------------------------------------------------#
# Second Chart
#----------------------------------------------------------------------------#

#Create a Siderbar for second chart panel

second_chart_sidebar <- sidebarPanel(
  selectInput(
    inputId = "choose_disorder",
    label = "Select a disorder:",
    choices = list("Anxiety Disorder (Generalized, Social, Phobia, etc)" = "anxiety", 
                  "Mood Disorder (Depression, Bipolar Disorder, etc)" = "mood",
                  "Psychotic Disorder (Schizophrenia, Schizoaffective, etc)" = "psychotic",
                  "Eating Disorder (Anorexia, Bulimia, etc)" = "eating",
                  "Attention Deficit Hyperactivity Disorder" = "ADHD",
                  "Obsessive-Compulsive Disorder" = "obsessive",
                  "Stress Response Syndromes" = "stressresponse",
                  "Substance Use Disorder" = "substance",
                  "Addictive Disorder" = "addictive")
  )
)

#Create a main panel for second chart panel
second_chart_main <- mainPanel(
  h3("Survey results on whether employees received mental health resources from their employer"),
  plotlyOutput(
    outputId = "second_chart"
  ),
  br(),
  br(),
  br(),
  p("This is an interactive data visualization that visualizes people’s responses on whether they are provided with mental health resources from their employers. Our goal is to inform everyone, especially employers, that there’s still a lot of people who don’t have access to mental health resources in their workplace. Through our data visualization results, we found out that most of the people who have been diagnosed with eating disorder, stress response syndromes, or substance use disorder don’t have access to resources. Therefore, employers should pay more attention to providing help and access to resources for these mental disorders."),
  br(),
  br()
)

second_chart_panel <- tabPanel(
  "Mental Health in workplace",
  second_chart_sidebar,
  second_chart_main
)




#----------------------------------------------------------------------------#
# Reference
#----------------------------------------------------------------------------#

reference_panel <- tabPanel(
  "Reference",
  h3("Reference"),
  br(),
  tags$ol(id = "list2",
          tags$li("OSMH Mental Health In Tech Survey 2021",
                  a(href="https://www.kaggle.com/datasets/osmihelp/osmh-2021-mental-health-in-tech-survey-results?select=OSMI+2021+Mental+Health+in+Tech+Survey+Results+.csv",
                    "https://www.kaggle.com/datasets/osmihelp/osmh-2021-mental-health-in-tech-survey-results?select=OSMI+2021+Mental+Health+in+Tech+Survey+Results+.csv") ),
          br(),
          tags$li("How mental health care should change as a consequence of the COVID-19 pandemic",
                  a(href="https://www.sciencedirect.com/science/article/pii/S2215036620303072",
                    "https://www.sciencedirect.com/science/article/pii/S2215036620303072")),
          br()
          
  ))



#----------------------------------------------------------------------------#
# Pass each page to a multi-page layout 
#----------------------------------------------------------------------------#
ui <- navbarPage(
  "Mental Health during Pandemic",
  theme = shinytheme("lumen"),
  page_one,
  first_chart_panel,
  second_chart_panel,
  reference_panel,
  includeCSS("style.css")
)
