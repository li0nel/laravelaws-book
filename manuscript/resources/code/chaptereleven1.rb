   DatabaseReplicaInstance:
       Type: AWS::RDS::DBInstance
       DependsOn: DatabasePrimaryInstance
       Properties:
           Engine: aurora
           DBClusterIdentifier: !Ref DatabaseCluster
           DBInstanceClass: !Ref DatabaseInstanceType
           DBSubnetGroupName: !Ref DatabaseSubnetGroup
