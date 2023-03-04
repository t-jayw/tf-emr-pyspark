# pyspark_job.py
from pyspark.sql import SparkSession
from pyspark.sql import functions as F

import pkgutil
print([tup[1] for tup in pkgutil.iter_modules()])

import sys
print(sys.path)
print(sys.executable)
import boto3

help('modules')

#ssm_client = boto3.client('ssm', region_name='us-east-1')

def get_params():
    processed_bucket = ssm_client.get_parameter(
        Name='/spark_demo/analyzed_bucket'
    )['Parameter']['Value']

    params = {
        'processed_bucket': processed_bucket
    }

    return params


def create_spark_session():
    spark = SparkSession.builder.appName("foobarbaz").getOrCreate()
    return spark

def main():
    #params = get_params()
    spark = create_spark_session()

if __name__ == '__main__':
    print('lmnop'*100)
    main()
