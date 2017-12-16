   # This template creates a VPC and a pair public and private subnets spanning the first two AZs of your current region.
   # Each instance in the public subnet can accessed the internet and be accessed from the internet
   # thanks to a route table routing traffic through the Internet Gateway.
   # Private subnets feature a NAT Gateway located in the public subnet of the same AZ, so they can receive traffic
   # from within the VPC.
   VPC:
      Type: AWS::EC2::VPC
      Properties:
         CidrBlock: !Ref VpcCIDR
         Tags:
             - Key: Name
               Value: !Ref EnvironmentName

   InternetGateway:
      Type: AWS::EC2::InternetGateway
      Properties:
         Tags:
             - Key: Name
               Value: !Ref EnvironmentName

   InternetGatewayAttachment:
      Type: AWS::EC2::VPCGatewayAttachment
      Properties:
         InternetGatewayId: !Ref InternetGateway
         VpcId: !Ref VPC

   PublicSubnet1:
      Type: AWS::EC2::Subnet
      Properties:
         VpcId: !Ref VPC
         AvailabilityZone: !Select [ 0, !GetAZs ]
         CidrBlock: !Ref PublicSubnet1CIDR
         MapPublicIpOnLaunch: true
         Tags:
             - Key: Name
               Value: !Sub ${EnvironmentName} Public Subnet (AZ1)

   PublicSubnet2:
      Type: AWS::EC2::Subnet
      Properties:
         VpcId: !Ref VPC
         AvailabilityZone: !Select [ 1, !GetAZs ]
         CidrBlock: !Ref PublicSubnet2CIDR
         MapPublicIpOnLaunch: true
         Tags:
             - Key: Name
               Value: !Sub ${EnvironmentName} Public Subnet (AZ2)

   PrivateSubnet1:
      Type: AWS::EC2::Subnet
      Properties:
         VpcId: !Ref VPC
         AvailabilityZone: !Select [ 0, !GetAZs ]
         CidrBlock: !Ref PrivateSubnet1CIDR
         MapPublicIpOnLaunch: false
         Tags:
             - Key: Name
               Value: !Sub ${EnvironmentName} Private Subnet (AZ1)

   PrivateSubnet2:
      Type: AWS::EC2::Subnet
      Properties:
         VpcId: !Ref VPC
         AvailabilityZone: !Select [ 1, !GetAZs ]
         CidrBlock: !Ref PrivateSubnet2CIDR
         MapPublicIpOnLaunch: false
         Tags:
             - Key: Name
               Value: !Sub ${EnvironmentName} Private Subnet (AZ2)

   NatGateway1EIP:
      Type: AWS::EC2::EIP
      DependsOn: InternetGatewayAttachment
      Properties:
         Domain: vpc

   NatGateway2EIP:
      Type: AWS::EC2::EIP
      DependsOn: InternetGatewayAttachment
      Properties:
         Domain: vpc

   NatGateway1:
      Type: AWS::EC2::NatGateway
      Properties:
         AllocationId: !GetAtt NatGateway1EIP.AllocationId
         SubnetId: !Ref PublicSubnet1

   NatGateway2:
      Type: AWS::EC2::NatGateway
      Properties:
         AllocationId: !GetAtt NatGateway2EIP.AllocationId
         SubnetId: !Ref PublicSubnet2

   PublicRouteTable:
      Type: AWS::EC2::RouteTable
      Properties:
         VpcId: !Ref VPC
         Tags:
             - Key: Name
               Value: !Sub ${EnvironmentName} Public Routes

   DefaultPublicRoute:
      Type: AWS::EC2::Route
      DependsOn: InternetGatewayAttachment
      Properties:
         RouteTableId: !Ref PublicRouteTable
         DestinationCidrBlock: 0.0.0.0/0
         GatewayId: !Ref InternetGateway

   PublicSubnet1RouteTableAssociation:
      Type: AWS::EC2::SubnetRouteTableAssociation
      Properties:
         RouteTableId: !Ref PublicRouteTable
         SubnetId: !Ref PublicSubnet1

   PublicSubnet2RouteTableAssociation:
      Type: AWS::EC2::SubnetRouteTableAssociation
      Properties:
         RouteTableId: !Ref PublicRouteTable
         SubnetId: !Ref PublicSubnet2

   PrivateRouteTable1:
      Type: AWS::EC2::RouteTable
      Properties:
         VpcId: !Ref VPC
         Tags:
             - Key: Name
               Value: !Sub ${EnvironmentName} Private Routes (AZ1)

   DefaultPrivateRoute1:
       Type: AWS::EC2::Route
       Properties:
       RouteTableId: !Ref PrivateRouteTable1
       DestinationCidrBlock: 0.0.0.0/0
       NatGatewayId: !Ref NatGateway1

   PrivateSubnet1RouteTableAssociation:
     Type: AWS::EC2::SubnetRouteTableAssociation
     Properties:
       RouteTableId: !Ref PrivateRouteTable1
       SubnetId: !Ref PrivateSubnet1

   PrivateRouteTable2:
     Type: AWS::EC2::RouteTable
     Properties:
       VpcId: !Ref VPC
       Tags:
         - Key: Name
         Value: !Sub ${EnvironmentName} Private Routes (AZ2)

   DefaultPrivateRoute2:
     Type: AWS::EC2::Route
     Properties:
       RouteTableId: !Ref PrivateRouteTable2
       DestinationCidrBlock: 0.0.0.0/0
       NatGatewayId: !Ref NatGateway2

   PrivateSubnet2RouteTableAssociation:
     Type: AWS::EC2::SubnetRouteTableAssociation
     Properties:
       RouteTableId: !Ref PrivateRouteTable2
       SubnetId: !Ref PrivateSubnet2
