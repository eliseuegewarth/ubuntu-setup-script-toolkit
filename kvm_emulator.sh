#!/bin/bash
# KVM aceleration for emulator
apt-get install cpu-checker && egrep -c '(vmx|svm)' /proc/cpuinfo && kvm-ok
