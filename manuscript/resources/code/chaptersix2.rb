     # Add your key to your SSH agent
     ssh-add -K laravelaws.pem

     # Verify that your private key is successfully loaded in your local SSH agent
     ssh-add –L

     # Use the -A option to enable forwarding of the authentication agent connection
     ssh –A ec2-user@&lt;bastion-public-IP-address&gt;

     # Once you are connected to the bastion, you can SSH into a private subnet instance
     # without copying any SSH key on the bastion
     ssh ec2-user@&lt;instance-private-IP-address&gt;