#' @name git_push
#' @title git_push
#' @author brian devoe
#'
#' @description
#' commits and pushes all changes to git repo
#'
#' @param commit_message the message to attach to the commit
#' @param repo_path path to the git repository (the repository on your computer)
#' @param git_username your github username
#' @param git_token access token generated from github (see: https://github.com/settings/tokens)

git_push <- function(commit_message = NULL, repo_path = getwd(), git_username = Sys.getenv("git_username"), git_token = Sys.getenv("git_token")) {

  # Open the repository
  repo <- git2r::repository(repo_path)

  # Add all changes
  git2r::add(repo, ".")

  # Commit the changes
  git2r::commit(repo, commit_message)

  # Push to the remote repository
  cred <- git2r::cred_user_pass(git_username, git_token)
  git2r::push(repo, credentials = cred)

  # print message
  print("Changes pushed to remote repository")
  print(paste("Commit message: ", commit_message))

}






