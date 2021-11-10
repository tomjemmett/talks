dest_dir <- "public"
dir.create(dest_dir)
  
# move folders we need
file.copy("css", dest_dir, recursive = TRUE)
file.copy("img", dest_dir, recursive = TRUE)
file.copy("libs", dest_dir, recursive = TRUE)

# find .Rmd files, copy to dest_dir and render
rmds <- fs::dir_ls(glob = "*.Rmd")
file.copy(rmds, dest_dir)
withr::with_dir(dest_dir, {
  sapply(rmds, \(rmd) callr::r(\(x) rmarkdown::render(x), list(rmd)))
})

# delete the Rmd's in the dest_dir
fs::file_delete(file.path(dest_dir, rmds))

# create CNAME file
writeLines("talks.tjmt.uk", "public/CNAME")
