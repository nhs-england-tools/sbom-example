clean:
	rm -rf \
		cve-scan-*.json \
		node_modules \
		sbom-spdx-*.json \
		yarn-error.log

build:
	yarn --frozen-lockfile
