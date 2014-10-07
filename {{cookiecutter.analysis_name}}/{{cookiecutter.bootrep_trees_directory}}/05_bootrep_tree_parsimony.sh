#!/bin/bash
#PBS -q single
#PBS -l nodes=1:ppn=1
#PBS -l walltime=5:00:00
#PBS -o bootrep_parsimonator_stdout
#PBS -e bootrep_parsimonator_stderr
#PBS -N bootrep_parsimonator
#PBS -A {{cookiecutter.allocation_name}}

export bootrep_reps={{cookiecutter.working_directory}}/{{cookiecutter.bootrep_trees_directory}}/{{cookiecutter.bootrep_trees_reps_directory}}
export bootrep_parsimony={{cookiecutter.working_directory}}/{{cookiecutter.bootrep_trees_directory}}/{{cookiecutter.bootrep_trees_parsimony_directory}}
export reps={{cookiecutter.number_of_bootreps}}
export phylip={{cookiecutter.phylip_path}}

mkdir -p $bootrep_parsimony
cd $bootrep_parsimony
for i in {1..$reps};
do
    time parsimonator-AVX -s $bootrep_reps/$phylip.BS$i -p $RANDOM -n BS$i -N 1;
    mv RAxML_parsimonyTree.BS$i.0 RAxML_parsimonyTree.BS$i
done
