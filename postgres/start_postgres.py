import os
import json
import uuid


def check_config_file(config):
    assert config["POSTGRESS_PASSWORD"] is not None
    assert config["POSTGRESS_USER"] is not None
    assert config["POSTGRESS_DB"] is not None
    assert config["POSTGRESS_PORT"] is not None
    assert config["network"] is not None


def read_postgres_json_config():
    with open("hydraConfig.json", "r") as f:
        config = json.load(f)
        check_config_file(config)
        return config


def get_name():
    return f"postgres_{uuid.uuid4()}"


# Create docker postgres container
def start_postgres(config):
    os.system(f"docker run --name {get_name()} -e"
              f" POSTGRES_PASSWORD={config['POSTGRESS_PASSWORD']}"
              f"-e POSTGRES_USER={config['POSTGRESS_USER']} "
              f"-e POSTGRES_DB={config['POSTGRESS_DB']} "
              f"-p {config['POSTGRESS_PORT']}:5432 -d postgres")


if __name__ == "__main__":
    config = read_postgres_json_config()
    start_postgres(config)
