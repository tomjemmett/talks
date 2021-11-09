# the code below has been borrowed/adapted from {pkgdown}
# it assumes the following has been run in a terminal

# $ git checkout --orphan gh-pages
# $ git rm -rf --quiet .
# $ git commit --allow-empty -m "Initializing gh-pages branch"
# $ git push origin HEAD:gh-pages
# $ git checkout main

git <- function(..., echo_cmd = TRUE, echo = TRUE, error_on_status = TRUE) {
  callr::run("git", c(...), echo_cmd = echo_cmd, echo = echo,
             error_on_status = error_on_status)
}

github_push <- function(dir, commit_message, remote, branch) {
  force(commit_message)
  withr::with_dir(dir, {
    git("add", "-A", ".")
    git("commit", "--allow-empty", "-m", commit_message)
    git("remote", "-v")
    git("push", "--force", remote, paste0("HEAD:", branch))
  })
}

github_worktree_add <- function(dir, remote, branch) {
  git("worktree", "add", "--track", "-B",
      branch, dir, paste0(remote, "/", branch))
}

github_worktree_remove <- function(dir) {
  git("worktree", "remove", dir, "--force")
}

build_slides <- function () {
  branch <- "gh-pages"
  remote <- "origin"
  commit_message <- "Updating gh-pages"

  dest_dir <- file.path(withr::local_tempdir(), "gh-pages")

  git("remote", "set-branches", remote, branch)
  git("fetch", remote, branch)

  github_worktree_add(dest_dir, remote, branch)
  withr::defer(github_worktree_remove(dest_dir))

  #-----------------------------------------------------------------------------
  # my stuff here
  #-----------------------------------------------------------------------------
  # move folders we need
  file.copy("css", dest_dir, recursive = TRUE)
  file.copy("img", dest_dir, recursive = TRUE)
  file.copy("libs", dest_dir, recursive = TRUE)
  # find .Rmd files, copy to dest_dir and render
  rmds <- fs::dir_ls(glob = "*.Rmd")
  file.copy(rmds, dest_dir)
  withr::with_dir(dest_dir, {
    sapply(rmds, \(rmd) callr::r(rmarkdown::render, list(rmd)))
  })
  # delete the Rmd's in the dest_dir
  fs::file_delete(file.path(dest_dir, rmds))
  #-----------------------------------------------------------------------------

  # commit and push

  github_push(dest_dir, commit_message, remote, branch)
  invisible()
}

build_slides()
