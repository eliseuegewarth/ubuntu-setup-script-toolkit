#!/usr/bin/env python3
 
import sys, os

 
def main(argv):
    # import ipdb; ipdb.set_trace()
    separate_alias=argv[0].split('=')
    file = open(".bash_aliases", 'a')
    alias = '{} {}="{}"'.format(
        "alias", separate_alias[0], separate_alias[1])
    print ('Are you sure you want to create the alias: "{}" ?(Y/n)'.format(alias))
 
    answer = input()
 
    if "Y" or "y" in answer:
        print(alias, file=file)
        print("RUN    . ${HOME}/.bash_aliases")
 
if __name__ == "__main__":
    if len(sys.argv) > 1:
        main(sys.argv[1:])
    else:
        print('Usage:\n{}'.format(
            "RUN    {} <alias_name>=\"<command>\"".format(
                sys.argv[0].split('/')[-1]
                )))