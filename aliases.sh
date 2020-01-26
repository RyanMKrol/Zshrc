bold_text=$(tput bold)
normal_text=$(tput sgr0)

function cd() {
  builtin cd "$@" &&
  ls -l &&
  echo -n "${bold_text}In Directory: ${normal_text}" &&
  pwd;
}

function mkdir() {
  command mkdir "$@" &&
  cd "$@";
}

function ec2login() {
  ssh -i /Users/ryankrol/Dev/Resources/AWS/ec2_key_pair.pem "ec2-user@$1"
}

function encrypt() {
  openssl aes-256-cbc -a -salt -in $1 -out $2 -k $3
}

function decrypt() {
  openssl aes-256-cbc -d -a -in $1 -out $2 -k $3
}

function update_branches() {
  git checkout master
  git pull
  git checkout development
  git pull
}

function checkgit() {
  for d in */ ; do
    builtin cd "$d"
    git status
    builtin cd ..
  done
}

alias dev="cd /Users/ryankrol/Dev"
alias site="cd /Users/ryankrol/Dev/ryankrol.co.uk"
alias siteapi="cd /Users/ryankrol/Dev/ryankrol.co.uk-api"
alias ratings="cd /Users/ryankrol/Dev/RatingsPlotter-Site"
alias ratingsapi="cd /Users/ryankrol/Dev/RatingsPlotter-API"
alias zshrc="cd /Users/ryankrol/Dev/Zshrc"
alias atomadd="atom -a $@"
