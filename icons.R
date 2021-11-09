# get icons
ic <- list()
ic$em <- icons::icon_find("envelope")
ic$de <- icons::icon_find("desktop")
ic$gh <- icons::icon_find("github")
ic$tw <- icons::icon_find("twitter")
ic$li <- icons::icon_find("linkedin")
# select just the first returned icon if more than one was returned
ic <- lapply(ic, \(i) if(length(i) > 1) i[[1]] else i)

saveRDS(ic, "icons.rds")
