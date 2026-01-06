#!/bin/bash

sudo apt update
sudo apt install -y curl gnupg lsb-release

curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | \
  sudo gpg --dearmor -o /usr/share/keyrings/postgresql-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/postgresql-keyring.gpg] http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" | \
  sudo tee /etc/apt/sources.list.d/pgdg.list > /dev/null

sudo apt update
sudo apt install -y postgresql-client-15