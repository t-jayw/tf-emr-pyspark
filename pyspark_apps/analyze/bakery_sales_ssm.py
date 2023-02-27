#!/usr/bin/env python3

# Analyze the dataset and output results to CSV and Parquet
# Author: Gary A. Stafford (November 2020)

import os

import boto3
from ec2_metadata import ec2_metadata
from pyspark.sql import SparkSession

os.environ['AWS_DEFAULT_REGION'] = ec2_metadata.region


def main():
    params = get_parameters()

    spark = SparkSession \
        .builder \
        .appName("bakery-sales") \
        .getOrCreate()

    df_bakery = spark.read \
        .format("parquet") \
        .load(f"s3a://tjw-spark-demo-382771737-raw-bucket/bakery/BreadBasket_DMS.csv")

    df_sorted = df_bakery.cube("item").count() \
        .filter("item NOT LIKE 'NONE'") \
        .filter("item NOT LIKE 'Adjustment'") \
        .orderBy(["count", "item"], ascending=[False, True])

    # write parquet
    df_sorted.write.format("parquet") \
        .save(f"s3a://tjw-spark-demo-382771737-raw-bucket/processed/bakery/BreadBasket_DMS.csv", mode="overwrite")

    # write single csv file for use with Excel
    df_sorted.coalesce(1) \
        .write.format("csv") \
        .option("header", "true") \
        .options(delimiter='|') \
        .save(f"s3a://{params['gold_bucket']}/bakery/bakery_sales/csv/", mode="overwrite")


if __name__ == "__main__":
    main()
