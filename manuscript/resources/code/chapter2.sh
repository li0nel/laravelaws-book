# a certificate in your default region for your web application
aws acm request-certificate
   --domain-name laravelaws.com
   --idempotency-token=random_string_here
   --subject-alternative-names *.laravelaws.com

# a certificate from us-east-1 specifically for our CloudFront custom domain
aws --region us-east-1 acm request-certificate
   --domain-name laravelaws.com
   --idempotency-token=random_string_here
   --subject-alternative-names *.laravelaws.com