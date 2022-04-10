library(shiny)
library("ggplot2")
library("tidyverse")
library("plotly")
library("DT")
library("dplyr")
library(stringr)
library("reshape2")

#Sys.getlocale()

# Sys.setlocale("LC_MESSAGES", 'en_GB.UTF-8')
# Sys.setenv(LANG = "en_US.UTF-8")

tech_data <- read.csv("data/cleaned_mentalHealthInTech.csv")
# Function
build_chart_for_tech <- function(data, disorder) {
  
  # Data manipulation based on `disorder`
  counts_df <- tech_data %>%
    filter(tech_data[disorder] != "NA") %>%
    group_by(offer_resources) %>%
    count()
  
  # bar chart
  plot_ly(
    counts_df,
    x = ~counts_df$offer_resources,
    y = ~counts_df$n, 
    type = 'bar',
    color = ~counts_df$offer_resources
  ) %>%
    layout(
      #title = "Top 10 Percent change from starting to mid career",
      xaxis = list(title = "response"),
      yaxis = list(title = "number of people")
    )
}



# Define server logic required to draw a histogram
server <- function(input, output, session){
  
  #----------------------------------------------------------------------------#
  # data input
  #----------------------------------------------------------------------------#
  
  # avg
  combined_avg <- read.csv("data/combined_avg.csv", stringsAsFactors = FALSE, skip = 1)
  
  # search term
  anxiety_st <- read.csv("data/anxiety_st.csv", stringsAsFactors = FALSE, skip = 1)
  depression_st <- read.csv("data/depression_st.csv", stringsAsFactors = FALSE, skip = 1)
  insomnia_st <- read.csv("data/insomnia_st.csv", stringsAsFactors = FALSE, skip = 1)
  mental_health_st <- read.csv("data/mental_health_st.csv", stringsAsFactors = FALSE, skip = 1)
  ocd_st <- read.csv("data/ocd_st.csv", stringsAsFactors = FALSE, skip = 1)
  
  
  ## merge datasets
  df_list <- list(anxiety_st, depression_st, insomnia_st, mental_health_st, ocd_st)
  df_list <- df_list %>% reduce(full_join, by="Week")
  
  ## rename cols
  colnames(df_list) <- c("Week", "anxiety","depression","insomnia","mental_health","ocd")
  colnames(combined_avg) <- c("Week","ocd","depression","anxiety","insomnia","mental_health")
  
  ## Change Week datatype
  df_list$Week <- as.Date(df_list$Week, format = "%Y-%m-%d")
  combined_avg$Week <- as.Date(combined_avg$Week, format = "%Y-%m-%d")
  
  # -------------------------------
  tech_data <- read.csv("data/cleaned_mentalHealthInTech.csv")
  
  
  #----------------------------------------------------------------------------#
  # Chart of Interest Term data
  #----------------------------------------------------------------------------#
  output$first_chart_plot <- renderPlot({
    
    req(input$select_term)
    req(input$Week_input)
    
    Week_convert <- as.character(input$Week_input)
    
    d1 <- as.Date(Week_convert[1])
    d2 <- as.Date(Week_convert[2])
    
    # modify time range - x variable of the plot
    # search_term_us <- filter(search_term_us, Week >= d1, Week <= d2)
    df_list <- filter(df_list, Week >= d1, Week <= d2)
    
    term_vector <- as.character(input$select_term)
    
    plot_df <- melt(df_list,  id.vars = 'Week', variable.name = 'Terms')
    plot_df <- subset(plot_df, Terms %in% term_vector)
    
    ggplot(data = plot_df, aes(Week, value, group=Terms)) +
      geom_line(aes(colour = Terms), size = 2)+
      labs(
        title="Mental Health Search Terms",
        subtitle ="Weekly data collected by Google Trends(in 2021)",
        x="Week",
        y="Search Interest (0~100)"
      )
  })
  
  
  #----------------------------------------------------------------------------#
  # Boxplot of Avg
  #----------------------------------------------------------------------------#
  output$box_plot_avg <- renderPlot({
    
    plot_avg <- melt(combined_avg,  id.vars = 'Week', variable.name = 'Terms_avg')
    
    ggplot(data = plot_avg, aes(x=Terms_avg, value)) +
      geom_boxplot(
        outlier.colour = "black",
        outlier.shape = 16,
        outlier.size = 2,
        notch = FALSE
      ) + 
      coord_flip() +
      labs(
        title = "Terms Searching Average in 2021",
        subtitle = "Data collected by Google Trends",
        x="Terms",
        y="Average"
      )
    
  })
  
  #----------------------------------------------------------------------------#
  # Wrangle Data for chart_2 Input
  #----------------------------------------------------------------------------#
  output$second_chart <- renderPlotly({
    build_chart_for_tech(tech_data, input$choose_disorder)
  })
  
  #----------------------------------------------------------------------------#
  # Wrangle Data for chart_3 Input
  #----------------------------------------------------------------------------#

  
  #----------------------------------------------------------------------------#
  # Wrangle Data for Table
  #----------------------------------------------------------------------------#
  
}
