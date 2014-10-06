#!/bin/bash
#PBS -q single
#PBS -l nodes=1:ppn=1
#PBS -l walltime=5:00:00
#PBS -o bootrep_parsimonator_stdout
#PBS -e bootrep_parsimonator_stderr
#PBS -N bootrep_parsimonator
#PBS -A {{cookiecutter.allocation_name}}

export BOOTREP_REPS={{cookiecutter.working_directory}}/{{cookiecutter.bootrep_trees_directory}}/{{cookiecutter.bootrep_trees_reps_directory}}
export BOOTREP_PARSIMONY={{cookiecutter.working_directory}}/{{cookiecutter.bootrep_trees_directory}}/{{cookiecutter.bootrep_trees_parsimony_directory}}
export REPS={{cookiecutter.number_of_bootreps}}
export PHYLIP={{cookiecutter.phylip_path}}

mkdir -p $BOOTREP_PARSIMONY
cd $BOOTREP_PARSIMONY
for i in {1..$REPS};
do
    time parsimonator-AVX -s $BOOTREP_REPS/$PHYLIP.BS$i -p $RANDOM -n BS$i -N 1;
    mv RAxML_parsimonyTree.BS$i.0 RAxML_parsimonyTree.BS$i
done
