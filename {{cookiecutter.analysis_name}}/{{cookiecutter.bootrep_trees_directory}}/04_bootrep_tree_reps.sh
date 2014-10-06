#!/bin/bash
#PBS -q single
#PBS -l nodes=1:ppn=1
#PBS -l walltime=5:00:00
#PBS -o bootrep_bstrap_stdout
#PBS -e bootrep_bstrap_stderr
#PBS -N bootrep_bstrap
#PBS -A {{cookiecutter.allocation_name}}

export WORKDIR={{cookiecutter.working_directory}}
export BOOTREP_REPS={{cookiecutter.working_directory}}/{{cookiecutter.bootrep_trees_directory}}/{{cookiecutter.bootrep_trees_reps_directory}}
export PHYLIP={{cookiecutter.phylip_path}}
export REPS={{cookiecutter.number_of_bootreps}}

mkdir -p $BOOTREP_REPS
cd $BOOTREP_REPS
raxmlHPC-AVX -N $REPS -b $RANDOM -f j -m GTRGAMMA -s $WORKDIR/$PHYLIP -n REPS
# convert those bootreps to binary format
for i in {1..$REPS};
do
time parse-examl -m DNA -s $BOOTREP_REPS/$PHYLIP.BS$i -n $PHYLIP.BS$i;
done

