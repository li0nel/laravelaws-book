# create a hosted zone for AWS to select NS servers for your domain
aws route53 create-hosted-zone
   --name laravelaws.com
   --caller-reference random_string_here

# wait for the hosted zone to be created

# retrieve NS records
aws route53 get-hosted-zone
      --id /hostedzone/YOUR_HOSTED_ZONE_ID

# the NS addresses in the response are the one to upload to your current domain name registrar
{
  "HostedZone": {
      "Id": "/hostedzone/YOUR_HOSTED_ZONE_ID",
      "Name": "laravelaws.com.",
      "CallerReference": "RISWorkflow-RD:824653d6-3f9d-415a-a2e8-8d6fa63fb4c8",
      "Config": {
          "Comment": "HostedZone created by Route53 Registrar",
          "PrivateZone": false
      },
      "ResourceRecordSetCount": 6
  },
  "DelegationSet": {
      "NameServers": [
          "ns-1308.awsdns-03.org",
          "ns-265.awsdns-32.com",
          "ns-583.awsdns-08.net",
          "ns-1562.awsdns-03.co.uk"
      ]
  }
}

# retrieve the TTL for your NS records.
# This is the maximum time it will take for all clients to point to Route53
# after you uploaded them to your current domain name registrar
dig laravelaws.com
