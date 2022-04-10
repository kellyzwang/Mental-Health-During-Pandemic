library("shiny")
library("dplyr")
library("plotly")
library("ggplot2")
library("shinythemes")
library("gfonts")



tab_introduction_panel <- tabPanel(
  "Introduction",
  h1("Enhanced Mindfulness: Mental Health"),
  h3("Introduction"),
  p("The pandemic has increased the prevalence of mental illness. 
    Social quarantining has caused a countless number of people 
    to become locked away in their homes without interacting with
    any new people. This may result in social isolation, loss of 
    income, loneliness, inactivity, limited access to basic services,
    and decreased family and social support. We decided to investigate
    different aspects of people's personal welling during the pandemic
    by turning data into insights."),
  
  h3("How to use our website"),
  tags$ul(id = "list1",
    tags$li(strong("Tab `Search Avg. and Trends`:"), "This tab allows users to 
            visualize the trends of popular psychological terms over time and 
            the comparison between the search interest of those terms. 
            By checking the boxes, users can filter the terms they desire 
            to compare. Users can also adjust the time range of line graph 
            to understand periodic trends of search interest. ",
            "Notice that the line graph only reflects the time variation of single 
            terms and does not reflect absolute comparison in click rates between 
            different terms. In order to get insight of comparative search interest, 
            users can infer from the bottom graph, which compares the average 
            interest of each term in a boxplot."),
    br(),
    tags$li(strong("Tab `Mental Health in Workplace`:"), "This tab allows users to 
    visualize whether employees received mental health resources from their company. 
    Users can select a specific mental disorder type to view the survey responses on 
    whether they have access to help. Our data visualization answers the question: “how 
    many employees received resources and support from their employers, based on people
    who have been diagnosed with different types of mental illness?” People who completed 
    the survey responded “yes”, “no”, or “I don’t know” to the survey question: “does your 
    employer provide resources to learn more about mental health issues and how to seek help?")),
    
  h3("Dataset Overview"),
    p("Data for `Mental Health in Workplace` contains survey results for OSMH Mental Health In Tech Survey.
      This survey is done yearly and we used the 2021 results.")
)






