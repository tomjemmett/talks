library(icons)

# set the icon.path option to save to a specific folder which we can cache
options("icon.path" = "icons")

if (!dir.exists("icons")) {
  dir.create("icons")
}

# make sure the icons are downloaded
if (!icon_installed(fontawesome)) {
  download_fontawesome()
}

# list any icons we want to use here
icon_save(list(
  em = fontawesome$regular$envelope,
  de = fontawesome$solid$desktop,
  gh = fontawesome$brands$github,
  tw = fontawesome$brands$twitter,
  li = fontawesome$brands$linkedin
), "icons")
