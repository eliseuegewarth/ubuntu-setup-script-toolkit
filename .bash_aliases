# system shortcuts
# alias add_alias='python3 add_alias.py $*'
echo "load_aliases ...";
alias reload="reset && . ~/.bashrc";
alias bashrc="$GRAPH_EDITOR ~/.bashrc";
alias bash_aliases="$GRAPH_EDITOR ~/.bash_aliases";
alias bash_env="$GRAPH_EDITOR ~/.bash_env";
 
# Django project shortcuts
alias runserver='python manage.py runserver'
alias shellplus='python manage.py shell_plus'
alias migrate='python manage.py migrate'
alias makemigrations='python manage.py makemigrations'
alias django-db-flush='python manage.py flush && python manage.py migrate'
alias flake8="flake8 --exclude='ipython_log.py*,migrations,templates' .";
 
# Git shortcuts
alias add="git add $*";
alias amend="git commit --amend";
alias branch="git branch -q $*";
alias gbranch="git branch -q $*";
alias gadd="git add $*";
alias gamend="git commit --amend";
alias gcommit="git commit -s";
alias gitb="git branch -q $*";
alias gitcko="git checkout $*";
alias gcheckout="git checkout $*";
alias gitc="git commit -s";
alias gitcs="git commit -s";
alias gitcsm="git commit -sm";
alias gitd="git diff $*";
alias gitr="git reset $*";
alias gits="git status";
alias gitsd="git status -v -v";
alias greset="git reset $*";
alias grebase="git rebase --preserve-merges $*";
alias rebase="git rebase --preserve-merges $*";
 
# Virtualenv shortcuts
alias sapl="workon sapl";
alias dulce="cd $DULCE/";
alias work="cd $WORKSPACE/";

# PPC (C programming) shortcuts
alias ppc="(ls | grep *.c) | xargs g++ -o prog -std=c++11 -O2 -Wall && ./prog < input.txt > output.txt && diff output.txt ans.txt";

echo "aliases loaded ...";
