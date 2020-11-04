# Ice Rise Development with Elmer
Ice Divide simulations run with ElmerIce
Janie Levin
Last Updated: Oct 30,2020
## Contents


1. icerise_docker_template.sif = Elmer SIF template file  
2. runvalues.txt = each line in this file contains variable values in the order 
	xa(characteristic accumulation length) a0(accumulation intercept) DivPos(Divide Position) filnam(filename)
3. update_sif.sif = updates template sif file with new variables. is referenced in runfunc.sh
4. runfunc.sh = runs the whole automated process. Steps:
	- References input file (runvalues.txt)
	- Reads variables from line of input file 
	- executes update_sif.sif to create new SIF file for each line in input file 
	- generates new folder icerise_run and moves all necessary files into proper structure 
	- enters docker container with Elmer installed and executes ElmerGrid and ElmerSolver 
	- dumps Surface.dat and Results.dat for each case into Google Bucket 

## Instruction:
To run: 
Step 1: Set up runvalues.txt with the cases of interest

Step 2: Detach screen (Linux environment)
	> screen

Step 3: Run the command 
	> source runfunc.sh 

Step 4: Detach screen: "Ctrl-A", "D"
It will run on detached screen. Reconnect to screen with screen -r to check on progress.
