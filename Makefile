build:
	docker build -t opstree/ecsmanager .

get-inside-container:
	docker run --entrypoint "/bin/sh" -it --rm -v ${PWD}/aws:/root/.aws opstree/ecsmanager

aws-configure:
	docker run -it --rm -v ${PWD}/aws:/root/.aws opstree/ecsmanager configure

create-vpc:
	docker run -it --rm -v ${PWD}/aws:/root/.aws opstree/ecsmanager cloudformation create-stack --stack-name ${vpc-name}-vpc --template-body file:///infrastructure/vpc.yaml --capabilities CAPABILITY_NAMED_IAM --parameters file:///sample/vpc.json
	
delete-vpc:
	docker run -it --rm -v ${PWD}/aws:/root/.aws opstree/ecsmanager cloudformation delete-stack --stack-name ${vpc-name}-vpc

create-cluster:
	docker run -it --rm -v ${PWD}/aws:/root/.aws opstree/ecsmanager cloudformation create-stack --stack-name ${cluster-name} --template-body file:///tmp/ecs-cluster.yaml --capabilities CAPABILITY_NAMED_IAM --parameters ParameterKey=KeyName,ParameterValue=${key-name}

delete-cluster:
	docker run -it --rm -v ${PWD}/aws:/root/.aws opstree/ecsmanager cloudformation delete-stack --stack-name ${cluster-name}
