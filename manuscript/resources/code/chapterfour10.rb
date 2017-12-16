   # One Docker registry that we will use both for the Laravel application
   # image and our Nginx image.
   # Note that if you give a name to the repository, CloudFormation can't
   # update it without a full replacement.
   ECR:
       Type: AWS::ECR::Repository
       Properties:
   #            RepositoryName: !Sub ${AWS::StackName}-nginx
           RepositoryPolicyText:
              Version: "2012-10-17"
              Statement:
                  -
                    Sid: AllowPushPull
                    Effect: Allow
                    Principal:
                      AWS:
                        - !Sub arn:aws:iam::${AWS::AccountId}:role/${ECSRole}
                    Action:
                      - "ecr:GetDownloadUrlForLayer"
                      - "ecr:BatchGetImage"
                      - "ecr:BatchCheckLayerAvailability"
                      - "ecr:PutImage"
                      - "ecr:InitiateLayerUpload"
                      - "ecr:UploadLayerPart"
                      - "ecr:CompleteLayerUpload"
