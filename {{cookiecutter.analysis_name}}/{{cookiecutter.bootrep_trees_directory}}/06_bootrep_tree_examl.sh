#!/bin/bash
#PBS -q checkpt
#PBS -l nodes={{cookiecutter.analysis_nodes}}:ppn={{cookiecutter.analysis_ppn}}
#PBS -l walltime={{cookiecutter.analysis_time}}:00:00
#PBS -o 06_bootrep_examl.stdout
#PBS -e 06_bootrep_examl.stderr
#PBS -N 06_bootrep_examl
#PBS -A {{cookiecutter.allocation_name}}

export workdir={{cookiecutter.top_level_directory}}/{{cookiecutter.analysis_name}}
export bootrep=$workdir/{{cookiecutter.bootrep_trees_directory}}
export bootrep_reps=$bootrep/{{cookiecutter.bootrep_trees_reps_directory}}
export bootrep_parsimony=$bootrep/{{cookiecutter.bootrep_trees_parsimony_directory}}

# compute some values on the fly
rep_iterator=$(({{cookiecutter.number_of_bootreps}} - 1))
procs=$(({{cookiecutter.analysis_nodes}} * {{cookiecutter.analysis_ppn}}))

cd $bootrep
# processing starts
date
for i in $(seq 0 $rep_iterator);
do
    mpirun -np $procs -machinefile $PBS_NODEFILE examl-AVX -s $bootrep_reps/BS$i.binary -t $bootrep_parsimony/RAxML_parsimonyTree.BS$i -m GAMMA -n T$i;
    rm $bootrep_reps/BS$i.binary;
    rm ExaML_binaryCheckpoint.T$i_*;
done
# processing ends
date
# done
exit 0
