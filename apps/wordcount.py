from pyspark.sql import SparkSession
from pyspark.sql import functions as F

spark = (SparkSession.builder
         .appName("WordCount-PT")
         .getOrCreate())

text = [
    "Leninha aguenta, mas não perdoa.",
    "Spark distribui trabalho; desigualdade distribui conta.",
    "PySpark é conversa séria com dado grande."
]

df = spark.createDataFrame(text, "string").toDF("line")

words = (df
         .select(F.explode(F.split(F.lower(F.col("line")), r"[^\p{L}]+")).alias("word"))
         .where(F.col("word") != ""))

counts = (words
          .groupBy("word")
          .count()
          .orderBy(F.desc("count"), F.asc("word")))

counts.show(50, truncate=False)
spark.stop()


