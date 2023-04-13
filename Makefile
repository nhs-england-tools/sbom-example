clean:
	rm -rf \
		node_modules \
		cve-scan-*.json \
		sbom-spdx-*.json \

build:
	yarn --frozen-lockfile
