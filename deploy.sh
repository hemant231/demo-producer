#!/usr/bin/env bash

# more bash-friendly output for jq
JQ="jq --raw-output --exit-status"

configure_aws_cli(){
	echo configure_aws_cli
	aws --version
	aws configure set default.region us-east-2
	aws configure set default.output json
}

deploy_cluster() {
    echo deploy_cluster_function
    family="sample-webapp-task-family"
    
    echo deploy_cluster_function 1
    
    make_task_def
    
    echo deploy_cluster_function 2
    
    register_definition
    
    echo deploy_cluster_function 3
    
    if [[ $(aws ecs update-service --cluster yyyyello-team-cluster --service yyyyello-team-service --task-definition $revision | \
                   $JQ '.service.taskDefinition') != $revision ]]; then
        echo "Error updating service."
        return 1
    fi

    # wait for older revisions to disappear
    # not really necessary, but nice for demos
    for attempt in {1..30}; do
        if stale=$(aws ecs describe-services --cluster yyyyello-team-cluster --services yyyyello-team-service | \
                       $JQ ".services[0].deployments | .[] | select(.taskDefinition != \"$revision\") | .taskDefinition"); then
            echo "Waiting for stale deployments:"
            echo "$stale"
            sleep 5
        else
            echo "Deployed!"
            return 0
        fi
    done
    echo "Service update took too long."
    return 1
}

make_task_def(){
	task_template='[
		{
			"name": "yyyyello-team",
			"image": "%s.dkr.ecr.us-east-2.amazonaws.com/yyyyello-team:%s",
			"essential": true,
			"memory": 200,
			"cpu": 10,
			"portMappings": [
				{
					"containerPort": 8080,
					"hostPort": 8080
				}
			]
		}
	]'
	
	task_def=$(printf "$task_template" $AWS_ACCOUNT_ID $CIRCLE_SHA1)
}

push_ecr_image(){
	echo deploy_cluster_function
	eval $(aws ecr get-login --no-include-email --region us-east-2)
	docker push $AWS_ACCOUNT_ID.dkr.ecr.us-east-2.amazonaws.com/yyyyello-team:$CIRCLE_SHA1
}

register_definition() {

    if revision=$(aws ecs register-task-definition --container-definitions "$task_def" --family $family | $JQ '.taskDefinition.taskDefinitionArn'); then
        echo "Revision: $revision"
    else
        echo "Failed to register task definition"
        return 1
    fi

}

configure_aws_cli
push_ecr_image
deploy_cluster
