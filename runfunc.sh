#!/bin/bash/

###takes files with input values for accumulation gradient, accumulation, divide position, and template filename 


####### Variables ##########
inputfil=runvalues.txt
outputbucket=gs://ldeo-glaciology/elmer_janie/run_outputs/
dockcont=elmertest_janie1
###############


while read -r xa a0 DivPos filnam remainder; do

mkdir -p icerise_run
#touch Korff_run/examplefile.txt
mkdir -p icerise_run/mesh/
mkdir -p icerise_run/src/
bash update_sif.sh ${xa} ${a0} ${DivPos} ${filnam} #create new sif file from template
##cp Case_*.sif output/
cp elmer_icerise_base/mesh.grd icerise_run #template mesh grid
cp elmer_icerise_base/src/* icerise_run/src/ #template solvers into new folder
mv Case_${xa}_${a0}_${DivPos}.sif icerise_run/
chmod -R 777 icerise_run/
echo 'Entering docker container and running the script'
sudo service docker start
docker start ${dockcont}

echo [`date +"%D %T"`] Running Case_${xa}_${a0}_${DivPos} | tee -a log.txt
echo [`date +"%D %T"`] ElmerGrid 1 2 icerise_run/mesh.grd | tee -a log.txt
docker exec ${dockcont} ElmerGrid 1 2 shared_directory/icerise_run/mesh.grd | tee -a log.txt

echo [`date +"%D %T"`] ElmerSolver shared_directory/icerise_run/Case_${xa}_${a0}_${DivPos}.sif | tee -a log.txt
docker exec ${dockcont} ElmerSolver shared_directory/icerise_run/Case_${xa}_${a0}_${DivPos}.sif | tee -a log.txt

#gsutil cp icerise_run/Surface.dat gs://ldeo-glaciology/elmer_janie/run_outputs/Surface_${xa}_${a0}_${DivPos}.dat
#gsutil cp icerise_run/src/Results.dat gs://ldeo-glaciology/elmer_janie/run_outputs/Results_${xa}_${a0}_${DivPos}.dat
gsutil cp icerise_run/mesh/*.vtu ${outputbucket}run_${xa}_${a0}_${DivPos}/

echo [`date +"%D %T"`] Finished Case_${xa}_${a0}_${DivPos} | tee -a log.txt
done < ${inputfil}
