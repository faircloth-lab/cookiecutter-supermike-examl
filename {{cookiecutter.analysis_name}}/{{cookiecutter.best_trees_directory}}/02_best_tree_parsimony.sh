#!/bin/bash
#PBS -q single
#PBS -l nodes=1:ppn=1
#PBS -l walltime=10:00:00
#PBS -o best_parsimomy_stdout
#PBS -e best_parsimony_stderr
#PBS -N best_parsimony
#PBS -A {{cookiecutter.allocation_name}}

export workdir=$PWD/{{cookiecutter.analysis_name}}
export best=$workdir/{{cookiecutter.best_trees_directory}}
export parsimony=$best/{{cookiecutter.best_trees_parsimony_directory}}
export phylip={{cookiecutter.phylip_path}}
export num_trees={{cookiecutter.number_of_trees}}

mkdir -p $parsimony
cd $parsimony
time parsimonator-AVX -s $best/$phylip -p $RANDOM -n best.RUN -N $num_trees
