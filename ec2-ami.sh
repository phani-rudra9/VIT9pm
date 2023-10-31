#!/bin/bash
instance_id=`(aws ec2 describe-instances --filters "Name=tag:created_by,Values=naniphani" | grep -i "instanceid" | cut -d ":" -f 2 | cut -d "," -f 1 | tr -d '"')`
if [ -z $instance_id ]
then
 echo "There is no instance_id with the given tags please check proper tags........." && aws sns publish --topic-arn "arn:aws:sns:us-east-2:971076122335:sample-8pm" --message "There is no instance_id with the given tags please check proper tags and trigger the build"  && exit1;
else
echo "The instance id for given Tag is: $instance_id"
echo "Creating AMI for $instance_id........"
aws ec2 create-image --instance-id $instance_id --name "My-jenkins-server-Backup-${Build_Number}" --description "An AMI for my jenkins server server" --no-reboot
fi
