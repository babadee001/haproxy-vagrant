# haproxy-vagrant

## Description
This repo contains the automation process of loadbalancing three databases with one master and two slaves using Haproxy.
The databases are deployed using Terraform as described in the terraform folder in the root of this project.

## Technologies
- [Terraform](https://www.terraform.io/)
- [AWS EC2](https://aws.amazon.com/ec2/?hp=tile&so-exp=below)
- [MYSQL](https://www.mysql.com/)
- [Bash](https://en.wikipedia.org/wiki/Bash_(Unix_shell))

## Logs
The statistic logs from Haproxy can be viewed [here](http://3.91.240.147:8080)

## Data Structure and Setting Up Monitoring

The structure is a MYSQL DB which is built on MySQL Enterprise Edition and powered by the Oracle Cloud, Oracle MySQL Cloud Service  and provides a simple, automated, integrated and enterprise ready MySQL cloud service, enabling me to increase agility and reduce costs. 
Since the Haproxy load balancer and mysql instances are setup on AWS, I would monitor it using the AWS CloudWatch. Amazon CloudWatch is a monitoring and management service built for developers, system operators, site reliability engineers (SRE), and IT managers. CloudWatch provides you with data and actionable insights to monitor your applications, understand and respond to system-wide performance changes, optimize resource utilization, and get a unified view of operational health. CloudWatch collects monitoring and operational data in the form of logs, metrics, and events, providing you with a unified view of AWS resources, applications and services that run on AWS, and on-premises servers. You can use CloudWatch to set high resolution alarms, visualize logs and metrics side by side, take automated actions, troubleshoot issues, and discover insights to optimize your applications, and ensure they are running smoothly.

I only need to activate the CloudWatch monitoring on my instances, then metrics and logs are collected from these resources and are available as a display on the CloudWatch dashboard. I can further setup events to trigger notifications for certain thresholds like when a service or EC2 instance is unavailable or unreachable.

## Cloud Design Pattern

A single cloud service implementation has a finite capacity, which leads to runtime exceptions, failure and performance degradation when its processing thresholds are exceeded. Redundant deployments of the cloud service are created and a load balancing system is added to dynamically distribute workloads across cloud service implementations.
The duplicate cloud service implementations are organized into a resource pool. The load balancer is positioned as an external component allowing hosting servers to balance workloads among themselves.
This setup effectively allows users to effectively access the databases without a downtime. The setup provides high availability and low failover by distributing traffic/requests accordingly among the available servers.

