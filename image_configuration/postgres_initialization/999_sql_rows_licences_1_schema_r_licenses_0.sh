#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres --dbname licences_1  <<-EOSQL

UPDATE r_licenses.LicenseInformation SET license_type = 'Bus Driver' WHERE personal_id = 7;

EOSQL

