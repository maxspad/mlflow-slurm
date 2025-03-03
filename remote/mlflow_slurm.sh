#!/bin/bash

echo "Starting mlflow..."
jobid=$(sbatch --output="$PROJDIR/mlflow.log" --parsable remote/mlflow.sbatch.sh)

echo "Jobid is $jobid"
echo "Waiting for node to be populated..."
while true
do
	echo "Waiting for node to be acquired..."
	node=$(squeue -j $jobid -o "%N" | tail -1)
	if [ ! -z "${node}" ]
	then
		echo "Node is $node"
		break
	fi
	sleep 3
done
sleep 3
echo "SSH port forward to node $node on port 5000..."
ssh -f -N -L 5000:localhost:5000 $node
echo "Done."
