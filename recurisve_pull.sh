#Does a recursive pull from all github repositories in a folder.
ls | xargs -I{} git -C {} pull
