cd "${BASH_SOURCE%/*}" || exit
cd ..
COMMAND=$(sed -e 's/:[^:\/\/]/="/g;s/$/"/g;s/ *=/=/g' config.yml) 
eval $COMMAND 
aws cloudformation update-stack --stack-name "$StackName" --template-body file://master.yml --parameters ParameterKey=TemplatesBucketName,ParameterValue="$TemplatesBucketName" --capabilities CAPABILITY_NAMED_IAM