bold_text=$(tput bold)
normal_text=$(tput sgr0)

# Method to override default cd command
# arg1: the folder to change to
function cd() {
  builtin cd "$@" &&
  ls -l &&
  echo -n "${bold_text}In Directory: ${normal_text}" &&
  pwd;
}

# Method to override default mkdir command
# arg1: the folder to create
function mkdir() {
  command mkdir "$@" &&
  cd "$@";
}

# Method to login to my ec2 instances
# arg1: the host IP
function ec2login() {
  ssh -i /Users/ryankrol/Development/Resources/AWS/ec2_key_pair.pem "ec2-user@$1"
}

# Method to encrypt a file
# arg1: file to encrypt
# arg2: file to generate
# arg3: password to use to encrypt
function encrypt() {
  openssl aes-256-cbc -pbkdf2 -a -salt -in $1 -out $2 -k $3
}

# Method to decrypt a file
# arg1: file to decrypt
# arg2: file to generate
# arg3: password to use to decrypt
function decrypt() {
  openssl aes-256-cbc -pbkdf2 -d -a -in $1 -out $2 -k $3
}

# Method to decrypt all files in a folder
# arg1: password to use to decrypt everything
# Note: this assumes that you use the same password to encrypt everything
function decryptall() {
  for encryptedFile in *.enc ; do
    decryptTarget=$(echo $encryptedFile | sed 's/.enc//')
    decrypt $encryptedFile $decryptTarget $1
  done
}

# Method to check every git repo from a containing directory
function checkgit() {
  for d in */ ; do
    builtin cd "$d"
    echo -n "${bold_text}In Directory: ${normal_text}" && pwd;
    git status
    builtin cd ..
  done
}

# Method to remove node modules from every sub-folder
function remove_nm() {
  rm -rf node_modules
}

# Method to remove build folders from every sub-folder
function remove_builds() {
  rm -rf build
}

# Method to remove package-lock files from every sub-folder
function remove_pl() {
  rm -rf package-lock.json
}

# Method to clean up a node package
function clean_node_package() {
  remove_nm
  remove_builds
  remove_pl
}

# Method to clean up node packages in every sub-folder
function clean_node_packages() {
  for d in */ ; do
    builtin cd "$d"
    remove_nm
    remove_builds
    remove_pl
  done
}

alias dev="cd /Users/ryankrol/Development"
alias zshrc="cd /Users/ryankrol/Development/Zshrc"
alias zip="zip -r $@"
alias codeadd="code -a $@"
