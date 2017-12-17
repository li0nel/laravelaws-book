   AlarmTopic:
       Type: AWS::SNS::Topic
       Properties:
           Subscription:
               - Endpoint: your_email_here@company.com
                 Protocol: email
  
   CPUAlarmHigh:
       Type: AWS::CloudWatch::Alarm
      Properties:
          EvaluationPeriods: '1'
          Statistic: Average
          Threshold: '50'
          AlarmDescription: Alarm if CPU too high or metric disappears indicating instance is down
          Period: '60'
   #            AlarmActions:
   #                - Ref: ScaleUpPolicy
          AlarmActions:
              - Ref: AlarmTopic
          Namespace: AWS/EC2
          Dimensions:
              - Name: AutoScalingGroupName
                Value: !Ref ECSAutoScalingGroup
          ComparisonOperator: GreaterThanThreshold
          MetricName: CPUUtilization
