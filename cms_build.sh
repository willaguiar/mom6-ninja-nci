#!/usr/bin/bash

module purge
module use /g/data/hh5/public/modules
module load netcdf/4.7.4 
module load intel-compiler/2020.1.217 
module load conda/analysis3
module load openmpi/4.0.2

echo "Change directory to scratch"
cd /scratch/v45/wf4500/

echo "Download source code and build scripts"
#git clone --recursive https://github.com/NOAA-GFDL/MOM6-examples.git MOM6-examples
git clone --recursive https://github.com/willaguiar/MOM6-examples.git MOM6-examples

echo "Configure build scripts"
cd mom6-ninja-nci
./gen_build.sh

echo "Compile FMS library"
(cd shared && ./gen_build.sh && ninja)

echo "Compile MOM6 ocean-only"
(cd ocean_only_symmetric && ./gen_build.sh && ninja)


