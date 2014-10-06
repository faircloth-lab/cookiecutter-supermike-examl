#!/bin/bash
#PBS -q checkpt
#PBS -l nodes={{cookiecutter.analysis_nodes}}:ppn={{cookiecutter.analysis_ppn}}
#PBS -l walltime=72:00:00
#PBS -o best_examl_stdout
#PBS -e best_examl_stderr
#PBS -N best_examl
#PBS -A {{cookiecutter.allocation_name}}

export WORKDIR={{cookiecutter.working_directory}}
export PARSIMONY={{cookiecutter.working_directory}}/{{cookiecutter.best_trees_directory}}/{{cookiecutter.best_trees_parsimony_directory}}
export BINARY_PHYLIP={{cookiecutter.working_directory}}/{{cookiecutter.phylip_path}}.bin
export NUM_TREES=20
PROCS=$(({{cookiecutter.analysis_nodes}}*{{cookiecutter.analysis_ppn}}))


cd $WORKDIR
for i in {0..$NUM_TREES};
do
    mpirun -np $PROCS examl-AVX -s $BINARY_PHYLIP -t $PARSIMONY/RAxML_parsimonyTree.best.RUN.$i -m GAMMA -n T$i;
done
