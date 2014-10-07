#!/bin/bash
#PBS -q single
#PBS -l nodes=1:ppn=1
#PBS -l walltime=5:00:00
#PBS -o 04_bootrep_bstrap.stdout
#PBS -e 04_bootrep_bstrap.stderr
#PBS -N 04_bootrep_bstrap
#PBS -A {{cookiecutter.allocation_name}}

export workdir={{cookiecutter.top_level_directory}}/{{cookiecutter.analysis_name}}
export bootrep=$workdir/{{cookiecutter.bootrep_trees_directory}}
export bootrep_reps=$bootrep/{{cookiecutter.bootrep_trees_reps_directory}}
export phylip=$workdir/{{cookiecutter.phylip_file}}

# compute some values on the fly
reps=$(({{cookiecutter.number_of_bootreps}} - 1))

mkdir -p $bootrep_reps
cd $bootrep_reps
# processing starts
date
# generate $reps bootreps from phylip file
raxmlHPC-AVX -N $reps -b $RANDOM -f j -m GTRGAMMA -s $phylip -n REPS
# convert those bootreps to binary format
for i in {0..$reps};
do
    parse-examl -m DNA -s {{cookiecutter.phylip_file}}.BS$i -n BS$i;
done
# remove non-binary bootstrap replicates
#rm {{cookiecutter.phylip_file}}.BS*
# processing ends
date
# done
exit 0

