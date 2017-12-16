   # Create your CloudFormation stack from scratch using the create-stack command
   aws cloudformation create-stack
       --stack-name=laravel
       --template-body=file://master.yaml
       --capabilities CAPABILITY_NAMED_IAM
       --parameters
           ParameterKey=CloudFrontOAI,ParameterValue=origin-access-identity/cloudfront/YOUR_CF_OAI_HERE
           ParameterKey=CertificateArnCF,ParameterValue=arn:aws:acm:us-east-1:your_cloudfront_certificate_arn_here
           ParameterKey=CertificateArn,ParameterValue=arn:aws:acm:us-east-1:your_certificate_arn_here
           ParameterKey=BaseUrl,ParameterValue=laravelaws.com
           ParameterKey=DBMasterPwd,ParameterValue=your_master_db_pwd_here
           ParameterKey=ECSInstanceType,ParameterValue=t2.micro
           ParameterKey=ECSDesiredCount,ParameterValue=1
