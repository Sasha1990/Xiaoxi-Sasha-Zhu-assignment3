#Econ294 Assigement3
#problem 0#
print("Xiaoxi Sasha Zhu")
print(1505138)
print("xzhu25@ucsc.edu")

#problem 1#
library(foreign)
df.ex <-read.dta("https://github.com/EconomiCurtis/econ294_2015/raw/master/data/org_example.dta")

#problem 2#
require(dplyr)
df.ex.2a <- dplyr::filter(df.ex,year == 2013 & month == 12)
print(nrow(df.ex.2a))
df.ex.2b <- dplyr::filter(df.ex,year == 2013 & (month == 7 |month == 8 |month== 9))
print(nrow(df.ex.2b))

#problem 3#
df.ex.3a <- dplyr::arrange(df.ex,year,month)

#problem 4#
df.ex.4a <- dplyr::select(df.ex,year:age)
df.ex.4b <- dplyr::select(df.ex,year,age,starts_with("i"))
print(distinct(select(df.ex,state)))

#problem 5#
stndz <- function(x){(x - mean(x, na.rm = T))  /  sd(x, na.rm = T)}
nrmlz <- function(x){(x-min(x, na.rm = T))/(max(x, na.rm = T)-min(x, na.rm = T))}

df.ex.5a <- dplyr::mutate(df.ex, rw.stndz = stndz(rw), rw_nrmlz = nrmlz(rw)) %>%
  select(rw.stndz, rw_nrmlz)

df.ex.5b <- df.ex %>% dplyr::group_by(year,month) %>% 
  dplyr::mutate(rw.stndz = stndz(rw), rw_nrmlz = nrmlz(rw),count = n()) %>%
  select(rw.stndz, rw_nrmlz,count)

#problem 6#
df.ex.6 <- df.ex %>% 
  dplyr::group_by(year,month,state)%>%
  dplyr::summarise(
    rw_min = min(rw, .25, na.rm = T),
    rw_quantile1 = quantile(rw, .25, na.rm = T),
    rw_quantile2 = quantile(rw, .75, na.rm = T),
    rw_mean = mean(rw, na.rm = T),
    rw_median = median(rw, na.rm = T),
    rw_max = max(rw, na.rm = T),
    count = n())

print(df.ex.6%>%ungroup()%>%arrange(desc(rw_mean))%>%select(year,month,state)%>%head(1))

#problem 7#
df.ex.7a <- df.ex%>% group_by(year,month,state)%>% ungroup()%>% arrange(year,month,as.character(state))
