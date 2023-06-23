#!/bin/bash
echo 'Getting nodes'
nodes=$(oc get nodes -o=custom-columns=NAME:.metadata.name | tail -n +2)
line=0
for node in $nodes; do
	echo 'Getting pods for the node'
	echo $node
	for i in $(oc get pods -A -o=custom-columns=NAME:.metadata.name,NAMESPACE:.metadata.namespace --field-selector=spec.host=ip-10-0-228-43.us-east-2.compute.internal | tail -n +2)
		do
			if [[ $line -eq 0 ]]; then
				podName=$i
			else
				namespace=$i
				line=$(($var-1))
				resources=$(oc get pod/$podName -n $namespace  -o=jsonpath='{.spec.containers[0].resources}')
				echo $namespace 
				echo $podName
				echo $resources
				echo -e "\n"
				echo "<<<<<<<<>>>>>>>>>>"
			fi
			line=$(($line + 1 ))
		done



	#oc get pod/$pod -o=jsonpath='{.items..resources.limits}'
done
