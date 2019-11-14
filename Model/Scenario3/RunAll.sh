#!/bin/bash

# This file executes pre-processing scripts and makefiles, runs MESH, and then runs post-processing scripts to generate outputs.

# 1. Obtain the directory where this script is located
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# 2. Process the driving data by running the "make" file in the "Code" folder, which calls all the Rscripts
# cd ../../Code
# make

# 3. Run the makefile to update the CLASS.ini and hydrology.ini files based on the "ParamValues.csv" file, and copy the files to the "Model/Scenario_X/Input" folder
# cd $DIR
# cd ../../Code
# Rscript Find_Replace_in_Text_File.R
# cp MESH_parameters_CLASS.ini MESH_parameters_CLASS.tpl MESH_parameters_hydrology.ini MESH_parameters_hydrology.tpl $DIR/Input

# 4. Create symbolic links to the driving data
cd $DIR/Input
pwd
ln -s ../../../Data/Processed/Driving/Scenario2and3/basin_humidity.csv ./basin_humidity.csv
ln -s ../../../Data/Processed/Driving/Scenario2and3/basin_longwave.csv ./basin_longwave.csv
ln -s ../../../Data/Processed/Driving/Scenario2and3/basin_pres.csv ./basin_pres.csv
ln -s ../../../Data/Processed/Driving/Scenario2and3/basin_rain.csv ./basin_rain.csv
ln -s ../../../Data/Processed/Driving/Scenario2and3/basin_shortwave.csv ./basin_shortwave.csv
ln -s ../../../Data/Processed/Driving/Scenario2and3/basin_temperature.csv ./basin_temperature.csv
ln -s ../../../Data/Processed/Driving/Scenario2and3/basin_wind.csv ./basin_wind.csv

# and change the executable file permissions
chmod +x run_mesh.sh submitjob.sh

# 5. Check if mesh is compiled, and if not, compile with "make"
# cd $DIR
# cd ../MESH_Code/MESH_Code.r1024
# if [[ ! -f sa_mesh ]] ; then
#   make -f makefile.gfortran
# fi

# 6. Run the makefile to run MESH
cd $DIR/Input
sbatch submitjob.sh

# Run the post-processing script and generate ONE jpeg to start
### INCOMPLETE