   # This template defines our ECS cluster and its desired size.
   # The Launch Configuration defines how each new instance in our cluster should be bootstrapped
   # through its User Data
   # The Metadata object gets EC2 instances to register in the ECS cluster
   ECSCluster:
       Type: AWS::ECS::Cluster
       Properties:
           ClusterName: !Ref EnvironmentName
  
   ECSAutoScalingGroup:
       Type: AWS::AutoScaling::AutoScalingGroup
       Properties:
          VPCZoneIdentifier: !Ref PrivateSubnets
          LaunchConfigurationName: !Ref ECSLaunchConfiguration
          MinSize: !Ref ClusterSize
          MaxSize: !Ref ClusterSize
          DesiredCapacity: !Ref ClusterSize
          Tags:
              - Key: Name
                Value: !Sub ${EnvironmentName} ECS host
                PropagateAtLaunch: true
      CreationPolicy:
          ResourceSignal:
              Timeout: PT15M
      UpdatePolicy:
          AutoScalingReplacingUpdate:
              WillReplace: true
          AutoScalingRollingUpdate:
              MinInstancesInService: 1
              MaxBatchSize: 1
              PauseTime: PT15M
              SuspendProcesses:
                - HealthCheck
                - ReplaceUnhealthy
                - AZRebalance
                - AlarmNotification
                - ScheduledActions
              WaitOnResourceSignals: true
 
   ECSLaunchConfiguration:
      Type: AWS::AutoScaling::LaunchConfiguration
      Properties:
          ImageId:  !FindInMap [AWSRegionToAMI, !Ref "AWS::Region", AMI]
          InstanceType: !Ref InstanceType
          SecurityGroups:
              - !Ref ECSSecurityGroup
          IamInstanceProfile: !Ref ECSInstanceProfile
          KeyName: laravelaws
          UserData:
              "Fn::Base64": !Sub |
                  #!/bin/bash
                  yum update -y
                  yum install -y aws-cfn-bootstrap aws-cli go
                  echo '{ "credsStore": "ecr-login" }' > ~/.docker/config.json
                  go get -u github.com/awslabs/amazon-ecr-credential-helper/ecr-login/cli/docker-credential-ecr-login
                  cd /home/ec2-user/go/src/github.com/awslabs/amazon-ecr-credential-helper/ecr-login/cli/docker-credential-ecr-login
                  go build
                  export PATH=$PATH:/home/ec2-user/go/bin
                  /opt/aws/bin/cfn-init -v --region ${AWS::Region} --stack ${AWS::StackName} --resource ECSLaunchConfiguration
                  /opt/aws/bin/cfn-signal -e $? --region ${AWS::Region} --stack ${AWS::StackName} --resource ECSAutoScalingGroup
      Metadata:
          AWS::CloudFormation::Init:
              config:
                  commands:
                      01_add_instance_to_cluster:
                          command: !Sub echo ECS_CLUSTER=${ECSCluster} >> /etc/ecs/ecs.config
                  files:
                      "/etc/cfn/cfn-hup.conf":
                          mode: 000400
                          owner: root
                          group: root
                          content: !Sub |
                              [main]
                              stack=${AWS::StackId}
                              region=${AWS::Region}
                      "/etc/cfn/hooks.d/cfn-auto-reloader.conf":
                          content: !Sub |
                              [cfn-auto-reloader-hook]
                              triggers=post.update
                              path=Resources.ECSLaunchConfiguration.Metadata.AWS::CloudFormation::Init
                              action=/opt/aws/bin/cfn-init -v --region ${AWS::Region} --stack ${AWS::StackName} --resource ECSLaunchConfiguration
                  services:
                      sysvinit:
                          cfn-hup:
                              enabled: true
                              ensureRunning: true
                              files:
                                  - /etc/cfn/cfn-hup.conf
                                  - /etc/cfn/hooks.d/cfn-auto-reloader.conf
