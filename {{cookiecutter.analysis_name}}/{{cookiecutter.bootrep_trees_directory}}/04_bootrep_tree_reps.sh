#!/bin/bash
#PBS -q checkpt
#PBS -l nodes=1:ppn=16
#PBS -l walltime=12:00:00
#PBS -o 04_bootrep_bstrap.stdout
#PBS -e 04_bootrep_bstrap.stderr
#PBS -N 04_{{cookiecutter.analysis_name}}
#PBS -A {{cookiecutter.allocation_name}}

export workdir={{cookiecutter.top_level_directory}}/{{cookiecutter.analysis_name}}
export bootrep=$workdir/{{cookiecutter.bootrep_trees_directory}}
export bootrep_reps=$bootrep/{{cookiecutter.bootrep_trees_reps_directory}}
export phylip=$workdir/{{cookiecutter.phylip_file}}
export reps={{cookiecutter.number_of_bootreps}}

# compute some values on the fly
rep_iterator=$(({{cookiecutter.number_of_bootreps}} - 1))

mkdir -p $bootrep_reps
cd $bootrep_reps
# processing starts
date
# there seems to be a bug in raxml w/ full paths and bootstrapping
# use symlink to get around it
ln -s $workdir/{{cookiecutter.phylip_file}}
# generate $reps bootreps from phylip file
raxmlHPC-AVX -N $reps -b $RANDOM -f j -m GTRGAMMA -s {{cookiecutter.phylip_file}} -n REPS
# convert those bootreps to binary format
parallel 'parse-examl -m DNA -s {{cookiecutter.phylip_file}}.BS{} -n BS{}' ::: $(seq 0 $rep_iterator)
# processing ends
date
# done
exit 0

