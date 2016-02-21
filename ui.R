#ui.R
library(shiny)


# 定义用户界面
shinyUI(fluidPage(
  
  # 标题
  titlePanel("总算弄出来了，联动效果"),
  
  # 侧边栏布局
  sidebarLayout(
    sidebarPanel(
      #selectInput("dataset", "请选一个数据：",
       #           choices = c("rock", "pressure", "cars")),
      
      #uiOutput("rockvars"),
      
      #numericInput("obs", "查看多少行数据？", 5),
      
      checkboxInput("summary", "显示概要", TRUE),
      selectInput('xcol', 'X Variable', names(iris)),
      selectInput('ycol', 'Y Variable', names(iris),
                  selected=names(iris)[[2]]),
      numericInput('clusters', 'Cluster count', 3,
                   min = 1, max = 9)
    ),
  
    
    # 展示一个HTML表格
    mainPanel(
      plotOutput('plot1'),
      #conditionalPanel("'岩石' === '岩石'", plotOutput("rockplot")),
      
      #verbatimTextOutput("summary这里也可以用中文"),
      
      tableOutput("view")
    )
  )
))
#=========================================
