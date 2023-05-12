project-clean:
	rm -rf \
		cve-scan-*.* \
		node_modules \
		sbom-spdx-*.* \
		schema/hive-json-schema \
		yarn-error.log

project-build:
	yarn --frozen-lockfile

sbom-generate:
	syft ./ --output spdx-json=./sbom-spdx-YYYYmmddHHMMSS.json
	grype sbom:./sbom-spdx-YYYYmmddHHMMSS.json --output json --file=./cve-scan-YYYYmmddHHMMSS.json

schema-install-dependencies:
	mkdir -p ./schema/
	cd ./schema/
	rm -rf ./hive-json-schema
	git clone --depth=1 https://github.com/quux00/hive-json-schema.git
	sed -i 's/1.6/1.8/g' ./hive-json-schema/pom.xml

schema-build-dependencies:
	cd ./schema/hive-json-schema
	mvn package

schema-generate:
	cd ./schema/hive-json-schema
	java -cp ./target/json-hive-schema-1.0.jar net.thornydev.JsonHiveSchema ../../sbom-spdx-YYYYmmddHHMMSS.json SBOM > ../SBOM.ddl.sql
	sed -i 's/CREATE TABLE/CREATE EXTERNAL TABLE/g' ../SBOM.ddl.sql
	sed -i 's/;/\nLOCATION ;/g' ../SBOM.ddl.sql
	#java -cp ./target/json-hive-schema-1.0.jar net.thornydev.JsonHiveSchema ../../cve-scan-YYYYmmddHHMMSS.json CVEs > ../CVEs.ddl.sql
	echo "CREATE DATABASE SBOM;" > ../database.ddl.sql

# ==============================================================================

.EXPORT_ALL_VARIABLES:
.NOTPARALLEL:
.ONESHELL:
.PHONY: *
.SHELLFLAGS := -ce
MAKEFLAGS := --no-print-director
SHELL := /bin/bash
