#!/bin/bash
#PBS -q single
#PBS -l nodes=1:ppn=1
#PBS -l walltime=4:00:00
#PBS -o 02_best_parsimomy.stdout
#PBS -e 02_best_parsimony.stderr
#PBS -N 02_{{cookiecutter.analysis_name}}
#PBS -A {{cookiecutter.allocation_name}}

export workdir={{cookiecutter.top_level_directory}}/{{cookiecutter.analysis_name}}
export best=$workdir/{{cookiecutter.best_trees_directory}}
export phylip=$workdir/{{cookiecutter.phylip_file}}
export parsimony=$best/{{cookiecutter.best_trees_parsimony_directory}}
export num_trees={{cookiecutter.number_of_trees}}

mkdir -p $parsimony
cd $parsimony
# processing starts
date
# run command
parsimonator-AVX -s $phylip -p $RANDOM -n best.RUN -N $num_trees
# processing ends
date
# done
exit 0
