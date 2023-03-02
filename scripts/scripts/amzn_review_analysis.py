# pyspark_job.py
from pyspark.sql import SparkSession
from pyspark.sql import functions as F

import boto3

ssm_client = boto3.client('ssm')

def get_params():
	processed_bucket = ssm_client.get_parameter(
		Name='/spark_demo/analyzed_bucket'
	)['Parameter']['Value']
	
	params = {
		'processed_bucket': processed_bucket
	}

	return params




def create_spark_session():
    spark = SparkSession \
        .builder \
        .config("spark.jars.packages",
                "org.apache.hadoop:hadoop-aws:2.7.0") \
        .getOrCreate()
    return spark

def process_book_data(spark, input_path, output_path):
    df = spark.read.parquet(input_path)
    # Apply some basic filters and aggregate by product_title.
    book_agg = df.filter(df.verified_purchase == 'Y') \
        .groupBy('product_title') \
        .agg({'star_rating': 'avg', 'review_id': 'count'}) \
        .filter(F.col('count(review_id)') >= 500) \
        .sort(F.desc('avg(star_rating)')) \
        .select(F.col('product_title').alias('book_title'),
                F.col('count(review_id)').alias('review_count'),
                F.col('avg(star_rating)').alias('review_avg_stars'))
    # Save the data to your S3 bucket as a .parquet file.
    book_agg.write.mode('overwrite')\
        .save(output_path)

def main():
	params = get_params()

    spark = create_spark_session()
    input_path = ('s3://amazon-reviews-pds/parquet/' +
                  'product_category=Books/*.parquet')
    
	output_path = f's3://{params["processed_bucket"]}/amzn_review_analysis/'
    process_book_data(spark, input_path, output_path)

if __name__ == '__main__':
    main()
