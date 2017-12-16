   # This security group defines who/where is allowed to access the RDS instance.
   # Only instances associated with our ECS security group can reach to the database endpoint.
   DBSecurityGroup:
     Type: AWS::EC2::SecurityGroup
     Properties:
         GroupDescription: Open database for access
         VpcId: !Ref VPC
         SecurityGroupIngress:
             - IpProtocol: tcp
              FromPort: '3306'
              ToPort: '3306'
              SourceSecurityGroupId: !Ref ECSSecurityGroup
        Tags:
            - Key: Name
              Value: !Sub ${EnvironmentName}-DB-Host
