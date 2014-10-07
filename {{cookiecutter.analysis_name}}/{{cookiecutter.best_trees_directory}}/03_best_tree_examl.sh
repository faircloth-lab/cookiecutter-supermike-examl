#!/bin/bash
#PBS -q checkpt
#PBS -l nodes={{cookiecutter.analysis_nodes}}:ppn={{cookiecutter.analysis_ppn}}
#PBS -l walltime=72:00:00
#PBS -o best_examl_stdout
#PBS -e best_examl_stderr
#PBS -N best_examl
#PBS -A {{cookiecutter.allocation_name}}

export workdir={{cookiecutter.top_level_directory}}/{{cookiecutter.analysis_name}}
export best=$workdir/{{cookiecutter.best_trees_directory}}
export parsimony=$best/{{cookiecutter.best_trees_parsimony_directory}}
export binary_phylip={{cookiecutter.tld}}/{{cookiecutter.analysis_name}}/{{cookiecutter.phylip_file}}.binary
export num_trees=20
procs=$(({{cookiecutter.analysis_nodes}}*{{cookiecutter.analysis_ppn}}))

cd $best
# processing starts
date
# run command
for i in {0..$num_trees};
do
    mpirun -np $procs examl-AVX -s $binary_phylip -t $parsimony/RAxML_parsimonyTree.best.RUN.$i -m GAMMA -n T$i;
done
# processing ends
date
# done
exit 0
