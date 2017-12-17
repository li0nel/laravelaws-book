   CloudFrontDistribution:
       Type: AWS::CloudFront::Distribution
       Properties:
           DistributionConfig:
               Origins:
                   - DomainName: !Ref S3BucketDNSName
                     Id: myS3Origin
                     S3OriginConfig:
                         OriginAccessIdentity: !Ref CloudFrontOAI
              Enabled: 'true'
              Aliases:
                  - !Ref CDNAlias
              DefaultCacheBehavior:
                  Compress: 'true'
                  AllowedMethods:
                      - GET
                      - HEAD
                      - OPTIONS
                  TargetOriginId: myS3Origin
                  ForwardedValues:
                      QueryString: 'false'
                      Cookies:
                         Forward: none
                  ViewerProtocolPolicy: redirect-to-https
              ViewerCertificate:
                  AcmCertificateArn: !Ref CertificateArn
