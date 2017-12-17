# Create the key pair and extract the private key from the JSON response
aws ec2 create-key-pair
   --key-name=laravelaws
   --query 'KeyMaterial'
   --output text > laravelaws.pem

# Assign appropriate permissions to the key file for it to be usable
chmod 400 laravelaws.pem
