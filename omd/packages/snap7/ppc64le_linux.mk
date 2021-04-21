##
## x86_64 Linux based (Debian/Ubuntu/Red Hat/Slackware etc.) Makefile
## Use make
##
TargetCPU  :=power9
OS         :=linux
CXXFLAGS   := -O3 -fPIC -pedantic

# Standard part

include common.mk

