#!/bin/bash
#PBS -q single
#PBS -l nodes=1:ppn=1
#PBS -l walltime=2:00:00
#PBS -o 01_best_tree_binary.stdout
#PBS -e 01_best_tree_binary.stderr
#PBS -N 01_{{cookiecutter.analysis_name}}
#PBS -A {{cookiecutter.allocation_name}}

export workdir={{cookiecutter.top_level_directory}}/{{cookiecutter.analysis_name}}
export best=$workdir/{{cookiecutter.best_trees_directory}}
export phylip=$workdir/{{cookiecutter.phylip_file}}

# keep the binary alignment file with the best tree
cd $best
# processing starts
date
# run command
parse-examl -m DNA -s $phylip -n {{cookiecutter.phylip_file}}
# processing ends
date
# done
exit 0
