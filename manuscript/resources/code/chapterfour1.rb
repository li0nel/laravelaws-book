   |--- master.yaml         # the root template
   |--- infrastructure          
      |--- vpc.yaml            # our VPC and security groups
      |--- storage.yaml     # our database cluster and S3 bucket
      |--- web.yaml           # our ECS cluster
      |--- services.yaml    # our ECS Tasks Definitions &amp; Services

