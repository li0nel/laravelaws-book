aws ec2 run-instances
   --image-id ami-c1a6bda2
   --key-name laravelaws            # the SSH key pair we created earlier
   --security-group-ids sg-xxxxxxxx # our previous SG allowing access to the DB
   --subnet-id subnet-xxxxxxxx      # one of our public subnets
   --count 1
   --instance-type t2.micro         # the smallest instance type allowed
   --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=bastion}]'
