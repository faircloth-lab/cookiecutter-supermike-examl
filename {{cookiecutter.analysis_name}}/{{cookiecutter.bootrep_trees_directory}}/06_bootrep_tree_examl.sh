#!/bin/bash
#PBS -q checkpt
#PBS -l nodes={{cookiecutter.analysis_nodes}}:ppn={{cookiecutter.analysis_ppn}}
#PBS -l walltime=72:00:00
#PBS -o examl_stdout
#PBS -e examl_stderr
#PBS -N examl
#PBS -A {{cookiecutter.allocation_name}}

export bootrep={{cookiecutter.working_directory}}/{{cookiecutter.bootrep_trees_directory}}
export bootrep_reps={{cookiecutter.working_directory}}/{{cookiecutter.bootrep_trees_directory}}/{{cookiecutter.bootrep_trees_reps_directory}}
export bootrep_parsimony={{cookiecutter.working_directory}}/{{cookiecutter.bootrep_trees_directory}}/{{cookiecutter.bootrep_trees_parsimony_directory}}
export reps={{cookiecutter.number_of_bootreps}}
export binary_phylip={{cookiecutter.working_directory}}/{{cookiecutter.phylip_path}}.bin
export phylip={{cookiecutter.phylip_path}}
procs=$(({{cookiecutter.analysis_nodes}}*{{cookiecutter.analysis_ppn}}))

cd $bootrep
for i in {1..$reps};
do
    mpirun -np $procs examl-AVX -s $bootrep_reps/$phylip.BS$i.binary -t $bootrep_parsimony/RAxML_parsimonyTree.BS$i -m GAMMA -n T$i;
done
