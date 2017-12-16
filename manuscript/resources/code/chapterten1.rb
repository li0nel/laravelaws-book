   Elasticsearch:
       Type: AWS::Elasticsearch::Domain
       Properties:
           DomainName: !Sub ${AWS::StackName}-es
           ElasticsearchVersion: 5.5
           ElasticsearchClusterConfig:
               InstanceType: t2.small.elasticsearch
               ZoneAwarenessEnabled: false
               InstanceCount: 1
          EBSOptions:
              EBSEnabled: true
              VolumeSize: 10
          AccessPolicies:
            Version: 2012-10-17
            Statement:
              - Effect: Allow
                Principal:
                  AWS: "*"
                Action:
                  - es:ESHttpDelete
                  - es:ESHttpGet
                  - es:ESHttpHead
                  - es:ESHttpPost
                  - es:ESHttpPut
                Resource: !Sub arn:aws:es:${AWS::Region}:${AWS::AccountId}:domain/${AWS::StackName}-es/*
                Condition:
                  IpAddress:
                    aws:SourceIp:
                      - !GetAtt VPC.Outputs.NatGateway1EIP
                      - !GetAtt VPC.Outputs.NatGateway2EIP
