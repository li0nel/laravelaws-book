# Add an ALIAS record to ELB URL
aws route53 change-resource-record-sets
   --hosted-zone-id /hostedzone/YOUR_HOSTED_ZONE_ID
   --change-batch '{
  "Changes":[
     {
        "Action":"CREATE",
        "ResourceRecordSet":{
           "Name":"files.laravelaws.com.",
          "Type":"A",
          "AliasTarget":{
             "DNSName":"d165d2lrm1x3fz.cloudfront.net",
             "EvaluateTargetHealth":true,
             "HostedZoneId":"YOUR_HOSTED_ZONE_ID"
          }
       }
    }
 ]
}'
