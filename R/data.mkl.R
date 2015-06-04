# MASS KILLING EPISODE DATA MAKER
# Jay Ulfelder
# 2014-09-02

# This script creates a country-year data set that spans the period 1945-2013. It is based on the data set
# described in Ulfelder and Valentino (2008) (http://ssrn.com/abstract=1703426_). I am solely responsible for
# updates for the years since 2006.

# Clear workspace
rm(list=ls(all=TRUE)) 

#set working directory
setwd(commandArgs(TRUE)[1])

# Get working directory
wd <- getwd()

# Load required functions
source(paste0(wd, "/R/f.countryyearrackit.R"))
source(paste0(wd, "/R/f.pitfcodeit.R"))

# Create rack of names and years, starting in 1945, ending in 2013, with PITF codes
rack <- pitfcodeit(countryyearrackit(1945, 2013), "country")

# Create columns for new variables with zeros
rack$mkl.start <- 0       # Onset of any new episodes during year
rack$mkl.end <- 0         # End of any mkl.ongoing episodes during year
rack$mkl.ongoing <- 0     # Any mkl.ongoing episodes during year
rack$mkl.type <- 0        # Context in which new episode started: 1=civil war, 2=uprising, 3=repression, 4 other
rack$mkl.ever <- 0        # Any episodes in the country since 1945

# Bulgaria, 1944-1956 (repression)
rack$mkl.start[rack$country=="Bulgaria" & rack$year==1944] <- 1
rack$mkl.end[rack$country=="Bulgaria" & rack$year==1956] <- 1
rack$mkl.ongoing[rack$country=="Bulgaria" & rack$year>=1944 & rack$year<=1956] <- 1
rack$mkl.type[rack$country=="Bulgaria" & rack$year==1944] <- 3
rack$mkl.ever[rack$country=="Bulgaria" & rack$year>=1944] <- 1

# Albania, 1944-1985 (repression)
rack$mkl.start[rack$country=="Albania" & rack$year==1944] <- 1
rack$mkl.end[rack$country=="Albania" & rack$year==1985] <- 1
rack$mkl.ongoing[rack$country=="Albania" & rack$year>=1944 & rack$year<=1985] <- 1
rack$mkl.type[rack$country=="Albania" & rack$year==1944] <- 3
rack$mkl.ever[rack$country=="Albania" & rack$year>=1944] <- 1

# Poland, 1945-1956 (repression)
rack$mkl.start[rack$country=="Poland" & rack$year==1945] <- 1
rack$mkl.end[rack$country=="Poland" & rack$year==1956] <- 1
rack$mkl.ongoing[rack$country=="Poland" & rack$year>=1945 & rack$year<=1956] <- 1
rack$mkl.type[rack$country=="Poland" & rack$year==1945] <- 3
rack$mkl.ever[rack$country=="Poland" & rack$year>=1945] <- 1

# Poland, 1945-1948 (expulsion of Germans)
# Subsumed under preceding case

# Poland, 1945-1946 (Ukranian nationalists)
# Subsumed under preceding case

# Hungary, 1945-1960 (repression)
rack$mkl.start[rack$country=="Hungary" & rack$year==1945] <- 1
rack$mkl.end[rack$country=="Hungary" & rack$year==1960] <- 1
rack$mkl.ongoing[rack$country=="Hungary" & rack$year>=1945 & rack$year<=1960] <- 1
rack$mkl.type[rack$country=="Hungary" & rack$year==1945] <- 3
rack$mkl.ever[rack$country=="Hungary" & rack$year>=1945] <- 1

# Yugoslavia, 1945-1956 (repression)
rack$mkl.start[rack$country=="Yugoslavia" & rack$year==1945] <- 1
rack$mkl.end[rack$country=="Yugoslavia" & rack$year==1956] <- 1
rack$mkl.ongoing[rack$country=="Yugoslavia" & rack$year>=1945 & rack$year<=1956] <- 1
rack$mkl.type[rack$country=="Yugoslavia" & rack$year==1945] <- 3
rack$mkl.ever[rack$country=="Yugoslavia" & rack$year>=1945] <- 1

# Yugoslavia, 1945-1948 (expulsion of Germans)
# Subsumed under preceding case

# Romania, 1945-1989 (repression)
rack$mkl.start[rack$country=="Romania" & rack$year==1945] <- 1
rack$mkl.end[rack$country=="Romania" & rack$year==1989] <- 1
rack$mkl.ongoing[rack$country=="Romania" & rack$year>=1945 & rack$year<=1989] <- 1
rack$mkl.type[rack$country=="Romania" & rack$year==1945] <- 3
rack$mkl.ever[rack$country=="Romania" & rack$year>=1945] <- 1

# Czechoslovakia, 1945-1946 (expulsion of Germans)
rack$mkl.start[rack$country=="Czechoslovakia" & rack$year==1945] <- 1
rack$mkl.end[rack$country=="Czechoslovakia" & rack$year==1946] <- 1
rack$mkl.ongoing[rack$country=="Czechoslovakia" & rack$year>=1945 & rack$year<=1946] <- 1
rack$mkl.type[rack$country=="Czechoslovakia" & rack$year==1945] <- 4
rack$mkl.ever[rack$country=="Czechoslovakia" & rack$year>=1945] <- 1

# Czechoslovakia, 1948-1963 (repression)
rack$mkl.start[rack$country=="Czechoslovakia" & rack$year==1948] <- 1
rack$mkl.end[rack$country=="Czechoslovakia" & rack$year==1963] <- 1
rack$mkl.ongoing[rack$country=="Czechoslovakia" & rack$year>=1948 & rack$year<=1963] <- 1
rack$mkl.type[rack$country=="Czechoslovakia" & rack$year==1948] <- 3

# Philippines, 1946-1954 (Huks)
rack$mkl.start[rack$country=="Philippines" & rack$year==1946] <- 1
rack$mkl.end[rack$country=="Philippines" & rack$year==1954] <- 1
rack$mkl.ongoing[rack$country=="Philippines" & rack$year>=1946 & rack$year<=1954] <- 1
rack$mkl.type[rack$country=="Philippines" & rack$year==1946] <- 1
rack$mkl.ever[rack$country=="Philippines" & rack$year>=1946] <- 1

# Philippines, 1969- (New Peoples Army)
rack$mkl.start[rack$country=="Philippines" & rack$year==1969] <- 1
rack$mkl.ongoing[rack$country=="Philippines" & rack$year>=1969] <- 1
rack$mkl.type[rack$country=="Philippines" & rack$year==1969] <- 1

# Philippines, 1972-1986 (Moro Liberation)
rack$mkl.start[rack$country=="Philippines" & rack$year==1972] <- 1
rack$mkl.end[rack$country=="Philippines" & rack$year==1986] <- 1
rack$mkl.ongoing[rack$country=="Philippines" & rack$year>=1972 & rack$year<=1986] <- 1
rack$mkl.type[rack$country=="Philippines" & rack$year==1972] <- 1

# China-Taiwan, 1947
rack$mkl.start[rack$country=="China" & rack$year==1947] <- 1
rack$mkl.end[rack$country=="China" & rack$year==1947] <- 1
rack$mkl.ongoing[rack$country=="China" & rack$year==1947] <- 1
rack$mkl.type[rack$country=="China" & rack$year==1947] <- 2
rack$mkl.ever[rack$country=="China" & rack$year>=1947] <- 1

# China, 1949-1977 (Communist)
rack$mkl.start[rack$country=="China" & rack$year==1949] <- 1
rack$mkl.end[rack$country=="China" & rack$year==1977] <- 1
rack$mkl.ongoing[rack$country=="China" & rack$year>=1949 & rack$year<=1977] <- 1
rack$mkl.type[rack$country=="China" & rack$year==1949] <- 3

# China, 1954-1977 (Tibet)
rack$mkl.start[rack$country=="China" & rack$year==1954] <- 1
rack$mkl.end[rack$country=="China" & rack$year==1977] <- 1
rack$mkl.ongoing[rack$country=="China" & rack$year>=1954 & rack$year<=1977] <- 1
rack$mkl.type[rack$country=="China" & rack$year==1954] <- 1

# Burma/Myanmar, 1948- (ethnic separatists)
rack$mkl.start[rack$country=="Burma" & rack$year==1948] <- 1
rack$mkl.ongoing[rack$country=="Burma" & rack$year>=1948] <- 1
rack$mkl.type[rack$country=="Burma" & rack$year==1948] <- 1
rack$mkl.ever[rack$country=="Burma" & rack$year>=1948] <- 1

# Burma/Myanmar, 1948-1990 (Communist insurgency/repression)
# Subsumed under preceding case

# Korea, 1948-1950 (civil violence in south - Cheju and Yosu)
rack$mkl.start[rack$country=="South Korea" & rack$year==1948] <- 1
rack$mkl.end[rack$country=="South Korea" & rack$year==1950] <- 1
rack$mkl.ongoing[rack$country=="South Korea" & rack$year>=1948 & rack$year<=1950] <- 1
rack$mkl.type[rack$country=="South Korea" & rack$year==1948] <- 1
rack$mkl.ever[rack$country=="South Korea" & rack$year>=1948] <- 1

# North Korea, 1948- (repression)
rack$mkl.start[rack$country=="North Korea" & rack$year==1948] <- 1
rack$mkl.ongoing[rack$country=="North Korea" & rack$year>=1948] <- 1
rack$mkl.type[rack$country=="North Korea" & rack$year==1948] <- 3
rack$mkl.ever[rack$country=="North Korea" & rack$year>=1948] <- 1

# Guatemala, 1954-1996 (civil war and repression)
rack$mkl.start[rack$country=="Guatemala" & rack$year==1954] <- 1
rack$mkl.end[rack$country=="Guatemala" & rack$year==1996] <- 1
rack$mkl.ongoing[rack$country=="Guatemala" & rack$year>=1954 & rack$year<=1996] <- 1
rack$mkl.type[rack$country=="Guatemala" & rack$year==1954] <- 1
rack$mkl.ever[rack$country=="Guatemala" & rack$year>=1954] <- 1

# North Vietnam, 1954-1957 (repression)
rack$mkl.start[rack$country=="North Vietnam" & rack$year==1954] <- 1
rack$mkl.end[rack$country=="North Vietnam" & rack$year==1957] <- 1
rack$mkl.ongoing[rack$country=="North Vietnam" & rack$year>=1954 & rack$year<=1957] <- 1
rack$mkl.type[rack$country=="North Vietnam" & rack$year==1954] <- 3
rack$mkl.ever[rack$country=="North Vietnam" & rack$year>=1954] <- 1

# South Vietnam, 1954-1975 (civil war)
rack$mkl.start[rack$country=="South Vietnam" & rack$year==1954] <- 1
rack$mkl.end[rack$country=="South Vietnam" & rack$year==1975] <- 1
rack$mkl.ongoing[rack$country=="South Vietnam" & rack$year>=1954 & rack$year<=1975] <- 1
rack$mkl.type[rack$country=="South Vietnam" & rack$year==1954] <- 1
rack$mkl.ever[rack$country=="South Vietnam" & rack$year>=1954] <- 1

# Vietnam, 1975- (post-war repression)
rack$mkl.start[rack$country=="Vietnam" & rack$year==1975] <- 1
rack$mkl.ongoing[rack$country=="Vietnam" & rack$year>=1975] <- 1
rack$mkl.type[rack$country=="Vietnam" & rack$year==1975] <- 1
rack$mkl.ever[rack$country=="Vietnam" & rack$year>=1975] <- 1

# Sudan, 1956-1972 (civil war)
rack$mkl.start[rack$country=="Sudan" & rack$year==1956] <- 1
rack$mkl.end[rack$country=="Sudan" & rack$year==1972] <- 1
rack$mkl.ongoing[rack$country=="Sudan" & rack$year>=1956 & rack$year<=1972] <- 1
rack$mkl.type[rack$country=="Sudan" & rack$year==1956] <- 1
rack$mkl.ever[rack$country=="Sudan" & rack$year>=1956] <- 1

# Sudan, 1983-2005
rack$mkl.start[rack$country=="Sudan" & rack$year==1983] <- 1
rack$mkl.end[rack$country=="Sudan" & rack$year==2005] <- 1
rack$mkl.ongoing[rack$country=="Sudan" & rack$year>=1983 & rack$year<=2005] <- 1
rack$mkl.type[rack$country=="Sudan" & rack$year==1983] <- 1

# Haiti, 1958-1986 (Duvalier-repression)
rack$mkl.start[rack$country=="Haiti" & rack$year==1958] <- 1
rack$mkl.end[rack$country=="Haiti" & rack$year==1986] <- 1
rack$mkl.ongoing[rack$country=="Haiti" & rack$year>=1958 & rack$year<=1986] <- 1
rack$mkl.type[rack$country=="Haiti" & rack$year==1958] <- 3
rack$mkl.ever[rack$country=="Haiti" & rack$year>=1958] <- 1

# Cuba, 1959-1970 (Castro-repression)
rack$mkl.start[rack$country=="Cuba" & rack$year==1959] <- 1
rack$mkl.end[rack$country=="Cuba" & rack$year==1970] <- 1
rack$mkl.ongoing[rack$country=="Cuba" & rack$year>=1959 & rack$year<=1970] <- 1
rack$mkl.type[rack$country=="Cuba" & rack$year==1959] <- 3
rack$mkl.ever[rack$country=="Cuba" & rack$year>=1959] <- 1

# Iraq, 1959 (Mosul uprising)
rack$mkl.start[rack$country=="Iraq" & rack$year==1959] <- 1
rack$mkl.end[rack$country=="Iraq" & rack$year==1959] <- 1
rack$mkl.ongoing[rack$country=="Iraq" & rack$year==1959] <- 1
rack$mkl.type[rack$country=="Iraq" & rack$year==1959] <- 1
rack$mkl.ever[rack$country=="Iraq" & rack$year>=1959] <- 1

# Iraq, 1961-1991 (Kurds)
rack$mkl.start[rack$country=="Iraq" & rack$year==1961] <- 1
rack$mkl.end[rack$country=="Iraq" & rack$year==1991] <- 1
rack$mkl.ongoing[rack$country=="Iraq" & rack$year>=1961 & rack$year<=1991] <- 1
rack$mkl.type[rack$country=="Iraq" & rack$year==1961] <- 1

# Iraq, 1963-2003 (Saddam-repression)
rack$mkl.start[rack$country=="Iraq" & rack$year==1963] <- 1
rack$mkl.end[rack$country=="Iraq" & rack$year==2003] <- 1
rack$mkl.ongoing[rack$country=="Iraq" & rack$year>=1963 & rack$year<=2003] <- 1
rack$mkl.type[rack$country=="Iraq" & rack$year==1963] <- 3

# Guinea, 1960-1980 (Sekou Toure-repression)
rack$mkl.start[rack$country=="Guinea" & rack$year==1960] <- 1
rack$mkl.end[rack$country=="Guinea" & rack$year==1980] <- 1
rack$mkl.ongoing[rack$country=="Guinea" & rack$year>=1960 & rack$year<=1980] <- 1
rack$mkl.type[rack$country=="Guinea" & rack$year==1960] <- 3
rack$mkl.ever[rack$country=="Guinea" & rack$year>=1960] <- 1

# Laos, 1960-1973 (Communists-civil war)
rack$mkl.start[rack$country=="Laos" & rack$year==1960] <- 1
rack$mkl.end[rack$country=="Laos" & rack$year==1973] <- 1
rack$mkl.ongoing[rack$country=="Laos" & rack$year>=1960 & rack$year<=1973] <- 1
rack$mkl.type[rack$country=="Laos" & rack$year==1960] <- 1
rack$mkl.ever[rack$country=="Laos" & rack$year>=1960] <- 1

# Laos, 1975- (Communist repression/Hmong civil war)
rack$mkl.start[rack$country=="Laos" & rack$year==1975] <- 1
rack$mkl.ongoing[rack$country=="Laos" & rack$year>=1975] <- 1
rack$mkl.type[rack$country=="Laos" & rack$year==1975] <- 1

# Congo, 1960-1963 (Kasai)
rack$mkl.start[rack$country=="Congo-Kinshasa" & rack$year==1960] <- 1
rack$mkl.end[rack$country=="Congo-Kinshasa" & rack$year==1963] <- 1
rack$mkl.ongoing[rack$country=="Congo-Kinshasa" & rack$year>=1960 & rack$year<=1963] <- 1
rack$mkl.type[rack$country=="Congo-Kinshasa" & rack$year==1960] <- 1
rack$mkl.ever[rack$country=="Congo-Kinshasa" & rack$year>=1960] <- 1

# Congo, 1964-1965 (CNL-Simbas)
rack$mkl.start[rack$country=="Congo-Kinshasa" & rack$year==1964] <- 1
rack$mkl.end[rack$country=="Congo-Kinshasa" & rack$year==1965] <- 1
rack$mkl.ongoing[rack$country=="Congo-Kinshasa" & rack$year>=1964 & rack$year<=1965] <- 1
rack$mkl.type[rack$country=="Congo-Kinshasa" & rack$year==1964] <- 1

# Ethiopia, 1961-1991 (Eritrea-civil war)
rack$mkl.start[rack$country=="Ethiopia" & rack$year==1961] <- 1
rack$mkl.end[rack$country=="Ethiopia" & rack$year==1991] <- 1
rack$mkl.ongoing[rack$country=="Ethiopia" & rack$year>=1961 & rack$year<=1991] <- 1
rack$mkl.type[rack$country=="Ethiopia" & rack$year==1961] <- 1
rack$mkl.ever[rack$country=="Ethiopia" & rack$year>=1961] <- 1

# Ethiopia, 1974-1991 (political repression by Dergue-Tigre civil war)
rack$mkl.start[rack$country=="Ethiopia" & rack$year==1974] <- 1
rack$mkl.end[rack$country=="Ethiopia" & rack$year==1991] <- 1
rack$mkl.ongoing[rack$country=="Ethiopia" & rack$year>=1974 & rack$year<=1991] <- 1
rack$mkl.type[rack$country=="Ethiopia" & rack$year==1974] <- 3

# Ethiopia, 1977-1985 (Ogaden)
rack$mkl.start[rack$country=="Ethiopia" & rack$year==1977] <- 1
rack$mkl.end[rack$country=="Ethiopia" & rack$year==1985] <- 1
rack$mkl.ongoing[rack$country=="Ethiopia" & rack$year>=1977 & rack$year<=1985] <- 1
rack$mkl.type[rack$country=="Ethiopia" & rack$year==1977] <- 1

# Rwanda, 1963-1967
rack$mkl.start[rack$country=="Rwanda" & rack$year==1963] <- 1
rack$mkl.end[rack$country=="Rwanda" & rack$year==1967] <- 1
rack$mkl.ongoing[rack$country=="Rwanda" & rack$year>=1963 & rack$year<=1967] <- 1
rack$mkl.type[rack$country=="Rwanda" & rack$year==1963] <- 1
rack$mkl.ever[rack$country=="Rwanda" & rack$year>=1963] <- 1

# Algeria, 1962 (post-independence retribution)
rack$mkl.start[rack$country=="Algeria" & rack$year==1962] <- 1
rack$mkl.end[rack$country=="Algeria" & rack$year==1962] <- 1
rack$mkl.ongoing[rack$country=="Algeria" & rack$year==1962] <- 1
rack$mkl.type[rack$country=="Algeria" & rack$year==1962] <- 1
rack$mkl.ever[rack$country=="Algeria" & rack$year>=1962] <- 1

# Yemen, 1962-1970
rack$mkl.start[rack$country=="North Yemen" & rack$year==1962] <- 1
rack$mkl.end[rack$country=="North Yemen" & rack$year==1970] <- 1
rack$mkl.ongoing[rack$country=="North Yemen" & rack$year>=1962 & rack$year<=1970] <- 1
rack$mkl.type[rack$country=="North Yemen" & rack$year==1962] <- 1
rack$mkl.ever[rack$country=="North Yemen" & rack$year>=1962] <- 1

# Zanzibar, 1964 (political repression)
rack$mkl.start[rack$country=="Tanzania" & rack$year==1964] <- 1
rack$mkl.end[rack$country=="Tanzania" & rack$year==1964] <- 1
rack$mkl.ongoing[rack$country=="Tanzania" & rack$year==1964] <- 1
rack$mkl.type[rack$country=="Tanzania" & rack$year==1964] <- 3
rack$mkl.ever[rack$country=="Tanzania" & rack$year>=1964] <- 1

# Malawi, 1964-1994 (political repression)
rack$mkl.start[rack$country=="Malawi" & rack$year==1964] <- 1
rack$mkl.end[rack$country=="Malawi" & rack$year==1994] <- 1
rack$mkl.ongoing[rack$country=="Malawi" & rack$year>=1964 & rack$year<=1994] <- 1
rack$mkl.type[rack$country=="Malawi" & rack$year==1964] <- 3
rack$mkl.ever[rack$country=="Malawi" & rack$year>=1964] <- 1

# Colombia, 1948-1958 (la Violencia) [JU: Is this state-sponsored?]
rack$mkl.start[rack$country=="Colombia" & rack$year==1948] <- 1
rack$mkl.end[rack$country=="Colombia" & rack$year==1958] <- 1
rack$mkl.ongoing[rack$country=="Colombia" & rack$year>=1948 & rack$year<=1958] <- 1
rack$mkl.type[rack$country=="Colombia" & rack$year==1948] <- 1
rack$mkl.ever[rack$country=="Colombia" & rack$year>=1948] <- 1

# Colombia, 1965- (FARC, ELN, etc.)
rack$mkl.start[rack$country=="Colombia" & rack$year==1965] <- 1
rack$mkl.ongoing[rack$country=="Colombia" & rack$year>=1965] <- 1
rack$mkl.type[rack$country=="Colombia" & rack$year==1965] <- 1

# Dominican Republic, 1965-1978 (civil war)
rack$mkl.start[rack$country=="Dominican Republic" & rack$year==1965] <- 1
rack$mkl.end[rack$country=="Dominican Republic" & rack$year==1978] <- 1
rack$mkl.ongoing[rack$country=="Dominican Republic" & rack$year>=1965 & rack$year<=1978] <- 1
rack$mkl.type[rack$country=="Dominican Republic" & rack$year==1965] <- 1
rack$mkl.ever[rack$country=="Dominican Republic" & rack$year>=1965] <- 1

# Indonesia, 1949-1962 (Darul Islam)
rack$mkl.start[rack$country=="Indonesia" & rack$year==1949] <- 1
rack$mkl.end[rack$country=="Indonesia" & rack$year==1962] <- 1
rack$mkl.ongoing[rack$country=="Indonesia" & rack$year>=1949 & rack$year<=1962] <- 1
rack$mkl.type[rack$country=="Indonesia" & rack$year==1949] <- 1
rack$mkl.ever[rack$country=="Indonesia" & rack$year>=1949] <- 1

# Indonesia, 1965-1966 (anti-Communist massacres)
rack$mkl.start[rack$country=="Indonesia" & rack$year==1965] <- 1
rack$mkl.end[rack$country=="Indonesia" & rack$year==1966] <- 1
rack$mkl.ongoing[rack$country=="Indonesia" & rack$year>=1965 & rack$year<=1966] <- 1
rack$mkl.type[rack$country=="Indonesia" & rack$year==1965] <- 3

# Indonesia, 1969- (West Papua)
rack$mkl.start[rack$country=="Indonesia" & rack$year==1969] <- 1
rack$mkl.ongoing[rack$country=="Indonesia" & rack$year>=1969] <- 1
rack$mkl.type[rack$country=="Indonesia" & rack$year==1969] <- 1

# Indonesia, 1975-1999 (East Timor)
rack$mkl.start[rack$country=="Indonesia" & rack$year==1975] <- 1
rack$mkl.end[rack$country=="Indonesia" & rack$year==1999] <- 1
rack$mkl.ongoing[rack$country=="Indonesia" & rack$year>=1975 & rack$year<=1999] <- 1
rack$mkl.type[rack$country=="Indonesia" & rack$year==1975] <- 1

# Burundi, 1965-1973
rack$mkl.start[rack$country=="Burundi" & rack$year==1965] <- 1
rack$mkl.end[rack$country=="Burundi" & rack$year==1973] <- 1
rack$mkl.ongoing[rack$country=="Burundi" & rack$year>=1965 & rack$year<=1973] <- 1
rack$mkl.type[rack$country=="Burundi" & rack$year==1965] <- 1
rack$mkl.ever[rack$country=="Burundi" & rack$year>=1965] <- 1

# Cambodia, 1967-1975
rack$mkl.start[rack$country=="Cambodia" & rack$year==1967] <- 1
rack$mkl.end[rack$country=="Cambodia" & rack$year==1975] <- 1
rack$mkl.ongoing[rack$country=="Cambodia" & rack$year>=1967 & rack$year<=1975] <- 1
rack$mkl.type[rack$country=="Cambodia" & rack$year==1967] <- 1
rack$mkl.ever[rack$country=="Cambodia" & rack$year>=1967] <- 1

# Cambodia, 1975-1979 (Khmer Rouge)
rack$mkl.start[rack$country=="Cambodia" & rack$year==1975] <- 1
rack$mkl.end[rack$country=="Cambodia" & rack$year==1979] <- 1
rack$mkl.ongoing[rack$country=="Cambodia" & rack$year>=1975 & rack$year<=1979] <- 1
rack$mkl.type[rack$country=="Cambodia" & rack$year==1975] <- 3

# Nigeria, 1967-1970 (Biafra)
rack$mkl.start[rack$country=="Nigeria" & rack$year==1967] <- 1
rack$mkl.end[rack$country=="Nigeria" & rack$year==1970] <- 1
rack$mkl.ongoing[rack$country=="Nigeria" & rack$year>=1967 & rack$year<=1970] <- 1
rack$mkl.type[rack$country=="Nigeria" & rack$year==1967] <- 1
rack$mkl.ever[rack$country=="Nigeria" & rack$year>=1967] <- 1

# Nigeria, 1980 (Kano)
rack$mkl.start[rack$country=="Nigeria" & rack$year==1980] <- 1
rack$mkl.end[rack$country=="Nigeria" & rack$year==1980] <- 1
rack$mkl.ongoing[rack$country=="Nigeria" & rack$year==1980] <- 1
rack$mkl.type[rack$country=="Nigeria" & rack$year==1980] <- 1

# Equatorial Guinea, 1969-1979
rack$mkl.start[rack$country=="Equatorial Guinea" & rack$year==1969] <- 1
rack$mkl.end[rack$country=="Equatorial Guinea" & rack$year==1979] <- 1
rack$mkl.ongoing[rack$country=="Equatorial Guinea" & rack$year>=1969 & rack$year<=1979] <- 1
rack$mkl.type[rack$country=="Equatorial Guinea" & rack$year==1969] <- 3
rack$mkl.ever[rack$country=="Equatorial Guinea" & rack$year>=1969] <- 1

# Jordan, 1970-1971 (PLO) [Black September]
rack$mkl.start[rack$country=="Jordan" & rack$year==1970] <- 1
rack$mkl.end[rack$country=="Jordan" & rack$year==1971] <- 1
rack$mkl.ongoing[rack$country=="Jordan" & rack$year>=1970 & rack$year<=1971] <- 1
rack$mkl.type[rack$country=="Jordan" & rack$year==1970] <- 1
rack$mkl.ever[rack$country=="Jordan" & rack$year>=1970] <- 1

# Uganda, 1971-1979 (Amin)
rack$mkl.start[rack$country=="Colombia" & rack$year==1971] <- 1
rack$mkl.end[rack$country=="Colombia" & rack$year==1979] <- 1
rack$mkl.ongoing[rack$country=="Colombia" & rack$year>=1971 & rack$year<=1979] <- 1
rack$mkl.type[rack$country=="Colombia" & rack$year==1971] <- 3
rack$mkl.ever[rack$country=="Colombia" & rack$year>=1971] <- 1

# Uganda, 1981-1986 (civil wa)
rack$mkl.start[rack$country=="Uganda" & rack$year==1981] <- 1
rack$mkl.end[rack$country=="Uganda" & rack$year==1986] <- 1
rack$mkl.ongoing[rack$country=="Uganda" & rack$year>=1981 & rack$year<=1986] <- 1
rack$mkl.type[rack$country=="Uganda" & rack$year==1981] <- 1
rack$mkl.ever[rack$country=="Uganda" & rack$year>=1981] <- 1

#Pakistan, 1971 (Bangladesh)
rack$mkl.start[rack$country=="Pakistan" & rack$year==1971] <- 1
rack$mkl.end[rack$country=="Pakistan" & rack$year==1971] <- 1
rack$mkl.ongoing[rack$country=="Pakistan" & rack$year==1971] <- 1
rack$mkl.type[rack$country=="Pakistan" & rack$year==1971] <- 1
rack$mkl.ever[rack$country=="Pakistan" & rack$year>=1971] <- 1

#Pakistan, 1973-1977 (Baluchistan)
rack$mkl.start[rack$country=="Pakistan" & rack$year==1973] <- 1
rack$mkl.end[rack$country=="Pakistan" & rack$year==1977] <- 1
rack$mkl.ongoing[rack$country=="Pakistan" & rack$year>=1973 & rack$year<=1977] <- 1
rack$mkl.type[rack$country=="Pakistan" & rack$year==1973] <- 1

#Sri Lanka, 1971 (JVP)
rack$mkl.start[rack$country=="Sri Lanka" & rack$year==1971] <- 1
rack$mkl.end[rack$country=="Sri Lanka" & rack$year==1971] <- 1
rack$mkl.ongoing[rack$country=="Sri Lanka" & rack$year==1971] <- 1
rack$mkl.type[rack$country=="Sri Lanka" & rack$year==1971] <- 1
rack$mkl.ever[rack$country=="Sri Lanka" & rack$year>=1971] <- 1

# Sri Lanka, 1983-2002 (Tamil)
rack$mkl.start[rack$country=="Sri Lanka" & rack$year==1983] <- 1
rack$mkl.end[rack$country=="Sri Lanka" & rack$year==2002] <- 1
rack$mkl.ongoing[rack$country=="Sri Lanka" & rack$year>=1983 & rack$year<=2002] <- 1
rack$mkl.type[rack$country=="Sri Lanka" & rack$year==1983] <- 1

# Zimbabwe, 1972-1979 (civil war)
rack$mkl.start[rack$country=="Zimbabwe" & rack$year==1972] <- 1
rack$mkl.end[rack$country=="Zimbabwe" & rack$year==1979] <- 1
rack$mkl.ongoing[rack$country=="Zimbabwe" & rack$year>=1972 & rack$year<=1979] <- 1
rack$mkl.type[rack$country=="Zimbabwe" & rack$year==1972] <- 1
rack$mkl.ever[rack$country=="Zimbabwe" & rack$year>=1972] <- 1

# Zimbabwe, 1982-1987 (civil war)
rack$mkl.start[rack$country=="Zimbabwe" & rack$year==1982] <- 1
rack$mkl.end[rack$country=="Zimbabwe" & rack$year==1987] <- 1
rack$mkl.ongoing[rack$country=="Zimbabwe" & rack$year>=1982 & rack$year<=1987] <- 1
rack$mkl.type[rack$country=="Zimbabwe" & rack$year==1982] <- 1

# Chile, 1973-1978
rack$mkl.start[rack$country=="Chile" & rack$year==1973] <- 1
rack$mkl.end[rack$country=="Chile" & rack$year==1978] <- 1
rack$mkl.ongoing[rack$country=="Chile" & rack$year>=1973 & rack$year<=1978] <- 1
rack$mkl.type[rack$country=="Chile" & rack$year==1973] <- 3
rack$mkl.ever[rack$country=="Chile" & rack$year>=1973] <- 1

# Nicaragua, 1974-1979 (Somoza) [Sandinista insurgency]
rack$mkl.start[rack$country=="Nicaragua" & rack$year==1974] <- 1
rack$mkl.end[rack$country=="Nicaragua" & rack$year==1979] <- 1
rack$mkl.ongoing[rack$country=="Nicaragua" & rack$year>=1974 & rack$year<=1979] <- 1
rack$mkl.type[rack$country=="Nicaragua" & rack$year==1974] <- 1
rack$mkl.ever[rack$country=="Nicaragua" & rack$year>=1974] <- 1

# Nicaragua, 1981-1990 (Contras)
rack$mkl.start[rack$country=="Nicaragua" & rack$year==1981] <- 1
rack$mkl.end[rack$country=="Nicaragua" & rack$year==1990] <- 1
rack$mkl.ongoing[rack$country=="Nicaragua" & rack$year>=1981 & rack$year<=1990] <- 1
rack$mkl.type[rack$country=="Nicaragua" & rack$year==1981] <- 1

# Mozambique, 1975-1992 (RENAMO)
rack$mkl.start[rack$country=="Mozambique" & rack$year==1975] <- 1
rack$mkl.end[rack$country=="Mozambique" & rack$year==1992] <- 1
rack$mkl.ongoing[rack$country=="Mozambique" & rack$year>=1975 & rack$year<=1992] <- 1
rack$mkl.type[rack$country=="Mozambique" & rack$year==1975] <- 1
rack$mkl.ever[rack$country=="Mozambique" & rack$year>=1975] <- 1

# Angola, 1975-2002 (civil war)
rack$mkl.start[rack$country=="Angola" & rack$year==1975] <- 1
rack$mkl.end[rack$country=="Angola" & rack$year==2002] <- 1
rack$mkl.ongoing[rack$country=="Angola" & rack$year>=1975 & rack$year<=2002] <- 1
rack$mkl.type[rack$country=="Angola" & rack$year==1975] <- 1
rack$mkl.ever[rack$country=="Angola" & rack$year>=1975] <- 1

# Argentina, 1976-1983
rack$mkl.start[rack$country=="Argentina" & rack$year==1976] <- 1
rack$mkl.end[rack$country=="Argentina" & rack$year==1983] <- 1
rack$mkl.ongoing[rack$country=="Argentina" & rack$year>=1976 & rack$year<=1983] <- 1
rack$mkl.type[rack$country=="Argentina" & rack$year==1976] <- 1
rack$mkl.ever[rack$country=="Argentina" & rack$year>=1976] <- 1

# South Africa, 1976-1994
rack$mkl.start[rack$country=="South Africa" & rack$year==1976] <- 1
rack$mkl.end[rack$country=="South Africa" & rack$year==1994] <- 1
rack$mkl.ongoing[rack$country=="South Africa" & rack$year>=1976 & rack$year<=1994] <- 1
rack$mkl.type[rack$country=="South Africa" & rack$year==1976] <- 1
rack$mkl.ever[rack$country=="South Africa" & rack$year>=1976] <- 1

# El Salvador, 1977-1992 [leftist guerrillas & supposed sympathizers]
rack$mkl.start[rack$country=="El Salvador" & rack$year==1977] <- 1
rack$mkl.end[rack$country=="El Salvador" & rack$year==1992] <- 1
rack$mkl.ongoing[rack$country=="El Salvador" & rack$year>=1977 & rack$year<=1992] <- 1
rack$mkl.type[rack$country=="El Salvador" & rack$year==1977] <- 1
rack$mkl.ever[rack$country=="El Salvador" & rack$year>=1977] <- 1

# Iran, 1978-1979 (political repression)
rack$mkl.start[rack$country=="Iran" & rack$year==1978] <- 1
rack$mkl.end[rack$country=="Iran" & rack$year==1979] <- 1
rack$mkl.ongoing[rack$country=="Iran" & rack$year>=1978 & rack$year<=1979] <- 1
rack$mkl.type[rack$country=="Iran" & rack$year==1978] <- 3
rack$mkl.ever[rack$country=="Iran" & rack$year>=1978] <- 1

# Iran, 1979- (post-revolution, Kurds)
rack$mkl.start[rack$country=="Iran" & rack$year==1979] <- 1
rack$mkl.ongoing[rack$country=="Iran" & rack$year>=1979] <- 1
rack$mkl.type[rack$country=="Iran" & rack$year==1979] <- 3

# Afghanistan, 1978-1992
rack$mkl.start[rack$country=="Afghanistan" & rack$year==1978] <- 1
rack$mkl.end[rack$country=="Afghanistan" & rack$year==1992] <- 1
rack$mkl.ongoing[rack$country=="Afghanistan" & rack$year>=1978 & rack$year<=1992] <- 1
rack$mkl.type[rack$country=="Afghanistan" & rack$year==1978] <- 1
rack$mkl.ever[rack$country=="Afghanistan" & rack$year>=1978] <- 1

# Syria, 1979-1985 (Muslim Brotherhood)
rack$mkl.start[rack$country=="Syria" & rack$year==1979] <- 1
rack$mkl.end[rack$country=="Syria" & rack$year==1985] <- 1
rack$mkl.ongoing[rack$country=="Syria" & rack$year>=1979 & rack$year<=1985] <- 1
rack$mkl.type[rack$country=="Syria" & rack$year==1979] <- 1
rack$mkl.ever[rack$country=="Syria" & rack$year>=1979] <- 1

# Bangladesh, 1980-1997 (Chittagong Hills insurgency)
rack$mkl.start[rack$country=="Bangladesh" & rack$year==1980] <- 1
rack$mkl.end[rack$country=="Bangladesh" & rack$year==1997] <- 1
rack$mkl.ongoing[rack$country=="Bangladesh" & rack$year>=1980 & rack$year<=1997] <- 1
rack$mkl.type[rack$country=="Bangladesh" & rack$year==1980] <- 1
rack$mkl.ever[rack$country=="Bangladesh" & rack$year>=1980] <- 1

# Peru, 1980-1992 (Shining Path)
rack$mkl.start[rack$country=="Peru" & rack$year==1980] <- 1
rack$mkl.end[rack$country=="Peru" & rack$year==1992] <- 1
rack$mkl.ongoing[rack$country=="Peru" & rack$year>=1980 & rack$year<=1992] <- 1
rack$mkl.type[rack$country=="Peru" & rack$year==1980] <- 1
rack$mkl.ever[rack$country=="Peru" & rack$year>=1980] <- 1

# Somalia, 1982-1990 (Barre vs. Issaqs & others)
rack$mkl.start[rack$country=="Somalia" & rack$year==1982] <- 1
rack$mkl.end[rack$country=="Somalia" & rack$year==1990] <- 1
rack$mkl.ongoing[rack$country=="Somalia" & rack$year>=1982 & rack$year<=1990] <- 1
rack$mkl.type[rack$country=="Somalia" & rack$year==1982] <- 1
rack$mkl.ever[rack$country=="Somalia" & rack$year>=1982] <- 1

# Chad, 1982-1990 (political repression/civil war Habre regime)
rack$mkl.start[rack$country=="Chad" & rack$year==1982] <- 1
rack$mkl.end[rack$country=="Chad" & rack$year==1990] <- 1
rack$mkl.ongoing[rack$country=="Chad" & rack$year>=1982 & rack$year<=1990] <- 1
rack$mkl.type[rack$country=="Chad" & rack$year==1982] <- 1
rack$mkl.ever[rack$country=="Chad" & rack$year>=1982] <- 1

# India, 1984-1994 (Punjab-Sikh) [insurgency]
rack$mkl.start[rack$country=="India" & rack$year==1984] <- 1
rack$mkl.end[rack$country=="India" & rack$year==1994] <- 1
rack$mkl.ongoing[rack$country=="India" & rack$year>=1984 & rack$year<=1994] <- 1
rack$mkl.type[rack$country=="India" & rack$year==1984] <- 1
rack$mkl.ever[rack$country=="India" & rack$year>=1984] <- 1

# Turkey, 1984-1999 (Kurds)
rack$mkl.start[rack$country=="Turkey" & rack$year==1984] <- 1
rack$mkl.end[rack$country=="Turkey" & rack$year==1999] <- 1
rack$mkl.ongoing[rack$country=="Turkey" & rack$year>=1984 & rack$year<=1999] <- 1
rack$mkl.type[rack$country=="Turkey" & rack$year==1984] <- 1
rack$mkl.ever[rack$country=="Turkey" & rack$year>=1984] <- 1

# South Yemen, 1986
rack$mkl.start[rack$country=="South Yemen" & rack$year==1986] <- 1
rack$mkl.end[rack$country=="South Yemen" & rack$year==1986] <- 1
rack$mkl.ongoing[rack$country=="South Yemen" & rack$year==1986] <- 1
rack$mkl.type[rack$country=="South Yemen" & rack$year==1986] <- 1
rack$mkl.ever[rack$country=="South Yemen" & rack$year>=1986] <- 1

# Uganda, 1986- (LRA)
rack$mkl.start[rack$country=="Uganda" & rack$year==1986] <- 1
rack$mkl.ongoing[rack$country=="Uganda" & rack$year>=1986] <- 1
rack$mkl.type[rack$country=="Uganda" & rack$year==1986] <- 1

# Burma, 1988 (political repression)
rack$mkl.start[rack$country=="Burma" & rack$year==1986] <- 1
rack$mkl.ongoing[rack$country=="Burma" & rack$year==1986] <- 1
rack$mkl.type[rack$country=="Burma" & rack$year==1986] <- 2

# Burundi, 1988-2005
rack$mkl.start[rack$country=="Burundi" & rack$year==1988] <- 1
rack$mkl.end[rack$country=="Burundi" & rack$year==2005] <- 1
rack$mkl.ongoing[rack$country=="Burundi" & rack$year>=1988 & rack$year<=2005] <- 1
rack$mkl.type[rack$country=="Burundi" & rack$year==1988] <- 1

# Papua New Guinea, 1988-1998 (Bouganville)
rack$mkl.start[rack$country=="Papua New Guinea" & rack$year==1988] <- 1
rack$mkl.end[rack$country=="Papua New Guinea" & rack$year==1998] <- 1
rack$mkl.ongoing[rack$country=="Papua New Guinea" & rack$year>=1988 & rack$year<=1998] <- 1
rack$mkl.type[rack$country=="Papua New Guinea" & rack$year==1988] <- 1
rack$mkl.ever[rack$country=="Papua New Guinea" & rack$year>=1988] <- 1

# Indonesia, 1989-2005 (Aceh)
rack$mkl.start[rack$country=="Indonesia" & rack$year==1989] <- 1
rack$mkl.end[rack$country=="Indonesia" & rack$year==2005] <- 1
rack$mkl.ongoing[rack$country=="Indonesia" & rack$year>=1989 & rack$year<=2005] <- 1
rack$mkl.type[rack$country=="Indonesia" & rack$year==1989] <- 1

# Sri Lanka, 1989-1992 (JVP2)
rack$mkl.start[rack$country=="Sri Lanka" & rack$year==1989] <- 1
rack$mkl.end[rack$country=="Sri Lanka" & rack$year==1992] <- 1
rack$mkl.ongoing[rack$country=="Sri Lanka" & rack$year>=1989 & rack$year<=1992] <- 1
rack$mkl.type[rack$country=="Sri Lanka" & rack$year==1992] <- 1

# Romania, 1989
rack$mkl.start[rack$country=="Romania" & rack$year==1989] <- 1
rack$mkl.end[rack$country=="Romania" & rack$year==1989] <- 1
rack$mkl.ongoing[rack$country=="Romania" & rack$year==1989] <- 1
rack$mkl.type[rack$country=="Romania" & rack$year==1989] <- 2

# Liberia, 1989-1990 (civil war)
rack$mkl.start[rack$country=="Liberia" & rack$year==1989] <- 1
rack$mkl.end[rack$country=="Liberia" & rack$year==1990] <- 1
rack$mkl.ongoing[rack$country=="Liberia" & rack$year>=1989 & rack$year<=1990] <- 1
rack$mkl.type[rack$country=="Liberia" & rack$year==1989] <- 1
rack$mkl.ever[rack$country=="Liberia" & rack$year>=1989] <- 1

# India, 1990-2012 (Kashmir)
rack$mkl.start[rack$country=="India" & rack$year==1990] <- 1
rack$mkl.end[rack$country=="India" & rack$year==2012] <- 1
rack$mkl.ongoing[rack$country=="India" & rack$year>=1990 & rack$year<=2012] <- 1
rack$mkl.type[rack$country=="India" & rack$year==1990] <- 1

# Rwanda, 1990-1994 (Hutu-Tutsi)
rack$mkl.start[rack$country=="Rwanda" & rack$year==1990] <- 1
rack$mkl.end[rack$country=="Rwanda" & rack$year==1994] <- 1
rack$mkl.ongoing[rack$country=="Rwanda" & rack$year>=1990 & rack$year<=1994] <- 1
rack$mkl.type[rack$country=="Rwanda" & rack$year==1990] <- 1

# Nigeria, 1990-2012 (Niger Delta)
rack$mkl.start[rack$country=="Nigeria" & rack$year==1990] <- 1
rack$mkl.end[rack$country=="Nigeria" & rack$year==2012] <- 1
rack$mkl.ongoing[rack$country=="Nigeria" & rack$year>=1990 & rack$year<=2012] <- 1
rack$mkl.type[rack$country=="Nigeria" & rack$year==1990] <- 1

# India, 1990-1991 (Assam)
rack$mkl.start[rack$country=="India" & rack$year==1990] <- 1
rack$mkl.end[rack$country=="India" & rack$year==1991] <- 1
rack$mkl.ongoing[rack$country=="India" & rack$year>=1990 & rack$year<=1991] <- 1
rack$mkl.type[rack$country=="India" & rack$year==1990] <- 1

# Chad, 1991-2003 (repression/war)
rack$mkl.start[rack$country=="Chad" & rack$year==1991] <- 1
rack$mkl.end[rack$country=="Chad" & rack$year==2003] <- 1
rack$mkl.ongoing[rack$country=="Chad" & rack$year>=1991 & rack$year<=2003] <- 1
rack$mkl.type[rack$country=="Chad" & rack$year==1991] <- 1

# Sierra Leone, 1991-2002
rack$mkl.start[rack$country=="Sierra Leone" & rack$year==1991] <- 1
rack$mkl.end[rack$country=="Sierra Leone" & rack$year==2002] <- 1
rack$mkl.ongoing[rack$country=="Sierra Leone" & rack$year>=1991 & rack$year<=2002] <- 1
rack$mkl.type[rack$country=="Sierra Leone" & rack$year==1991] <- 1
rack$mkl.ever[rack$country=="Sierra Leone" & rack$year>=1991] <- 1

# Iraq, 1991-2003 (Shiites)
rack$mkl.start[rack$country=="Iraq" & rack$year==1991] <- 1
rack$mkl.end[rack$country=="Iraq" & rack$year==2003] <- 1
rack$mkl.ongoing[rack$country=="Iraq" & rack$year>=1991 & rack$year<=2003] <- 1
rack$mkl.type[rack$country=="Iraq" & rack$year==1991] <- 1

# Yugoslavia, 1991-1992 (Croatian civil war)
rack$mkl.start[rack$country=="Yugoslavia" & rack$year==1991] <- 1
rack$mkl.end[rack$country=="Yugoslavia" & rack$year==1992] <- 1
rack$mkl.ongoing[rack$country=="Yugoslavia" & rack$year>=1991 & rack$year<=1992] <- 1
rack$mkl.type[rack$country=="Yugoslavia" & rack$year==1991] <- 1

# Algeria, 1991-2005 (Islamists)
rack$mkl.start[rack$country=="Algeria" & rack$year==1991] <- 1
rack$mkl.end[rack$country=="Algeria" & rack$year==2005] <- 1
rack$mkl.ongoing[rack$country=="Algeria" & rack$year>=1991 & rack$year<=2005] <- 1
rack$mkl.type[rack$country=="Algeria" & rack$year==1991] <- 1

# Azerbaijan, 1991-1994 (Nagorny Karabakh)
rack$mkl.start[rack$country=="Azerbaijan" & rack$year==1991] <- 1
rack$mkl.end[rack$country=="Azerbaijan" & rack$year==1994] <- 1
rack$mkl.ongoing[rack$country=="Azerbaijan" & rack$year>=1991 & rack$year<=1994] <- 1
rack$mkl.type[rack$country=="Azerbaijan" & rack$year==1991] <- 1
rack$mkl.ever[rack$country=="Azerbaijan" & rack$year>=1991] <- 1

# Haiti, 1991-1994 (political repression)
rack$mkl.start[rack$country=="Haiti" & rack$year==1991] <- 1
rack$mkl.end[rack$country=="Haiti" & rack$year==1994] <- 1
rack$mkl.ongoing[rack$country=="Haiti" & rack$year>=1991 & rack$year<=1994] <- 1
rack$mkl.type[rack$country=="Haiti" & rack$year==1991] <- 3

# Bosnia and Herzegovina, 1992-1995 (Bosnia)
rack$mkl.start[rack$country=="Bosnia and Herzegovina" & rack$year==1992] <- 1
rack$mkl.end[rack$country=="Bosnia and Herzegovina" & rack$year==1995] <- 1
rack$mkl.ongoing[rack$country=="Bosnia and Herzegovina" & rack$year>=1992 & rack$year<=1995] <- 1
rack$mkl.type[rack$country=="Bosnia and Herzegovina" & rack$year==1992] <- 1
rack$mkl.ever[rack$country=="Bosnia and Herzegovina" & rack$year>=1992] <- 1

# Afghanistan, 1992-1996 (Rabbani/Massoud v. Taliban et al.)
rack$mkl.start[rack$country=="Afghanistan" & rack$year==1992] <- 1
rack$mkl.end[rack$country=="Afghanistan" & rack$year==1996] <- 1
rack$mkl.ongoing[rack$country=="Afghanistan" & rack$year>=1992 & rack$year<=1996] <- 1
rack$mkl.type[rack$country=="Afghanistan" & rack$year==1992] <- 1

# Tajikistan, 1992-1997 (United Opposition)
rack$mkl.start[rack$country=="Tajikistan" & rack$year==1992] <- 1
rack$mkl.end[rack$country=="Tajikistan" & rack$year==1997] <- 1
rack$mkl.ongoing[rack$country=="Tajikistan" & rack$year>=1992 & rack$year<=1997] <- 1
rack$mkl.type[rack$country=="Tajikistan" & rack$year==1992] <- 1
rack$mkl.ever[rack$country=="Tajikistan" & rack$year==1992] <- 1

# Georgia, 1992-1993 (Abkhazia)
rack$mkl.start[rack$country=="Georgia" & rack$year==1992] <- 1
rack$mkl.end[rack$country=="Georgia" & rack$year==1993] <- 1
rack$mkl.ongoing[rack$country=="Georgia" & rack$year>=1992 & rack$year<=1993] <- 1
rack$mkl.type[rack$country=="Georgia" & rack$year==1992] <- 1
rack$mkl.ever[rack$country=="Georgia" & rack$year>=1992] <- 1

# Rep. of Congo, 1992-1997 (Lissouba regime)
rack$mkl.start[rack$country=="Congo-Brazzaville" & rack$year==1992] <- 1
rack$mkl.end[rack$country=="Congo-Brazzaville" & rack$year==1997] <- 1
rack$mkl.ongoing[rack$country=="Congo-Brazzaville" & rack$year>=1992 & rack$year<=1997] <- 1
rack$mkl.type[rack$country=="Congo-Brazzaville" & rack$year==1992] <- 3
rack$mkl.ever[rack$country=="Congo-Brazzaville" & rack$year>=1992] <- 1

# Congo-Kinshasa, 1993-1997 (Kabila vs. Mobutu)
rack$mkl.start[rack$country=="Congo-Kinshasa" & rack$year==1993] <- 1
rack$mkl.end[rack$country=="Congo-Kinshasa" & rack$year==1997] <- 1
rack$mkl.ongoing[rack$country=="Congo-Kinshasa" & rack$year>=1993 & rack$year<=1997] <- 1
rack$mkl.type[rack$country=="Congo-Kinshasa" & rack$year==1993] <- 1

# Rwanda, 1994-1999 (Tutsi vs. Hutu)
rack$mkl.start[rack$country=="Rwanda" & rack$year==1994] <- 1
rack$mkl.end[rack$country=="Rwanda" & rack$year==1999] <- 1
rack$mkl.ongoing[rack$country=="Rwanda" & rack$year>=1994 & rack$year<=1999] <- 1
rack$mkl.type[rack$country=="Rwanda" & rack$year==1994] <- 1

# Russia, 1994-2009 (Chechnya) [mkl.end date added]
rack$mkl.start[rack$country=="Russia" & rack$year==1994] <- 1
rack$mkl.end[rack$country=="Russia" & rack$year==2009] <- 1
rack$mkl.ongoing[rack$country=="Russia" & rack$year>=1994 & rack$year<=2009] <- 1
rack$mkl.type[rack$country=="Russia" & rack$year==1994] <- 1
rack$mkl.ever[rack$country=="Russia" & rack$year>=1994] <- 1

# Nepal, 1995-2006 (Maoists) [mkl.end date added]
rack$mkl.start[rack$country=="Nepal" & rack$year==1995] <- 1
rack$mkl.end[rack$country=="Nepal" & rack$year==2006] <- 1
rack$mkl.ongoing[rack$country=="Nepal" & rack$year>=1995 & rack$year<=2006] <- 1
rack$mkl.type[rack$country=="Nepal" & rack$year==1995] <- 1
rack$mkl.ever[rack$country=="Nepal" & rack$year>=1995] <- 1

# Afghanistan, 1996-2001 (Taliban v. United Front)
rack$mkl.start[rack$country=="Afghanistan" & rack$year==1996] <- 1
rack$mkl.end[rack$country=="Afghanistan" & rack$year==2001] <- 1
rack$mkl.ongoing[rack$country=="Afghanistan" & rack$year>=1996 & rack$year<=2001] <- 1
rack$mkl.type[rack$country=="Afghanistan" & rack$year==1996] <- 1

# Congo-Brazzaville, 1997-2003 (Sassou regime)
rack$mkl.start[rack$country=="Congo-Brazzaville" & rack$year==1997] <- 1
rack$mkl.end[rack$country=="Congo-Brazzaville" & rack$year==2003] <- 1
rack$mkl.ongoing[rack$country=="Congo-Brazzaville" & rack$year>=1997 & rack$year<=2003] <- 1
rack$mkl.type[rack$country=="Congo-Brazzaville" & rack$year==1997] <- 1

# Former Yugoslavia, 1998-1999 (Kosovo)
rack$mkl.start[rack$country=="Serbia and Montenegro" & rack$year==1998] <- 1
rack$mkl.end[rack$country=="Serbia and Montenegro" & rack$year==1999] <- 1
rack$mkl.ongoing[rack$country=="Serbia and Montenegro" & rack$year>=1998 & rack$year<=1999] <- 1
rack$mkl.type[rack$country=="Serbia and Montenegro" & rack$year==1998] <- 1
rack$mkl.ever[rack$country=="Serbia and Montenegro" & rack$year>=1998] <- 1

# Congo-Kinshasa, 1998-
rack$mkl.start[rack$country=="Congo-Kinshasa" & rack$year==1998] <- 1
rack$mkl.ongoing[rack$country=="Congo-Kinshasa" & rack$year>=1998] <- 1
rack$mkl.type[rack$country=="Congo-Kinshasa" & rack$year==1998] <- 1

# Liberia, 2000-2003 (civil war-LURD & MODEL)
rack$mkl.start[rack$country=="Liberia" & rack$year==2000] <- 1
rack$mkl.end[rack$country=="Liberia" & rack$year==2003] <- 1
rack$mkl.ongoing[rack$country=="Liberia" & rack$year>=2000 & rack$year<=2003] <- 1
rack$mkl.type[rack$country=="Liberia" & rack$year==2000] <- 1

# Sudan, 2003-2009 (Darfur) [mkl.end date added]
rack$mkl.start[rack$country=="Sudan" & rack$year==2003] <- 1
rack$mkl.end[rack$country=="Sudan" & rack$year==2009] <- 1
rack$mkl.ongoing[rack$country=="Sudan" & rack$year>=2003 & rack$year<=2009] <- 1
rack$mkl.type[rack$country=="Sudan" & rack$year==2003] <- 1

# Sri Lanka, 2009 (northern offensive) [episode added]
rack$mkl.start[rack$country=="Sri Lanka" & rack$year==2009] <- 1
rack$mkl.end[rack$country=="Sri Lanka" & rack$year==2009] <- 1
rack$mkl.ongoing[rack$country=="Sri Lanka" & rack$year==2009] <- 1
rack$mkl.type[rack$country=="Sri Lanka" & rack$year==2009] <- 1

# Syria, 2011- (repression of civil resistance) [episode added]
rack$mkl.start[rack$country=="Syria" & rack$year==2011] <- 1
rack$mkl.ongoing[rack$country=="Syria" & rack$year>=2011] <- 1
rack$mkl.type[rack$country=="Syria" & rack$year==2011] <- 2

# Sudan, 2011- (South Kordofan) [episode added]
rack$mkl.start[rack$country=="Sudan" & rack$year==2011] <- 1
rack$mkl.ongoing[rack$country=="Sudan" & rack$year>=2011] <- 1
rack$mkl.type[rack$country=="Sudan" & rack$year==2011] <- 1

# Egypt, 2013- (Muslim Brotherhood) [episode added]
rack$mkl.start[rack$country=="Egypt" & rack$year==2013] <- 1
rack$mkl.ongoing[rack$country=="Egypt" & rack$year>=2013] <- 1
rack$mkl.type[rack$country=="Egypt" & rack$year==2011] <- 2

# Nigeria, 2013- (Boko Haram) [episode added]
rack$mkl.start[rack$country=="Nigeria" & rack$year==2013] <- 1
rack$mkl.ongoing[rack$country=="Nigeria" & rack$year>=2013] <- 1
rack$mkl.type[rack$country=="Nigeria" & rack$year==2013] <- 1

# CAR, 2013- (anti-balaka and bystanders) [episode added]
rack$mkl.start[rack$country=="Central African Republic" & rack$year==2013] <- 1
rack$mkl.ongoing[rack$country=="Central African Republic" & rack$year>=2013] <- 1
rack$mkl.type[rack$country=="Central African Republic" & rack$year==2013] <- 1
rack$mkl.ever[rack$country=="Central African Republic" & rack$year>=2013] <- 1

# South Sudan, 2013- (Nuer and others) [episode added]
rack$mkl.start[rack$country=="South Sudan" & rack$year==2013] <- 1
rack$mkl.ongoing[rack$country=="South Sudan" & rack$year>=2013] <- 1
rack$mkl.type[rack$country=="South Sudan" & rack$year==2013] <- 1
rack$mkl.ever[rack$country=="South Sudan" & rack$year>=2013] <- 1

# Cut down to ids and new data and order by country name and year.
rack <- subset(rack, select = c(12, 2, 13:17))
rack <- rack[order(rack$sftgcode, rack$year),]

# Write out the file.
write.csv(rack, file = paste0(wd, commandArgs(TRUE)[2]), row.names = FALSE)
