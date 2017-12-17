   StackAlarmTopic:
       Type: AWS::SNS::Topic
       Properties:
           DisplayName: Stack Alarm Topic
  
   DatabasePrimaryCPUAlarm:
       Type: AWS::CloudWatch::Alarm
       Properties:
           AlarmDescription: Primary database CPU utilization is over 80%.
          Namespace: AWS/RDS
          MetricName: CPUUtilization
          Unit: Percent
          Statistic: Average
          Period: 300
          EvaluationPeriods: 2
          Threshold: 80
          ComparisonOperator: GreaterThanOrEqualToThreshold
          Dimensions:
              - Name: DBInstanceIdentifier
                Value:
                    Ref: DatabasePrimaryInstance
          AlarmActions:
              - Ref: StackAlarmTopic
          InsufficientDataActions:
              - Ref: StackAlarmTopic
 
   DatabaseReplicaCPUAlarm:
       Type: AWS::CloudWatch::Alarm
       Properties:
          AlarmDescription: Replica database CPU utilization is over 80%.
          Namespace: AWS/RDS
          MetricName: CPUUtilization
          Unit: Percent
          Statistic: Average
          Period: 300
          EvaluationPeriods: 2
          Threshold: 80
          ComparisonOperator: GreaterThanOrEqualToThreshold
          Dimensions:
              - Name: DBInstanceIdentifier
                Value:
                    Ref: DatabaseReplicaInstance
          AlarmActions:
              - Ref: StackAlarmTopic
          InsufficientDataActions:
              - Ref: StackAlarmTopic
 
   DatabasePrimaryMemoryAlarm:
       Type: AWS::CloudWatch::Alarm
       Properties:
          AlarmDescription: Primary database freeable memory is under 700MB.
          Namespace: AWS/RDS
          MetricName: FreeableMemory
          Unit: Bytes
          Statistic: Average
          Period: 300
          EvaluationPeriods: 2
          Threshold: 700000000
          ComparisonOperator: LessThanOrEqualToThreshold
          Dimensions:
              - Name: DBInstanceIdentifier
                Value:
                    Ref: DatabasePrimaryInstance
          AlarmActions:
              - Ref: StackAlarmTopic
          InsufficientDataActions:
              - Ref: StackAlarmTopic
 
   DatabasePrimaryReplicationAlarm:
       Type: AWS::CloudWatch::Alarm
       Properties:
          AlarmDescription: Database replication latency is over 200ms.
          Namespace: AWS/RDS
          MetricName: AuroraReplicaLag
          Unit: Milliseconds
          Statistic: Average
          Period: 300
          EvaluationPeriods: 2
          Threshold: 200
          ComparisonOperator: GreaterThanOrEqualToThreshold
          Dimensions:
              - Name: DBInstanceIdentifier
                Value:
                    Ref: DatabaseReplicaInstance
          AlarmActions:
              - Ref: StackAlarmTopic
 
   DatabaseReplicaReplicationAlarm:
       Type: AWS::CloudWatch::Alarm
       Properties:
          AlarmDescription: Database replication latency is over 200ms.
          Namespace: AWS/RDS
          MetricName: AuroraReplicaLag
          Unit: Milliseconds
          Statistic: Average
          Period: 300
          EvaluationPeriods: 2
          Threshold: 200
          ComparisonOperator: GreaterThanOrEqualToThreshold
          Dimensions:
             - Name: DBInstanceIdentifier
               Value:
                   Ref: DatabaseReplicaInstance
          AlarmActions:
             - Ref: StackAlarmTopic
