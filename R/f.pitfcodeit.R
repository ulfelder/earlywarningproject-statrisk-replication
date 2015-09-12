# PITF Country Code Maker
# Function to create 'sftgcode' variable to match SFTGCODE in PITF Merge files.
# 2014-09-02

# NOTE:
# 1. Namevar needs to be in quotes, e.g., use pitfcodeit(data, "country"), not pitfcodeit(data, country), so
#      it isn't confused with an object.
# 2. Give the function a target so you don't dump new df to terminal, e.g., > z <- pitfcodeit(z, "name")
#      and not just > pitfcodeit(z, "name")

pitfcodeit <- function(df, namevar) {
  data <- df
  data$sftgcode <- NA
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Afghanistan", 'AFG')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Albania", 'ALB')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Algeria", 'ALG')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Angola", 'ANG')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Argentina", 'ARG')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Armenia", 'ARM')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Australia", 'AUL')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Austria", 'AUS')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Azerbaijan", 'AZE')
  data$sftgcode <- replace(data$sftgcode, which(data[,namevar]=="Bahamas" |
    data[,namevar]=="Bahamas, The" |
    data[,namevar]=="The Bahamas"), 'BHM')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Bahrain", 'BAH')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Bangladesh", 'BNG')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Barbados", 'BAR')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Belarus", 'BLR')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Belgium", 'BEL')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Belize", 'BLZ')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Benin", 'BEN')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Bhutan", 'BHU')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Bolivia", 'BOL')
  data$sftgcode <- replace(data$sftgcode, which(data[,namevar]=="Bosnia" |
    data[,namevar]=="Bosnia and Herzegovina" |
    data[,namevar]=="Bosnia Herzegovenia" |
    data[,namevar]=="Bosnia-Herzegovina"), 'BOS')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Botswana", 'BOT')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Brazil", 'BRA')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Brunei", 'BRU')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Bulgaria", 'BUL')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Burkina Faso", 'BFO')
  data$sftgcode <- replace(data$sftgcode, which(data[,namevar]=="Burma" |
    data[,namevar]=="Myanmar" |
    data[,namevar]=="Myanmar (Burma)"), 'MYA')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Burundi", 'BUI')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Bangladesh", 'BNG')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Cambodia", 'CAM')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Cape Verde", 'CAP')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Cameroon", 'CAO')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Canada", 'CAN')
  data$sftgcode <- replace(data$sftgcode, which(data[,namevar]=="Central African Republic" |
    data[,namevar]=="Cen African Rep" |
    data[,namevar]=="CAR"), 'CEN')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Chad", 'CHA')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Chile", 'CHL')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="China", 'CHN')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Colombia", 'COL')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Comoros", 'COM')
  data$sftgcode <- replace(data$sftgcode, which(data[,namevar]=="Congo-Brazzaville" |
    data[,namevar]=="Republic of Congo" |
    data[,namevar]=="Congo, Republic of" |
    data[,namevar]=="Congo (Brazzaville)" |
    data[,namevar]=="Republic of the Congo" |
    data[,namevar]=="Congo Brazzaville" |
    data[,namevar]=="Congo" |
    data[,namevar]=="Congo, Rep." |
    data[,namevar]=="Congo, Rep.(Brazzaville)" |
    data[,namevar]=="Congo-Brz" |
    data[,namevar]=="Congo (Brazzaville, Republic of Congo)"), 'CON')
  data$sftgcode <- replace(data$sftgcode, which(data[,namevar]=="Congo-Kinshasa" |
    data[,namevar]=="Zaire" |
    data[,namevar]=="Zaire/DRC" |
    data[,namevar]=="Democratic Republic of Congo" |
    data[,namevar]=="Democratic Republic of the Congo" |
    data[,namevar]=="Congo, Democratic Republic of" |
    data[,namevar]=="Congo, Dem. Rep." |
    data[,namevar]=="Congo (Kinshasa)" |
    data[,namevar]=="Congo Kinshasa" |
    data[,namevar]=="DROC" |
    data[,namevar]=="Congo, Dem. Rep. (Zaire, Kinshasa)" |
    data[,namevar]=="Congo/Zaire" |
    data[,namevar]=="Democratic Republic of the Congo (Zaire, Congo-Kinshasha)"), 'ZAI')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Costa Rica", 'COS')
  data$sftgcode <- replace(data$sftgcode, which(data[,namevar]=="Cote d'Ivoire" |
    data[,namevar]=="Ivory Coast" |
    data[,namevar]=="Cote d Ivoire" |
    data[,namevar]=="Ivory Coast (Cote d'Ivoire)" |
    data[,namevar]=="Côte d'Ivoire"), 'IVO')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Croatia", 'CRO')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Cuba", 'CUB')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Cyprus", 'CYP')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Czech Republic", 'CZR')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Czechoslovakia", 'CZE')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Denmark", 'DEN')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Djibouti", 'DJI')
  data$sftgcode <- replace(data$sftgcode, which(data[,namevar]=="Dominican Republic" |
    data[,namevar]=="Dominican Rep"), 'DOM')
  data$sftgcode <- replace(data$sftgcode, which(data[,namevar]=="East Timor" |
    data[,namevar]=="Timor" |
    data[,namevar]=="Timor Leste" |
    data[,namevar]=="East Timor (Timor L'este)" |
    data[,namevar]=="Timor-Leste"), 'ETM')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Ecuador", 'ECU')
  data$sftgcode <- replace(data$sftgcode, which(data[,namevar]=="Egypt" |
    data[,namevar]=="Egypt, Arab Rep."), 'EGY')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="El Salvador", 'SAL')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Equatorial Guinea", 'EQG')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Eritrea", 'ERI')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Estonia", 'EST')
  data$sftgcode <- replace(data$sftgcode, which(data[,namevar]=="Ethiopia" & data$year < 1993), 'ETH')
  data$sftgcode <- replace(data$sftgcode, which(data[,namevar]=="Ethiopia" & data$year >= 1993), 'ETI')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Fiji", 'FJI')
  data$sftgcode <- replace(data$sftgcode, which(data[,namevar]=="Finland" |
    data[,namevar]=="Finland "), 'FIN')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="France", 'FRN')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Estonia", 'EST')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Gabon", 'GAB')
  data$sftgcode <- replace(data$sftgcode, which(data[,namevar]=="Gambia" |
    data[,namevar]=="The Gambia" |
    data[,namevar]=="Gambia, the" |
    data[,namevar]=="Gambia, The"), 'GAM')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Georgia", 'GRG')
  data$sftgcode <- replace(data$sftgcode, which(data[,namevar]=="Germany" & data$year >= 1990), 'GER')
  data$sftgcode <- replace(data$sftgcode, which(data[,namevar]=="Germany" & data$year < 1990), 'GFR')
  data$sftgcode <- replace(data$sftgcode, which(data[,namevar]=="East Germany" |
    data[,namevar]=="Germany, East" |
    data[,namevar]=="German Democratic Republic" |
    data[,namevar]=="Germany East" |
    data[,namevar]=="Germany, E. "), 'GDR')
  data$sftgcode <- replace(data$sftgcode, which(data[,namevar]=="West Germany" |
    data[,namevar]=="Germany, West" |
    data[,namevar]=="Federal Republic of Germany" |
    data[,namevar]=="German Federal Republic" |
    data[,namevar]=="Germany West" |
    data[,namevar]=="Germany, W. "), 'GFR')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Ghana", 'GHA')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Greece", 'GRC')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Guatemala", 'GUA')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Guinea", 'GUI')
  data$sftgcode <- replace(data$sftgcode, which(data[,namevar]=="Guinea-Bissau" |
    data[,namevar]=="Guinea Bissau"), 'GNB')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Guyana", 'GUY')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Haiti", 'HAI')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Honduras", 'HON')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Hungary", 'HUN')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Iceland", 'ICE')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="India", 'IND')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Indonesia", 'INS')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Guyana", 'GUY')
  data$sftgcode <- replace(data$sftgcode, which(data[,namevar]=="Iran" |
    data[,namevar]=="Iran, Islamic Rep." |
    data[,namevar]=="Islamic Republic of Iran"), 'IRN')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Iraq", 'IRQ')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Ireland", 'IRE')
  data$sftgcode <- replace(data$sftgcode, which(data[,namevar]=="Israel" |
    data[,namevar]=="Israel and Occupied Territories**" |
    data[,namevar]=="Israel, pre-1967 borders"), 'ISR')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Italy", 'ITA')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Jamaica", 'JAM')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Japan", 'JPN')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Jordan", 'JOR')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Kazakhstan", 'KZK')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Kenya", 'KEN')
  data$sftgcode <- replace(data$sftgcode, which(data[,namevar]=="Korea, North" |
    data[,namevar]=="North Korea" |
    data[,namevar]=="People's Republic of Korea" |
    data[,namevar]=="Korea North" |
    data[,namevar]=="Korea, Dem. Rep." |
    data[,namevar]=="North Korea (Democratc People's Republic of Korea)" |
    data[,namevar]=="Korea, Dem. Rep. (N)" |
    data[,namevar]=="Democratic People's Republic of Korea" |
    data[,namevar]=="Korea, Democratic People's Republic of"), 'PRK')
  data$sftgcode <- replace(data$sftgcode, which(data[,namevar]=="Korea, South" |
    data[,namevar]=="South Korea" |
    data[,namevar]=="Korea South" |
    data[,namevar]=="Republic of Korea" |
    data[,namevar]=="Korea, Rep." |
    data[,namevar]=="South Korea (Republic of Korea)" |
    data[,namevar]=="Korea" |
    data[,namevar]=="Korea, Rep. (S)" |
    data[,namevar]=="Korea, Republic of"), 'ROK')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Kuwait", 'KUW')
  data$sftgcode <- replace(data$sftgcode, which(data[,namevar]=="Kyrgyzstan" |
    data[,namevar]=="Kyrgyz Republic"), 'KYR')
  data$sftgcode <- replace(data$sftgcode, which(data[,namevar]=="Laos" |
    data[,namevar]=="Lao PDR" |
    data[,namevar]=="Lao P.D.R." |
    data[,namevar]=="Lao, PDR"), 'LAO')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Latvia", 'LAT')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Lebanon", 'LEB')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Lesotho", 'LES')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Liberia", 'LBR')
  data$sftgcode <- replace(data$sftgcode, which(data[,namevar]=="Libya" |
    data[,namevar]=="Libyan Arab Jamahiriya"), 'LIB')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Lithuania", 'LIT')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Luxembourg", 'LUX')
  data$sftgcode <- replace(data$sftgcode, which(data[,namevar]=="Macedonia" |
    data[,namevar]=="Macedonia, FYR" |
    data[,namevar]=="FYR Macedonia"), 'MAC')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Madagascar", 'MAG')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Malawi", 'MAW')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Malaysia", 'MAL')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Maldives", 'MAD')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Mali", 'MLI')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Malta", 'MLT')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Mauritania", 'MAA')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Mauritius", 'MAS')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Mexico", 'MEX')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Moldova", 'MLD')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Mongolia", 'MON')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Montenegro", 'MNE')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Morocco", 'MOR')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Mozambique", 'MZM')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Namibia", 'NAM')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Nepal", 'NEP')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Netherlands", 'NTH')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="New Zealand", 'NEW')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Nicaragua", 'NIC')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Nigeria", 'NIG')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Niger", 'NIR')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Norway", 'NOR')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Oman", 'OMA')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Panama", 'PAN')
  data$sftgcode <- replace(data$sftgcode, which(data[,namevar]=="Pakistan" & data$year < 1972), 'PKS')
  data$sftgcode <- replace(data$sftgcode, which(data[,namevar]=="Pakistan" & data$year >= 1972), 'PAK')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Papua New Guinea", 'PNG')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Paraguay", 'PAR')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Peru", 'PER')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Philippines", 'PHI')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Poland", 'POL')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Portugal", 'POR')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Qatar", 'QAT')
  data$sftgcode <- replace(data$sftgcode, which(data[,namevar]=="Romania" |
    data[,namevar]=="Rumania"), 'RUM')
  data$sftgcode <- replace(data$sftgcode, which(data[,namevar]=="Russia" |
    data[,namevar]=="Russian Federation"), 'RUS')
  data$sftgcode <- replace(data$sftgcode, which(data[,namevar]=="Soviet Union" |
    data[,namevar]=="USSR" |
    data[,namevar]=="USSR(Soviet Union)" |
    data[,namevar]=="U.S.S.R."), 'USS')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Rwanda", 'RWA')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Sao Tome and Principe", 'STP')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Saudi Arabia", 'SAU')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Senegal", 'SEN')
  data$sftgcode <- replace(data$sftgcode, which(data[,namevar]=="Serbia" |
    (data[,namevar]=="Yugoslavia" & data$year > 2005)), 'SRB')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Sierra Leone", 'SIE')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Singapore", 'SIN')
  data$sftgcode <- replace(data$sftgcode, which(data[,namevar]=="Slovakia" |
    data[,namevar]=="Slovak Republic"), 'SLO')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Slovenia", 'SLV')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Solomon Islands", 'SOL')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Somalia", 'SOM')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="South Africa", 'SAF')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Spain", 'SPN')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Sri Lanka", 'SRI')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Sudan", 'SUD')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="South Sudan", 'SSD')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Suriname", 'SUR')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Swaziland", 'SWA')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Sweden", 'SWD')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Switzerland", 'SWZ')
  data$sftgcode <- replace(data$sftgcode, which(data[,namevar]=="Syria" |
    data[,namevar]=="Syrian Arab Republic"), 'SYR')
  data$sftgcode <- replace(data$sftgcode, which(data[,namevar]=="Taiwan" |
    data[,namevar]=="Taiwan Province of China" |
    data[,namevar]=="Taiwan, China"), 'TAW')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Tajikistan", 'TAJ')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Tanzania", 'TAZ')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Thailand", 'THI')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Togo", 'TOG')
  data$sftgcode <- replace(data$sftgcode, which(data[,namevar]=="Trinidad" |
    data[,namevar]=="Trinidad and Tobago" |
    data[,namevar]=="Trinidad & Tobago"), 'TRI')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Tunisia", 'TUN')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Turkey", 'TUR')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Turkmenistan", 'TKM')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Uganda", 'UGA')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Ukraine", 'UKR')
  data$sftgcode <- replace(data$sftgcode, which(data[,namevar]=="United Arab Emirates" |
    data[,namevar]=="UAE"), 'UAE')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="United Kingdom", 'UKG')
  data$sftgcode <- replace(data$sftgcode, which(data[,namevar]=="United States" |
    data[,namevar]=="United States of America"), 'USA')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Uruguay", 'URU')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Uzbekistan", 'UZB')
  data$sftgcode <- replace(data$sftgcode, which(data[,namevar]=="Venezuela" |
    data[,namevar]=="Venezuela, RB"), 'VEN')
  data$sftgcode <- replace(data$sftgcode, which(data[,namevar]=="Vietnam" |
    data[,namevar]=="Viet Nam" |
    data[,namevar]=="Vietnam, Socialist Republic of"), 'VIE')
  data$sftgcode <- replace(data$sftgcode, which(data[,namevar]=="North Vietnam" |
    data[,namevar]=="Democratic Republic of Vietnam" |
    data[,namevar]=="DRVN" |
    data[,namevar]=="Vietnam, North" |
    data[,namevar]=="Vietnam North" |
    data[,namevar]=="Vietnam, N."), 'DRV')
  data$sftgcode <- replace(data$sftgcode, which(data[,namevar]=="South Vietnam" |
    data[,namevar]=="Republic of Vietnam" |
    data[,namevar]=="Vietnam, South" |
    data[,namevar]=="Vietnam South" |
    data[,namevar]=="Vietnam, S."), 'RVN')
  data$sftgcode <- replace(data$sftgcode, which((data[,namevar]=="Yemen Arab Republic" & data$year < 1990) |
    data[,namevar]=="North Yemen" |
    data[,namevar]=="Yemen, North" |
    data[,namevar]=="Yemen North" |
    data[,namevar]=="Yemen, N." |
    data[,namevar]=="Yemen Arab Republic; N. Yemen"), 'YAR')
  data$sftgcode <- replace(data$sftgcode, which(data[,namevar]=="Yemen" |
    data[,namevar]=="Yemen, Rep." |
    (data[,namevar]=="Yemen Arab Republic" & data$year >= 1990)), 'YEM')
  data$sftgcode <- replace(data$sftgcode, which(data[,namevar]=="South Yemen" |
    data[,namevar]=="Yemen, South" |
    data[,namevar]=="Yemen South" |
    data[,namevar]=="Yemen People's Republic" |
    data[,namevar]=="SouthYemen" |
    data[,namevar]=="Yemen, S." | 
    data[,namevar]=="Yemen PDR" |
    data[,namevar]=="Yemen People's Republic; S. Yemen" |
    data[,namevar]=="Yemen PDR (South)"), 'YPR')
  data$sftgcode <- replace(data$sftgcode, which(data[,namevar]=="Yugoslavia, FPR" |
    (data[,namevar]=="Yugoslavia" & data$year < 1992) |
    (data[,namevar]=="Yugoslavia, Fed. Rep." & data$year < 1992) |
    (data[,namevar]=="Federal Republic of Yugoslavia" & data$year < 1992) |
    (data[,namevar]=="Serbia and Montenegro" & data$year < 1992) |
    (data[,namevar]=="Former Yugoslavia" & data$year < 1992)), 'YUG')
  data$sftgcode <- replace(data$sftgcode, which(data[,namevar]=="Yugoslavia, Federal Republic of" |
    data[,namevar]=="Yugoslavia (Serbia & Montenegro)" |
    data[,namevar]=="Yugoslavia, FR (Serbia/Montenegro)" |
    (data[,namevar]=="Yugoslavia" & data$year >= 1992 & data$year <= 2005) |
    (data[,namevar]=="Yugoslavia, Fed. Rep." & data$year >= 1992) |
    (data[,namevar]=="Federal Republic of Yugoslavia" & data$year >= 1992) |
    (data[,namevar]=="Serbia and Montenegro" & data$year >= 1992) |
    (data[,namevar]=="Former Yugoslavia" & data$year >= 1992)), 'YGS')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Zambia", 'ZAM')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Zimbabwe", 'ZIM')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Kosovo", 'KOS')
  data$sftgcode <- replace(data$sftgcode, data[,namevar]=="Palestinian Authority" |
    data[,namevar]=="Israel, occupied territories only", 'PAL')
  return(data)
}

