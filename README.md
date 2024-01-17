## Hydra Hunter (WIP)
![Alt text](.githubContent/HydraHunterLogo.png)

## Overview
Hydra Hunter is a framework designed to simulate backend traffic without the need for a frontend layer. This tool is especially useful for testing complex request sequences that are typically challenging to validate. It automates the process of service setup, execution, and teardown within a Docker environment, streamlining backend testing.

## Motivation
Testing intricate request sequences in backend development can be cumbersome. Hydra Hunter addresses this by providing a simplified, automated way to simulate traffic and analyze the system's response, making it easier to pinpoint and resolve issues.

## Demo:
TODO: Create a gif that will show how this frameworks works

## Features
- **Service Simulation**: Spawns necessary services in Docker using a single Bazel command.
- **Automated Cleanup**: Clears the environment before test execution.
- **Error Analysis**: On a failed request, Hydra Hunter dumps the database state, aiding in quick identification of issues.
- **Extendable Support**: Currently supports the Rust Actix framework and PostgreSQL, with plans for future expansions.

## Prerequisites
- Python (with pytest installed)
- Docker
- Bazel

## Setup Guide
1. Server when is ready for handling request must output to the *stdout* the line: `==HYDRA Notification==: Server is ready for handling requests.`.
This line can be polluted with the timestamps as long as this line will stay intact.
2. Place a `.hydra` configuration file in the directory where the `MODULE.bazel` file is located for a backend/microservice.
3. Configure the `.hydra` file as follows:

```json
{
   "DATABASE": "postgres",
   "DATABASE_PORT": "5432",
   "DATABASE_NAME": "test_database",
   "DATABASE_USER": "TestUser",
   "DATABASE_PASSWORD": "ThisIsSomeDumbPassword69",
   "BACKEND_PORT": 8080,
   "RUN_COMMAND": "cargo run",
   "CLEAR_DATABASE_FLAG": "-c",
   "CUSTOM_FLAGS": "[-d]"
}
```
4. Add A module (I don't know yet how) to your MODULE.bazel file.
5. Create a hydratest folder in the repo, and add __init__.py file to it.
6. Create a testFile (.py file with the word `test` in it.)
7. Write simple test case for `/ping` request:
```python

from ..testing_framework.http_framework import HTTPTestFramework, test_setup

import pytest

@pytest.mark.asyncio
async def test_service_is_up(test_setup):
    client = test_setup.client
    target_start_event = test_setup.target_start_event
# TODO: this waits until server prints "==HYDRA Notification==: Server is ready for handling requests." 
    await target_start_event.wait()

    response = await client.get(HTTPTestFramework.create_normal_request_route("ping"))
    assert response.status_code == 200

```
8. Execute command: `bazel @HydraTest`

# License

MIT License
Copyright (c) 2024 Mateusz
