#!/bin/bash
# KVM aceleration for emulator
sudo apt-get install cpu-checker && egrep -c '(vmx|svm)' /proc/cpuinfo && kvm-ok