#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres --dbname move_1  <<-EOSQL

CREATE TABLE IF NOT EXISTS move_w.Employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    phone VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS move_w.VehicleTypes (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS move_w.Routes (
    id SERIAL PRIMARY KEY,
    vehicle_type_id INT REFERENCES move_w.VehicleTypes(id),
    start_location VARCHAR(50) NOT NULL,
    end_location VARCHAR(50) NOT NULL,
    distance DECIMAL(10, 2) NOT NULL,
    time DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (vehicle_type_id) REFERENCES move_w.VehicleTypes(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS move_w.Trips (
    id SERIAL PRIMARY KEY,
    route_id INT REFERENCES move_w.Routes(id),
    driver_id INT REFERENCES move_w.Employees(id),
    vehicle_id INT REFERENCES move_w.VehicleTypes(id)
);

CREATE TABLE IF NOT EXISTS move_w.VehicleAssignments (
    id SERIAL PRIMARY KEY,
    trip_id INT REFERENCES move_w.Trips(id),
    vehicle_id INT REFERENCES move_w.VehicleTypes(id)
);

CREATE TABLE IF NOT EXISTS move_w.TripStatus (
    id SERIAL PRIMARY KEY,
    trip_id INT REFERENCES move_w.Trips(id),
    status VARCHAR(50) NOT NULL
);

EOSQL

