#!/bin/bash
#PBS -q workq
#PBS -l nodes={{cookiecutter.analysis_nodes}}:ppn={{cookiecutter.analysis_ppn}}
#PBS -l walltime={{cookiecutter.analysis_time}}:00:00
#PBS -o 03_best_examl.stdout
#PBS -e 03_best_examl.stderr
#PBS -N 03_best_examl
#PBS -A {{cookiecutter.allocation_name}}

export workdir={{cookiecutter.top_level_directory}}/{{cookiecutter.analysis_name}}
export best=$workdir/{{cookiecutter.best_trees_directory}}
export parsimony=$best/{{cookiecutter.best_trees_parsimony_directory}}
export binary_phylip=$best/{{cookiecutter.phylip_file}}.binary

# compute some values on the fly
num_trees_iter=$(({{cookiecutter.number_of_trees}} - 1))
procs=$(({{cookiecutter.analysis_nodes}} * {{cookiecutter.analysis_ppn}}))

cd $best
# processing starts
date
# run command
for i in {0..$num_trees_iter};
do
    mpirun -np $procs -machinefile $PBS_NODEFILE examl-AVX -s $binary_phylip -t $parsimony/RAxML_parsimonyTree.best.RUN.$i -m GAMMA -n T$i;
done
# processing ends
date
# done
exit 0
