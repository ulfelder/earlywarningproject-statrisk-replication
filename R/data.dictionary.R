# LABELING AND SUMMARIZING USHMM DATA IN HMISC
# 2014-09-06

# Clear the workspace
rm(list=ls(all=TRUE))

# Load required packages
library(Hmisc)
library(DataCombine)

# Get working directory
wd <- getwd()

# Load the transformed data
dat <- read.csv(paste0(wd, "/data.out/ewp.statrisk.data.transformed.csv"))

# NOTES ON DATA
#
# 1. Variables are in columns, country-year records in rows
# 2. Prefixes (e.g., 'wdi.', 'pol.') identify data source
# 3. Numeric suffixes identify lagged versions of variables with the same label (e.g., mkl.start.1 is a
#    one-year leading version of mkl.start)
# 4. The binary target/dependent variable for our statististical risk assessments is 'mkl.start.1', i.e.,
#    the onset of at least one episode of state-led mass killing during the following calendar year
#
# PREFIXES USED
#
# wdi = World Bank's World Development Indicators (via package 'WDI')
# mev = Center for Systemic Peace's Major Episodes of Political Violence (http://www.systemicpeace.org/inscrdata.html)
# pol = Polity IV (http://www.systemicpeace.org/inscrdata.html)
# imr = U.S. Bureau of the Census, International Division (via PITF)
# cmm = Center for Systemic Peace's List of Coups d'Etat (http://www.systemicpeace.org/inscrdata.html)
# cpt = Powell & Thyne's coup event list (http://www.uky.edu/~clthyn2/coup_data/home.htm)
# pit = Political Instability Task Force Problem Set (i.e., instability episodes data) (http://www.systemicpeace.org/inscrdata.html)
# dis = Center for Systemic Peace's Discrimination Data Set (via PITF)
# imf = International Monetary Fund's World Economic Outlook (http://www.imf.org/external/pubs/ft/weo/2014/01/weodata/index.aspx)
# elf = Anderson's Ethnic Fractionalization Data (http://www.anderson.ucla.edu/faculty_pages/romain.wacziarg/papersum.html)
# hum = Latent Human Rights Protection Scores (http://humanrightsscores.org/)
# fiw = Freedom House's Freedom in the World
# aut = Authoritarian Regimes Dataset by Geddes, Wright, and Frantz (http://sites.psu.edu/dictators/)
# 
# NOTE: Per Hmisc manual, to get this to display properly in LaTeX, you need to have the setspace and relsize packages installed

#################################
# Add labels
#################################

dat <- MoveFront(dat, c("country", "sftgcode", "year"))
label(dat$country) <- "Country name"
label(dat$sftgcode) <- "PITF country code"
label(dat$year) <- "Year"
label(dat$postcw) <- "Post-Cold War period (year >= 1991)"
label(dat$yrborn) <- "Country 'birth' year"
label(dat$yrdied) <- "Country 'death' year"
label(dat$countryage) <-"Country age"
label(dat$reg.eap) <- "US Dept State region: East Asia and Pacific"
label(dat$reg.afr) <- "US Dept State region: Sub-Saharan Africa"
label(dat$reg.eur) <- "US Dept State region: Europe and Eurasia"
label(dat$reg.mna) <- "US Dept State region: Middle East and North Africa"
label(dat$reg.sca) <- "US Dept State region: South and Central Asia"
label(dat$reg.amr) <- "US Dept State region: Americas"
label(dat$dosreg) <- "US Dept State region"

label(dat$mkl.start) <- "Onset of any episodes of state-led mass killing"
label(dat$mkl.end) <- "End of any episodes of state-led mass killing"
label(dat$mkl.ongoing) <- "Any ongoing episodes of state-led mass killing"
label(dat$mkl.ever) <- "Any state-led mass killing since WWII (cumulative)"
dat$mkl.type <- factor(dat$mkl.type, levels=c(0,1,2,3,4), labels=c('none','civil war','uprising','repression','other'))
label(dat$mkl.type) <- "Context in which state-led mass killing episode began"

label(dat$wdi.trade) <- "Trade openness (NE.TRD.GNFS.ZS)"
label(dat$wdi.gdppcppp) <- "GDP per capita, PPP, const 2005 intl $(NY.GDP.PCAP.PP.KD)"
label(dat$wdi.gdppc) <-"GDP per capita, const 2000 $US (NY.GDP.PCAP.KD)"
label(dat$wdi.gdppcgrow) <-"Annual % change in GDP per capita (NY.GDP.MKTP.KD.ZG)"
label(dat$wdi.inflation) <- "Inflation, consumer prices, annual % (FP.CPI.TOTL.ZG)"
label(dat$wdi.cpi) <- "Consumer price index, 2005 = 100 (FP.CPI.TOTL)"
label(dat$wdi.agric) <- "Agriculture, value added, % of GDP (NV.AGR.TOTL.ZS)"
label(dat$wdi.manuf) <- "Manufacturing, value added, % of GDP (NV.IND.MANF.ZS)"
label(dat$wdi.indus) <- "Industry, value added, % of GDP (NV.IND.TOTL.ZS)"
label(dat$wdi.servc) <- "Services, value added, % of GDP (NV.SRV.TETC.ZS)"
label(dat$wdi.taxrev) <- "Tax revenue, % of GDP (GC.TAX.TOTL.GD.ZS)"
label(dat$wdi.govdebt) <- "Central govt debt, total, % of GDP (GC.DOD.TOTL.GD.ZS)"
label(dat$wdi.popsize) <- "Population size, 1000s (SP.POP.TOTL)"
label(dat$wdi.popurb) <- "Urban population, % of total (SP.URB.TOTL.IN.ZS)"
label(dat$wdi.popgrow) <- "Population growth, annual % (SP.POP.GROW)"
label(dat$wdi.popdens) <- "Population density, ppl per sq km (EN.POP.DNST)"
label(dat$wdi.pop014) <- "Population ages 0-14, % of total (SP.POP.0014.TO.ZS)"
label(dat$wdi.miltot) <- "Armed forces personnel, total (MS.MIL.TOTL.P1)"
label(dat$wdi.milpct) <- "Armed forces personnel, % of labor force (MS.MIL.TOTL.TF.ZS)"
label(dat$wdi.energy) <- "Energy depletion, % of GNI (NY.ADJ.DNGY.GN.ZS)"
label(dat$wdi.minerals) <- "Mineral depletion, % of GNI (NY.ADJ.DMIN.GN.ZS)"
label(dat$wdi.forest) <- "Forest depletion, % of GNI (NY.ADJ.DFOR.GN.ZS)"
label(dat$wdi.mobiles) <- "Mobile cellular subscriptions per 100 ppl (IT.CEL.SETS.P2)"
label(dat$wdi.netusers) <- "Internet users per 100 ppl (IT.NET.USER.P2)"
label(dat$wdi.imrate) <- "Infant mortality rate (SP.DYN.IMRT.IN)"

label(dat$cmm.succ) <- "Successful coups (CSP), count"
label(dat$cmm.fail) <- "Failed coups (CSP), count"
label(dat$cmm.plot) <- "Alleged coup plots (CSP), count"
label(dat$cmm.rumr) <- "Rumored coups (CSP), count"

label(dat$cpt.succ) <- "Successful coups (P and T), count"
label(dat$cpt.fail) <- "Failed coups (P and T), count"

label(dat$pol.democ) <- "Democracy score"
label(dat$pol.autoc) <- "Autocracy score"
label(dat$pol.polity) <- "Polity score (democracy - autocracy)"
label(dat$pol.polity2) <- "Polity2 score (democracy - autocracy)"
label(dat$pol.durable) <- "Regime durability"
label(dat$pol.xrreg) <- "Regulation of executive recruitment"
label(dat$pol.xrcomp) <- "Competitiveness of executive recruitment"
label(dat$pol.xropen) <- "Openness of executive recruitment"
label(dat$pol.xconst) <- "Executive constraints"
label(dat$pol.parreg) <- "Regulation of participation"
label(dat$pol.parcomp) <- "Competitiveness of participation"
label(dat$pol.exrec) <- "Executive Recruitment"
label(dat$pol.exconst) <- "Executive Constraints"
label(dat$pol.polcomp) <- "Political Competition"

label(dat$pit.reg.magfail) <- "Scaled failure of state authority"
label(dat$pit.reg.magcol) <- "Scaled collapse of democratic institutions"
label(dat$pit.reg.magviol) <- "Scaled violence associated with regime transition" 
label(dat$pit.reg.magave) <- "Average of adverse regime change magnitudes (magfail, magcol, magviol)"
label(dat$pit.reg.ongoing) <- "Any ongoing adverse regime change"
label(dat$pit.reg.onset) <- "Onset of adverse regime change"
label(dat$pit.reg.end) <- "End of adverse regime change"
label(dat$pit.reg.dur) <- "Duration of adverse regime change episode"
label(dat$pit.rev.magfight) <- "Scaled number of rebel combatants or activists, revolutionary war"
label(dat$pit.rev.magfatal) <- "Scaled number of annual fatalities related to fighting, revolutionary war"
label(dat$pit.rev.magarea) <- "Scaled portion of country affected, revolutionary war"
label(dat$pit.rev.magave) <- "Average of revolutionary war magnitudes (magfight, magfatal, magarea)"
label(dat$pit.rev.ongoing) <- "Any ongoing revolutionary war"
label(dat$pit.rev.onset) <- "Onset of revolutionary war"
label(dat$pit.rev.end) <- "End of revolutionary war"
label(dat$pit.rev.dur) <- "Duration of revolutionary war episode"
label(dat$pit.eth.magfight) <- "Scaled number of rebel combatants or activists, ethnic war"
label(dat$pit.eth.magfatal) <- "Scaled number of annual fatalities related to fighting, ethnic war"
label(dat$pit.eth.magarea) <- "Scaled portion of country affected, ethnic war"
label(dat$pit.eth.magave) <- "Average of ethnic war magnitudes (magfight, magfatal, magarea)"
label(dat$pit.eth.ongoing) <- "Any ongoing ethnic war"
label(dat$pit.eth.onset) <- "Onset of ethnic war"
label(dat$pit.eth.end) <- "End of ethnic war"
label(dat$pit.eth.dur) <- "Duration of ethnic war episode"
label(dat$pit.gen.deathmag) <- "Magnitude of deaths from geno-politicide"
label(dat$pit.gen.ongoing) <- "Ongoing geno-politicide episode"
label(dat$pit.gen.onset) <- "Onset of geno-politicide"
label(dat$pit.gen.end) <- "End of geno-politicide"
label(dat$pit.gen.dur) <- "Duration of geno-politicide episode"

label(dat$mev.ind) <- "Independent state indicator"
label(dat$mev.intind) <- "Annual magnitude of war of independence"
label(dat$mev.intviol) <- "Annual magnitude of episodes of international violence"
label(dat$mev.intwar) <- "Annual magnitude of episodes of international war"
label(dat$mev.civviol) <- "Annual magnitude of episodes of civil violence"
label(dat$mev.civwar) <- "Annual magnitude of episodes of civil war"
label(dat$mev.ethviol) <- "Annual magnitude of episodes of ethnic violence"
label(dat$mev.ethwar) <- "Annual magnitude of episodes of ethnic war"
label(dat$mev.inttot) <- "Summed magnitudes of inernational conflict (intviol + intwar)"
label(dat$mev.civtot) <- "Summed magnitudes of civil conflict (civviol + civwar + ethviol + ethwar)"
label(dat$mev.actotal) <- "Summed magnitudes of armed conflict (inttot + civtot)"
label(dat$mev.nborder) <- "Number of neighboring states sharing a border"
label(dat$mev.region) <- "Geographic region"
label(dat$mev.nregion) <- "Number of states in geographic region"
label(dat$mev.muslim) <- "Predominantly Muslim country"

dat$ios.eu <- factor(dat$ios.eu, levels = c(0,1,2), labels = c("non-member", "acceding", "member"))
label(dat$ios.eu) <-"European Union membership"
dat$ios.nato <- factor(dat$ios.nato, levels = c(0,1,2), labels = c("non-member", "acceding", "member"))
label(dat$ios.nato) <-"NATO membership"
dat$ios.natopfp <- factor(dat$ios.natopfp, levels = c(0,1,2), labels = c("non-member", "observer", "member"))
label(dat$ios.natopfp) <-"NATO Partnership for Peace (PfP)"
dat$ios.osce <- factor(dat$ios.osce, levels = c(0,1,2), labels = c("non-member", "observer", "member"))
label(dat$ios.osce) <-"OSCE membership"
label(dat$ios.oecd) <-"OECD member"
label(dat$ios.coe) <-"Council of Europe member"
label(dat$ios.comnw) <-"Commonwealth member"
dat$ios.franc <- factor(dat$ios.franc, levels = c(0,1,2), labels = c("non-member", "observer", "member"))
label(dat$ios.franc) <-"Francophonie membership"
label(dat$ios.geneva) <-"Geneva Conventions signatory"
label(dat$ios.gattwto) <-"GATT signatory/WTO member"
label(dat$ios.apec) <-"APEC member"
label(dat$ios.asean) <-"ASEAN member"
label(dat$ios.seato) <-"SEATO member"
label(dat$ios.oas) <-"OAS member"
dat$ios.mercosur <- factor(dat$ios.mercosur, levels = c(0,1,2), labels = c("non-member", "observer", "member"))
label(dat$ios.mercosur) <-"Mercosur membership"
label(dat$ios.opec) <-"OPEC member"
label(dat$ios.arablg) <-"Arab League member"
label(dat$ios.oau) <-"OAU member"
label(dat$ios.ecowas) <-"ECOWAS member"
dat$ios.iccpr <- factor(dat$ios.iccpr, levels = c(0,1,2), labels = c("unsigned", "signed", "acceded"))
label(dat$ios.iccpr) <-"ICCPR signatory"
label(dat$ios.iccpr1) <-"ICCPR 1st Optional Protocol signatory"
label(dat$ios.achr) <-"ACHR signatory"
label(dat$ios.achpr) <- "ACHPR signatory"
label(dat$ios.icj) <- "ICJ signatory"
label(dat$ios.oic) <- "OIC member"

label(dat$imr.raw) <- "Est. infant mortality rate, raw"
label(dat$imr.normed) <- "Est. infant mortality rate relative to annual global median"

dat$elc.eleth <- factor(dat$elc.eleth, levels=c(0,1,2),
  labels=c('not salient','salient/majority rule', 'salient/minority rule'))
label(dat$elc.eleth) <- "Ruling elite's ethnicity is political salient"
label(dat$elc.eliti) <- "Ruling elites espouse an exclusionary ideology"

label(dat$dis.gcode1) <- "ID code for largest politically significant communal group"
label(dat$dis.gprop1) <- "Population share of largest politically significant communal group"
label(dat$dis.pdis1) <- "Severity of political discrimination directed at largest politically significant communal group"
label(dat$dis.edis1) <- "Severity of economic discrimination directed at largest politically significant communal group"
label(dat$dis.gcode1) <- "ID code for 2nd-largest pol signif communal group"
label(dat$dis.gprop1) <- "Population share of 2nd-largest pol signif communal group"
label(dat$dis.pdis1) <- "Severity of political discrimination directed at 2nd-largest pol signif communal group"
label(dat$dis.edis1) <- "Severity of economic discrimination directed at 2nd-largest pol signif communal group"
label(dat$dis.gcode1) <- "ID code for 3rd-largest pol signif communal group"
label(dat$dis.gprop1) <- "Population share of 3rd-largest pol signif communal group"
label(dat$dis.pdis1) <- "Severity of political discrimination directed at 3rd-largest pol signif communal group"
label(dat$dis.edis1) <- "Severity of economic discrimination directed at 3rd-largest pol signif communal group"

label(dat$elf.ethnic) <- "Ethnic fractionalization index"
label(dat$elf.language) <- "Linguistic fractionalization index"
label(dat$elf.religion) <- "Religious fractionalization index"

label(dat$imf.gdppc) <- "GDP per capita, constant prices, national currency"

label(dat$fiw.pr) <- "Political rights index (1 is freest, 7 least free)"
label(dat$fiw.cl) <- "Civil liberties index (1 is freest, 7 least free)"
dat$fiw.status <- factor(dat$fiw.status, levels = c("NF","PF","F"), labels = c("Not free", "Partly free", "Free"))
label(dat$fiw.status) <- "Freedom House status"

label(dat$aut.casename) <- "Authoritarian regime casename (unique ID for event history analysis)"
label(dat$aut.startdate) <- "Date authoritarian regime began (YYYY-MM-DD)"
label(dat$aut.enddate) <- "Date authoritarian regime ended (YYYY-MM-DD, 2010-12-31 is right censored)"
label(dat$aut.spell) <- "Time-invariant duration of authoritarian regime in years"
label(dat$aut.duration) <- "Time-varying duration of authoritarian regime"
label(dat$aut.fail) <- "Indicator of authoritarian regime failure"
dat$aut.fail.subsregime <- factor(dat$aut.fail.subsregime, levels = c(0:3), labels = c("no failure",
  "democracy", "autocracy", "other"))
label(dat$aut.fail.subsregime) <- "Subsequent regime type following failure"
dat$aut.fail.type <- factor(dat$aut.fail.type, levels = c(0,1,2,3,4,5,6,7,8,9), labels = c("no failure",
  "insiders change rules", "incumbent loses election", "no incumbent runs in election won by opponent",
  "popular uprising", "military coup", "rebels fighting civil war", "foreign imposition or invasion",
  "new leader selected, changes rules, keeps power", "state ceases to exist or collapses"))
label(dat$aut.fail.type) <- "Mode of authoritarian regime failure"
dat$aut.fail.type <- factor(dat$aut.fail.type, levels = c(0:4), labels = c("no failure", "no deaths",
  "1-25 deaths", "26-1,000 deaths", "More than 1,000 deaths"))
label(dat$aut.fail.violent) <- "Level of violence during auth regime failure"
label(dat$aut.regimetype) <- "Autocratic regime type"
label(dat$aut.party) <- "Party regime indicator"
label(dat$aut.personal) <- "Personal regime indicator"
label(dat$aut.military) <- "Military regime indicator"
label(dat$aut.monarch) <- "Monarchy indicator"

label(dat$hum.ciri) <- "CIRI country identifier"
label(dat$hum.disap) <- "CIRI 3-category, factor measure of disappearances"
label(dat$hum.kill) <- "CIRI 3-category, factor measure of killing"
label(dat$hum.polpris) <- "CIRI 3-category, factor measure of political imprisonment"
label(dat$hum.tort) <- "CIRI 3-category, factor measure of torture"
label(dat$hum.amnesty) <- "CIRI Amnesty International score"
label(dat$hum.state) <- "CIRI State Dept score"
label(dat$hum.hathaway) <- "5-category, factor variable for torture per Hathaway (2002)"
label(dat$hum.itt) <- "6-category, factor variable for torture per ITT dataset"
label(dat$hum.genocide) <- "Binary variable for geno-politicide per Harff (2003)"
label(dat$hum.rummel) <- "Binary variable for politicide/genocide per Rummel"
label(dat$hum.mass.repress) <- "Binary variable for massive repressive events per Harff  and  Gurr (1988)"
label(dat$hum.executions) <- "Binary variable from World Handbook of Political Indicators"
label(dat$hum.killing) <- "Binary version based on the UCDP one sided violence count data"
label(dat$hum.additive) <- "CIRI Physical Integrity scale"
label(dat$hum.latentmean) <- "Latent human rights score" 
label(dat$hum.latentsd) <- "Std dev of latent human rights score"

label(dat$mkl.start.1) <- "Onset of state-led mass killing episode in next year (t+1)"
label(dat$countryage) <- "Country age in years"
label(dat$countryage.ln) <- "Country age, logged"
label(dat$wdi.popsize.ln) <- "Population size, logged"      
label(dat$wdi.trade.ln) <- "Trade openness, logged"        
dat$pol.cat.fl <- factor(dat$pol.cat.fl, levels = c(1,2,3,7), labels = c("autocracy", "anocracy", "democracy", "other"))
label(dat$pol.cat.fl) <- "Political regime type per Fearon  and  Laitin (2003)"
dat$pol.cat.fl <- factor(dat$pol.cat.pitf, levels = c("A/F", "A/P", "D/fact", "D/P", "D/F", "other"),
  labels = c("Full autocracy", "Partial autocracy", "Partial democracy w/factionalism",
  "Partial democracy w/o factionalism", "Full democracy", "Other"))
label(dat$pol.cat.pitf) <- "Political regime type per PITF (Goldstone et al. 2010)"
label(dat$pol.cat.fl1) <- "Autocracy (F and L)"        
label(dat$pol.cat.fl2) <- "Anocracy (F and L)"         
label(dat$pol.cat.fl3) <- "Democracy (F and L)"         
label(dat$pol.cat.fl7) <- "Other (F and L)"         
label(dat$pol.cat.pitf1) <- "Full autocracy (PITF)"       
label(dat$pol.cat.pitf2) <- "Partial autocracy (PITF)"       
label(dat$pol.cat.pitf3) <- "Partial democracy w/factionalism (PITF)"       
label(dat$pol.cat.pitf4) <- "Partial democracy w/o factionalism (PITF)"      
label(dat$pol.cat.pitf5) <- "Full democracy (PITF)"      
label(dat$pol.cat.pitf6) <- "Other (PITF)"       
label(dat$pol.durable.ln) <- "Regime duration, logged (Polity)"      
label(dat$elc.elethc) <- "Salient elite ethnicity (yes/no)"          
label(dat$elc.eleth2) <- "Salient elite ethnicity: minority rule"          
label(dat$elc.eleth1) <- "Salient elite ethnicity: majority rule"          
label(dat$cou.s.d) <- "Any successful coup attempts"            
label(dat$cou.f.d) <- "Any failed coup attempts"             
label(dat$cou.a.d) <- "Any coup attempts, successful or failed"             
label(dat$cou.tries5d) <- "Any coup attempts in past 5 years ((t-4) to (t))"         
label(dat$cou.a.d.1) <- "Any coup attempts in following year (t+1)"
dat$elf.ethnicc <- factor(dat$elf.ethnicc, levels = c(1,2,3,9), labels = c("Lowest tercile", "Middle tercile", "Top tercile", "Missing"))         
label(dat$elf.ethnicc) <- "Ethnic fractionalization, terciles"         
label(dat$elf.ethnicc1) <- "Ethnic fractionalization: low"        
label(dat$elf.ethnicc2) <- "Ethnic fractionalization: medium"       
label(dat$elf.ethnicc3) <- "Ethnic fractionalization: high"        
label(dat$elf.ethnicc9) <- "Ethnic fractionalization: missing"        
label(dat$pit.any.onset) <- "Any onset of PITF civil war or adverse regime change"       
label(dat$pit.any.onset.1) <- "Any onset of PITF civil war or adverse regime change in following year (t+1)"     
label(dat$pit.any.ongoing) <- "Any ongoing PITF political instability"     
label(dat$pit.cwar.onset) <- "Any onsets of PITF ethnic or revolutionary war"      
label(dat$pit.cwar.onset.1) <- "Any onsets of PITF ethnic or revolutionary war in following year (t+1)"   
label(dat$pit.dur.min) <- "Duration of PITF instability episode (shortest component)"         
label(dat$pit.dur.max) <- "Duration of PITF instability episode (longest component)"         
label(dat$pit.reg.max) <- "Maximum magnitude score for PITF adverse regime change"         
label(dat$pit.eth.max) <- "Maximum magnitude score for PITF ethnic war"         
label(dat$pit.rev.max) <- "Maximum magnitude score for PITF revolutionary war"         
label(dat$pit.mag.max) <- "Maximum magnitude score for PITF instability other than genocide"         
label(dat$pit.sftpuhvl2.10) <- "Sum of max annual magnitudes of PITF instability other than genocide from past 10 yrs ((t-9) to (t))"   
label(dat$pit.sftpuhvl2.10.ln) <- "Sum of max annual magnitudes of PITF instability other than genocide from past 10 yrs ((t-9) to (t)), logged"
label(dat$pit.reg.dur.ln) <- "Duration of PITF adverse regime change episode, logged"     
label(dat$pit.eth.dur.ln) <- "Duration of PITF ethnic war episode, logged"      
label(dat$pit.rev.dur.ln) <- "Duration of PITF revolutionary war episode, logged"      
label(dat$pit.dur.min.ln) <- "Duration of PITF instability episode (shortest component), logged"      
label(dat$dis.l4pop) <- "Share of population subjected to state-led discrimination (0-1)"           
label(dat$dis.l4pop.ln) <- "Percent of population subjected to state-led discrimination, logged"       
label(dat$imr.normed.ln) <- "Infant mortality rate relative to annual global median, logged"       
label(dat$mev.regac) <- "Scalar measure of armed conflict in geographic region"           
label(dat$mev.regac.ln) <- "Scalar measure of armed conflict in geographic region, logged"        
label(dat$mev.civtotc) <- "Any violent civil conflict (yes/no)"         
label(dat$mev.civtot.ln) <- "Scale of violent civil conflict, logged"       
label(dat$imf.gdppcgrow) <- "Annual % change in GDP per capita, constant local currency"       
label(dat$gdppcgrow) <- "Annual % change in GDP per capita, meld of IMF  and  WDI"          
label(dat$gdppcgrow.sr) <- "Annual % change in GDP per capita, meld of IMF  and  WDI, square root"        
label(dat$slowgrowth) <- "Indicator of annual change in GDP per capita under 2%" 

# Create LaTeX file with data names, labels, and summaries
descrip <- describe(dat, digits = 3)
latex(descrip, file = paste0(wd, "/data.out/ewp.statrisk.data.dictionary.tex"))
