from datetime import timedelta
from typing import Optional

from pydantic import BaseSettings


class Settings(BaseSettings):
    prod: bool = False
    fastapi_log_level: str = "info"

    postgres_uri: str = "vagazine:vagazine@localhost:5432/vagazine"
    postgres_min_pool_size: int = 1
    postgres_max_pool_size: int = 5

    redis_url: str = 'redis://redis:6379'

cfg = Settings()
