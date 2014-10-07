#!/bin/bash
#PBS -q single
#PBS -l nodes=1:ppn=1
#PBS -l walltime=5:00:00
#PBS -o bootrep_bstrap_stdout
#PBS -e bootrep_bstrap_stderr
#PBS -N bootrep_bstrap
#PBS -A {{cookiecutter.allocation_name}}

export workdir=$PWD/{{cookiecutter.analysis_name}}
export bootrep_reps=$workdir/{{cookiecutter.bootrep_trees_directory}}/{{cookiecutter.bootrep_trees_reps_directory}}
export phylip={{cookiecutter.phylip_path}}
export reps={{cookiecutter.number_of_bootreps}}

mkdir -p $bootrep_reps
cd $bootrep_reps
raxmlHPC-AVX -N $reps -b $RANDOM -f j -m GTRGAMMA -s $workdir/$phylip -n REPS
# convert those bootreps to binary format
for i in {1..$reps};
do
time parse-examl -m DNA -s $bootrep_reps/$phylip.BS$i -n $phylip.BS$i;
done

