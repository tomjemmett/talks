dest_dir <- "public"
dir.create(dest_dir)

rmds <- fs::dir_ls(glob = "*.Rmd")
stopifnot("file copy failed" = all(file.copy(c("css", "img", "libs", rmds), dest_dir, recursive = TRUE)))

withr::with_dir(dest_dir, sapply(rmds, rmarkdown::render))

# delete the Rmd's in the dest_dir
fs::file_delete(file.path(dest_dir, rmds))

# create CNAME file
writeLines("talks.tjmt.uk", "public/CNAME")
