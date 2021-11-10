library(icons)

icon_path <- getOption("icon.path")
my_icons_path <- file.path(icon_path, "my_icons")

if (!dir.exists(icon_path)) {
  dir.create(icon_path)
}
if (!dir.exists(my_icons_path)) {
  dir.create(my_icons_path)
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
), my_icons_path)
