SELECT instance.InstanceId,instance.PublicIpAddress,instance.PublicIpAddress,subnet.CidrBlock 
FROM dfs.`/tmp/instances.json` instance
JOIN dfs.`/tmp/subnets.json` subnet  on instance.SubnetId=subnet.SubnetId
WHERE instance.Placement.AvailabilityZone='eu-west-1b';
