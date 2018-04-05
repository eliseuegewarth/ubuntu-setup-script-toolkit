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
alias gitb="git branch -q $*";
alias gits="git status";
alias gitsd="git status -v -v";
alias gitd="git diff $*";
alias gita="git add $*";
alias gitr="git reset $*";
alias gitc="git checkout $*";
alias gitcs="git commit -s";
alias rebase="git rebase --preserve-merges $*";
 
# Virtualenv shortcuts
alias sapl="workon sapl";
alias dulce="cd $DULCE/";
alias work="cd $WORKSPACE/";

# PPC (C programming) shortcuts
alias ppc="(ls | grep *.c) | xargs g++ -o prog -std=c++11 -O2 -Wall && ./prog < input.txt > output.txt && diff output.txt ans.txt";

echo "aliases loaded ...";
