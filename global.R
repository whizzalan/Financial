

library(stringr) # str_pad
dir_list <- paste0("E:/George/data/Financial/2014",str_pad(seq(12),2,pad="0"))

DF <- data.frame()
for (dir in dir_list){
  files_list <- list.files(dir,full.names = TRUE)  
  for (i in files_list){
    print(i)
    DF <- rbind(DF,read.csv(i))
    print(dim(DF))
  }
}
## Number of Data = 74201,4Mb ##
print(object.size(DF),unit="MB")
### 日後資料大要使用，讀資料也有點慢 ###
# library(data.table)

## combine date & time to datetime ##
date_time_str <- paste0(as.character(DF$DATE),str_pad(as.character(DF$TIME),6,pad="0"))
## Note. dplyr not support POSIXct, change to character ##
DF$datetime <- as.character(strptime(date_time_str,format = "%Y%m%d%H%M%S"))
DF$date <- as.Date(DF$datetime)
DF$time <- paste0(strftime(DF$datetime,"%H"),":",str_pad(as.character(floor(as.numeric(strftime(DF$datetime,"%M"))/5)*5),2,pad="0"))

names_list <<- c("OPEN","HIGH","LOW","CLOSE","VOLUME","MONEY")
DF <<- DF
## NSE 問題~ ##
#http://stackoverflow.com/questions/27197617/filter-data-frame-by-character-column-name-in-dplyr
#http://cran.r-project.org/web/packages/dplyr/vignettes/nse.html
# install.packages("lazyeval")
# expr <- interp(quote(ff == max(ff)),ff=as.name(input$value))
# result <- DF %>%
#   group_by(date) %>%
#   filter( expr) %>%
#   select(date,time,OPEN,HIGH,LOW,CLOSE,VOLUME)


#seq(range(date_time)[1],range(date_time)[2],by="5 min")
