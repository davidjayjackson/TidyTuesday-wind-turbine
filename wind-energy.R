## TidyTuesday for Oct. 27, 2020.
## Canadian Wind Turbines
## ## Shout out to Julia Silge:
## https://youtu.be/EDQnJF9LKHQ
library(ggplot2)
library(scales)
library(dplyr)
## Read data
turbine <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-10-27/wind-turbine.csv')
##
turbine_province <- turbine %>% group_by(province_territory) %>% count()
## Plot of total wind turbines by Province
x11()
ggplot(turbine_province) + geom_col(aes(x=reorder(province_territory,n),y=n)) + coord_flip() + labs(title="Number of Turbines by Province",x="Number of Turbines")
##
## Total capacity: Electrical capacity in megawatts
##
capacity_kwmw <- turbine %>% group_by(province_territory) %>%
    summarize(megawatts = sum(total_project_capacity_mw),
              kilowatts = sum(turbine_rated_capacity_k_w))
## Plot of (Electricity) Capacity by Province
x11()
ggplot(capacity_kwmw) + geom_col(aes(x=reorder(province_territory,megawatts),y=megawatts)) + coord_flip()+
    scale_y_continuous(labels = comma) + labs(title="Total Capacity by Province: Megawatts",
                                              x="Province", y="Megawatts")
x11()
ggplot(capacity_kwmw) + geom_col(aes(x=reorder(province_territory,kilowatts),y=kilowatts)) + coord_flip()+
    scale_y_continuous(labels = comma) + labs(title="Total Capacity by Province: Kilowatts",
                                              x="Province", y="Kilowatts")
