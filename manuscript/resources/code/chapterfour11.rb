   # One ALB with two listeners for HTTP and HTTPS
   # The HTTP listener will pointed to a specific Nginx container redirecting traffic to HTTPS
   # because neither ALB or ELB allow you to handle this through their configuration
   LoadBalancer:
       Type: AWS::ElasticLoadBalancingV2::LoadBalancer
       Properties:
           Name: !Ref EnvironmentName
           Subnets: !Ref PublicSubnets
           SecurityGroups:
              - !Ref LBSecurityGroup
          Tags:
              - Key: Name
                Value: !Ref EnvironmentName

   LoadBalancerListenerHTTP:
       Type: AWS::ElasticLoadBalancingV2::Listener
       Properties:
          LoadBalancerArn: !Ref LoadBalancer
          Port: 80
          Protocol: HTTP
          DefaultActions:
              - Type: forward
                TargetGroupArn: !Ref DefaultTargetGroup

   LoadBalancerListenerHTTPS:
       Type: AWS::ElasticLoadBalancingV2::Listener
       Properties:
          LoadBalancerArn: !Ref LoadBalancer
          Port: 443
          Protocol: HTTPS
          Certificates:
              - CertificateArn: !Ref LBCertificateArn
          DefaultActions:
              - Type: forward
                TargetGroupArn: !Ref DefaultTargetGroup

   # We define a default target group here, as this is a mandatory Parameters
   # when creating an Application Load Balancer Listener. This is not used, instead
   # a target group is created per-service in each service template (../services/*)
   DefaultTargetGroup:
       Type: AWS::ElasticLoadBalancingV2::TargetGroup
       Properties:
          Name: !Sub ${EnvironmentName}-default
          VpcId: !Ref VPC
          Port: 80
          Protocol: HTTP
