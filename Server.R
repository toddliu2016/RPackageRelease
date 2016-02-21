#Server.R
library(shiny)
library(datasets)


palette(c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3",
          "#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999"))
# 定义服务器逻辑
shinyServer(function(input, output) {
  
  # Combine the selected variables into a new data frame
  selectedData <- reactive({
    iris[, c(input$xcol, input$ycol)]
  })
  
  clusters <- reactive({
    kmeans(selectedData(), input$clusters)
  })
  
  output$plot1 <- renderPlot({
    par(mar = c(5.1, 4.1, 0, 1))
    plot(selectedData(),
         col = clusters()$cluster,
         pch = 20, cex = 3)
    points(clusters()$centers, pch = 4, cex = 4, lwd = 4)
  })
  ###############
  cars2 <- cars
  cars2$random <- sample(
    strsplit("随意放一些中文字符", "")[[1]], nrow(cars2), replace = TRUE
  )
  
  # 返回数据集，注意input$dataset返回的结果可能是中文“岩石”
  datasetInput <- reactive({
    switch(input$dataset,
           "rock" = rock2,
           "pressure" = pressure,
           "cars" = cars2)
  })
  
  output$rockvars <- renderUI({
    
    #if (input$dataset != "岩石") return()
    selectInput("vars", "从岩石数据中选择一列作为自变量", names(rock2)[-1])
  })
  
  output$rockplot <- renderPlot({
   
    validate(need(input$vars, ""))
    par(mar = c(4, 4, .1, .1))
    plot(as.formula(paste("面积 ~ ", input$vars)), data = rock2)
  })
  
  # 数据概要信息
  output[['summary这里也可以用中文']] <- renderPrint({
    return()
    if (!input$summary) return(cat("数据概要信息被隐藏了！"))
    dataset <- datasetInput()
    summary(dataset)
  })
  
  # 显示前"n"行数据
  output$view <- renderTable({
    #head(datasetInput(), n = input$obs)
    head(selectedData(), n = input$clusters)
  })
})
