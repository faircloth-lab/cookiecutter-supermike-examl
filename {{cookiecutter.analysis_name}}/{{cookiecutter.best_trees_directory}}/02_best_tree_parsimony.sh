#!/bin/bash
#PBS -q single
#PBS -l nodes=1:ppn=1
#PBS -l walltime=10:00:00
#PBS -o best_parsimomy_stdout
#PBS -e best_parsimony_stderr
#PBS -N best_parsimony
#PBS -A {{cookiecutter.allocation_name}}

export WORKDIR={{cookiecutter.working_directory}}
export PARSIMONY={{cookiecutter.working_directory}}/{{cookiecutter.best_trees_directory}}/{{cookiecutter.best_trees_parsimony_directory}}
export PHYLIP={{cookiecutter.phylip_path}}
export NUM_TREES={{cookiecutter.number_of_trees}}

mkdir -p $PARSIMONY
cd $PARSIMONY
time parsimonator-AVX -s $WORKDIR/$PHYLIP -p $RANDOM -n best.RUN -N $NUM_TREES
