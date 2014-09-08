# MODEL FORMULAE FOR EWP STATISTICAL RISK ASSESSMENTS
# 2014-09-07

f.coup <- formula(cou.a.d.1 ~
    imr.normed.ln + 
    mev.regac.ln +
    postcw +
    cou.tries5d +
    pol.cat.fl2 + pol.cat.fl3 + pol.cat.fl7 +
    pol.durable.ln +
    gdppcgrow.sr +
    mev.civtot.ln +
    ios.iccpr1)

f.cwar <- formula(pit.cwar.onset.1 ~
    wdi.popsize.ln + 
    imr.normed.ln +
    pol.cat.fl2 + pol.cat.fl3 + pol.cat.fl7 +
    mev.regac.ln +
    mev.civtot.ln)

f.threat <- formula(mkl.start.1 ~ log(coup.p) + log(cwar.p))

f.pitf <- formula(pit.any.onset.1 ~
    reg.eap + reg.eur + reg.mna + reg.sca + reg.amr +
    imr.normed.ln +
    pol.cat.pitf2 + pol.cat.pitf3 + pol.cat.pitf4 + pol.cat.pitf5 + pol.cat.pitf6 +
    dis.l4pop.ln +
    mev.regac.ln)

f.harff <- formula(mkl.start.1 ~
    log(pitf.p) +
    mkl.ever +
    pit.sftpuhvl2.10.ln +
    pol.autoc +
    elc.eliti +
    elc.elethc +
    wdi.trade.ln)

f.rf <- formula(as.factor(mkl.start.1) ~
    reg.afr + reg.eap + reg.eur + reg.mna + reg.sca + reg.amr +
    mkl.ongoing +
    mkl.ever +
    countryage.ln + 
    wdi.popsize.ln + 
    imr.normed.ln +
    gdppcgrow.sr +
    wdi.trade.ln +
    ios.iccpr1 +
    postcw +
    pol.cat.fl1 + pol.cat.fl2 + pol.cat.fl3 + pol.cat.fl7 +
    pol.durable.ln +
    dis.l4pop.ln +
    elf.ethnicc1 + elf.ethnicc2 + elf.ethnicc3 + elf.ethnicc9 +
    elc.eleth1 + elc.eleth2 +
    elc.eliti +
    cou.tries5d +
    pit.sftpuhvl2.10.ln +
    mev.regac.ln +
    mev.civtot.ln)
