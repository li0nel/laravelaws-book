# Add an ALIAS record to ELB URL
aws?route53 change-resource-record-sets?
   --hosted-zone-id /hostedzone/YOUR_HOSTED_ZONE_ID
   --change-batch '{
  "Changes":[
     {
        "Action":"CREATE",
        "ResourceRecordSet":{
           "Name":"laravelaws.com.",
          "Type":"A",
          "AliasTarget":{
             "DNSName":"laravelaws2-1297867430.ap-southeast-2.elb.amazonaws.com",
             "EvaluateTargetHealth":true,
             "HostedZoneId":"YOUR_HOSTED_ZONE_ID"
          }
       }
    }
 ]
}'

# Track the propagation of the record
aws?route53 get-change?--id /change/YOUR_CHANGE_ID

# Test your record even before it is propagated
aws?route53 test-dns-answer
      --hosted-zone-id /hostedzone/YOUR_HOSTED_ZONE_ID
      --record-name laravelaws.com?
      --record-type A
