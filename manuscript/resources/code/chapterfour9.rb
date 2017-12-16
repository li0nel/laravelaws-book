   # This IAM Role is attached to all of the ECS hosts. It is based on the default role
   # published here:
   # http://docs.aws.amazon.com/AmazonECS/latest/developerguide/instance_IAM_role.html
   #
   # You can add other IAM policy statements here to allow access from your ECS hosts
   # to other AWS services. Please note that this role will be used by ALL containers
   # running on the ECS host.
   ECSRole:
      Type: AWS::IAM::Role
      Properties:
          Path: /
          RoleName: !Sub ${EnvironmentName}-ECSRole-${AWS::Region}
          AssumeRolePolicyDocument: |
              {
                  "Statement": [{
                      "Action": "sts:AssumeRole",
                      "Effect": "Allow",
                      "Principal": {
                          "Service": "ec2.amazonaws.com"
                      }
                  }]
              }
          ManagedPolicyArns:
              - "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
          Policies:
              - PolicyName: ecs-service
                PolicyDocument: |
                  {
                      "Statement": [{
                          "Effect": "Allow",
                          "Action": [
                              "ecs:CreateCluster",
                              "ecs:DeregisterContainerInstance",
                              "ecs:DiscoverPollEndpoint",
                              "ecs:Poll",
                              "ecs:RegisterContainerInstance",
                              "ecs:StartTelemetrySession",
                              "ecs:Submit*",
                              "logs:CreateLogStream",
                              "logs:PutLogEvents",
                              "ecr:BatchCheckLayerAvailability",
                              "ecr:BatchGetImage",
                              "ecr:GetDownloadUrlForLayer",
                              "ecr:GetAuthorizationToken"
                          ],
                          "Resource": "*"
                      }]
                  }
              - PolicyName: ec2-s3-write-access
                PolicyDocument:
                   Statement:
                     - Effect: Allow
                       Action:
                         - s3:PutObject
                         - s3:GetBucketAcl
                         - s3:PutObjectTagging
                         - s3:ListBucket
                         - s3:PutObjectAcl
                       Resource: !Sub arn:aws:s3:::${S3BucketName}/*
              - PolicyName: ec2-cloudwatch-write-access
                PolicyDocument:
                  Statement:
                    - Effect: Allow
                      Action:
                        - logs:CreateLogStream
                        - logs:PutLogEvents
                        - logs:CreateLogGroup
                      Resource: "*"
 
   ECSInstanceProfile:
      Type: AWS::IAM::InstanceProfile
      Properties:
          Path: /
          Roles:
              - !Ref ECSRole
