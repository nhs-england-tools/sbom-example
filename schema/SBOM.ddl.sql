DROP TABLE IF EXISTS SBOM.SBOM;
CREATE EXTERNAL TABLE SBOM.SBOM (
  name string,
  version string,
  licence_concluded string,
  date_created string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe'
WITH SERDEPROPERTIES (
 'serialization.format' = ',',
 'field.delim' = ','
)
LOCATION 's3://github-nhs-england-tools-sbom-example-bucket/data/'
TBLPROPERTIES ('skip.header.line.count'='1')
;
