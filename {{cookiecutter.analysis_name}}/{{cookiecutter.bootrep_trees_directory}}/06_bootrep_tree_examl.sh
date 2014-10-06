#!/bin/bash
#PBS -q checkpt
#PBS -l nodes={{cookiecutter.analysis_nodes}}:ppn={{cookiecutter.analysis_ppn}}
#PBS -l walltime=72:00:00
#PBS -o examl_stdout
#PBS -e examl_stderr
#PBS -N examl
#PBS -A {{cookiecutter.allocation_name}}

export BOOTREP={{cookiecutter.working_directory}}/{{cookiecutter.bootrep_trees_directory}}
export BOOTREP_REPS={{cookiecutter.working_directory}}/{{cookiecutter.bootrep_trees_directory}}/{{cookiecutter.bootrep_trees_reps_directory}}
export BOOTREP_PARSIMONY={{cookiecutter.working_directory}}/{{cookiecutter.bootrep_trees_directory}}/{{cookiecutter.bootrep_trees_parsimony_directory}}
export REPS={{cookiecutter.number_of_bootreps}}
export BINARY_PHYLIP={{cookiecutter.working_directory}}/{{cookiecutter.phylip_path}}.bin
export PHYLIP={{cookiecutter.phylip_path}}
PROCS=$(({{cookiecutter.analysis_nodes}}*{{cookiecutter.analysis_ppn}}))

cd $BOOTREP
for i in {1..$REPS};
do
    mpirun -np $PROCS examl-AVX -s $BOOTREP_REPS/$PHYLIP.BS$i.binary -t $BOOTREP_PARSIMONY/RAxML_parsimonyTree.BS$i -m GAMMA -n T$i;
done
