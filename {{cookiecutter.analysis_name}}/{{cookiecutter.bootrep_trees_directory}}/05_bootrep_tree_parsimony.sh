#!/bin/bash
#PBS -q single
#PBS -l nodes=1:ppn=1
#PBS -l walltime=5:00:00
#PBS -o 05_bootrep_parsimonator.stdout
#PBS -e 05_bootrep_parsimonator.stderr
#PBS -N 05_{{cookiecutter.analysis_name}}
#PBS -A {{cookiecutter.allocation_name}}

export workdir={{cookiecutter.top_level_directory}}/{{cookiecutter.analysis_name}}
export bootrep=$workdir/{{cookiecutter.bootrep_trees_directory}}
export bootrep_reps=$bootrep/{{cookiecutter.bootrep_trees_reps_directory}}
export bootrep_parsimony=$bootrep/{{cookiecutter.bootrep_trees_parsimony_directory}}
export phylip={{cookiecutter.phylip_file}}

# compute some values on the fly
rep_iterator=$(({{cookiecutter.number_of_bootreps}} - 1))

mkdir -p $bootrep_parsimony
cd $bootrep_parsimony
# processing starts
date
# iterate over bootreps to create parsimony starting trees
for i in  $(seq 0 $rep_iterator);
do
    parsimonator-AVX -s $bootrep_reps/{{cookiecutter.phylip_file}}.BS$i -p $RANDOM -n BS$i -N 1;
    mv RAxML_parsimonyTree.BS$i.0 RAxML_parsimonyTree.BS$i
    rm $bootrep_reps/{{cookiecutter.phylip_file}}.BS$i
done
# processing ends
date
# done
exit 0
