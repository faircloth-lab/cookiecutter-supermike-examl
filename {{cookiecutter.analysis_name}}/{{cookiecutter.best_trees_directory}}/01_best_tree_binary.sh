#!/bin/bash
#PBS -q single
#PBS -l nodes=1:ppn=1
#PBS -l walltime=2:00:00
#PBS -o best_binary_stdout
#PBS -e best_binary_stderr
#PBS -N best_binary
#PBS -A {{cookiecutter.allocation_name}}

export workdir=$PWD/{{cookiecutter.analysis_name}}
export phylip={{cookiecutter.phylip_path}}

cd $workdir
time parse-examl -m DNA -s $workdir/$phylip -n $phylip
