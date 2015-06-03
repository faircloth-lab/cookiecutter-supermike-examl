## cookiecutter-supermike-examl

This is a [cookiecutter](https://github.com/audreyr/cookiecutter) repository that helps you prepare [PBS](http://en.wikipedia.org/wiki/Portable_Batch_System) submission scripts for [ExaML](http://sco.h-its.org/exelixis/web/software/examl/index.html) runs of large data sets on an HPC system.

To use, you need to [install cookiecutter](http://cookiecutter.readthedocs.org/en/latest/installation.html).  Then, you can create the scripts by running:

```bash
cookiecutter https://github.com/faircloth-lab/cookiecutter-supermike-examl
```

Which will ask you several questions (current directory, working directory, nodes, CPUs per node, etc.) and build the scripts you need.  Then, within each of the *best* and *bootrep* directories, submit the created scripts, in order, to run ExaML.
