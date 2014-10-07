#!/bin/bash
#PBS -q checkpt
#PBS -l nodes={{cookiecutter.analysis_nodes}}:ppn={{cookiecutter.analysis_ppn}}
#PBS -l walltime=72:00:00
#PBS -o best_examl_stdout
#PBS -e best_examl_stderr
#PBS -N best_examl
#PBS -A {{cookiecutter.allocation_name}}

export workdir=$PWD/{{cookiecutter.analysis_name}}
export best=$workdir/{{cookiecutter.best_trees_directory}}
export parsimony=$best/{{cookiecutter.best_trees_parsimony_directory}}
export binary_phylip=$best/{{cookiecutter.phylip_path}}.binary
export num_trees=20
procs=$(({{cookiecutter.analysis_nodes}}*{{cookiecutter.analysis_ppn}}))

mkdir -p $best
cd $best
for i in {0..$num_trees};
do
    time mpirun -np $procs examl-AVX -s $binary_phylip -t $parsimony/RAxML_parsimonyTree.best.RUN.$i -m GAMMA -n T$i;
done
