dest_dir <- "public"
dir.create(dest_dir)

rmds <- fs::dir_ls(glob = "*.Rmd")
sapply(rmds, rmarkdown::render, envir = new.env())

files <- c(
  "css", "img", "libs",
  stringr::str_replace(rmds, "\\.Rmd$", ".html"),
  fs::dir_ls(glob = "_files/")
)

# copy files we need
stopifnot("file copy failed" = all(file.copy(files, dest_dir, recursive = TRUE)))

# create CNAME file
writeLines("talks.tjmt.uk", "public/CNAME")
