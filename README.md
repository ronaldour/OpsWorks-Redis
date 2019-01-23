# Redis Cluster using AWS OpsWorks

This repository contains all the code required to deploy all the infrastructure for a Redis cluster in AWS using Opsworks and CloudFormation

### Prerequisites

- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html) already configured
- An S3 Bucket created for storing the Cloud Formation templates

### Deployment


Deploy the stack using the scripts on the commands folder or use aws cli commands

1. Sync the cloud formation templates to the S3 bucket

```
$ ./commands/sync.sh
```

2. Create the stack

```
$ ../commands/create.sh
```

#### Parameters of the master Cloud Formation template

- TemplatesBucketName: The S3 bucket name for the CF templates

#### OpsWorks configuration

The OpsWorks layers pull the chef recipes from https://github.com/ronaldour/redis-cluster-chef.git

### Test

#### Replication

- Connect your Redis client to the master and store a value

```
$ redis-cli -h <MASTER_IP>
  6379> Set key value
```

- Connect your Redis client to any slave and check the value

```
$ redis-cli -h <SLAVE_IP>
  6379> Get key
  6379> value
```

#### Failover

- Connect your Redis client to any Slave and check the master ip address

```
$ redis-cli -h <SLAVE_IP>
  6379> info Replication
```

- Disconnect the master node

```
$ redis-cli -h <MASTER_IP>
  6379> DEBUG sleep 90
```

- Check the master ip on any slave again, it should have been changed