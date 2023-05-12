import json
import csv

# Read JSON data from a file
with open('sbom-spdx-YYYYmmddHHMMSS.json', 'r') as file:
    data = json.load(file)  # Load JSON data directly into 'data' variable

# Extract package names, versions, license concluded, and date created
packages = []
for package in data['packages']:
    name = package['name']
    version = package['versionInfo']
    license_concluded = package['licenseConcluded']
    created = data['creationInfo']['created']
    packages.append([name, version, license_concluded, created])

# Write package names, versions, license concluded, and date created to a CSV file
with open('sbom-spdx-YYYYmmddHHMMSS.csv', 'w', newline='') as csvfile:
    csvwriter = csv.writer(csvfile)
    csvwriter.writerow(['Name', 'Version', 'License Concluded', 'Date Created'])
    csvwriter.writerows(packages)
