# Async/Await Pattern Examples

Practical examples of async patterns in Python with FastAPI and httpx.

## Basic Async Function

```python
import httpx
from typing import Dict

async def fetch_data(url: str) -> Dict:
    """Fetch data from URL."""
    async with httpx.AsyncClient() as client:
        response = await client.get(url)
        response.raise_for_status()
        return response.json()
```

## Parallel Async Calls

```python
import asyncio
from typing import List

async def fetch_all_users() -> List[Dict]:
    """Fetch multiple users in parallel."""
    user_ids = ["user_1", "user_2", "user_3"]

    # Create tasks for parallel execution
    tasks = [fetch_user(user_id) for user_id in user_ids]

    # Wait for all to complete
    users = await asyncio.gather(*tasks)

    return users
```

## Async with Timeout

```python
async def fetch_with_timeout(url: str, timeout: float = 5.0) -> Dict:
    """Fetch data with timeout."""
    try:
        async with httpx.AsyncClient(timeout=timeout) as client:
            response = await client.get(url)
            return response.json()
    except httpx.TimeoutException:
        raise TimeoutError(f"Request to {url} timed out")
```

## Async Database Operations

```python
from typing import Optional

async def get_user(user_id: str, db: AsyncSession) -> Optional[User]:
    """Get user from database."""
    result = await db.execute(
        select(UserModel).where(UserModel.id == user_id)
    )
    return result.scalar_one_or_none()

async def create_user(user: UserCreate, db: AsyncSession) -> User:
    """Create user in database."""
    db_user = UserModel(**user.dict())
    db.add(db_user)
    await db.commit()
    await db.refresh(db_user)
    return db_user
```

## Async Context Manager

```python
class AsyncConnection:
    """Async context manager for connections."""

    async def __aenter__(self):
        """Establish connection."""
        self.conn = await create_connection()
        return self.conn

    async def __aexit__(self, exc_type, exc_val, exc_tb):
        """Close connection."""
        await self.conn.close()

# Usage
async with AsyncConnection() as conn:
    result = await conn.execute(query)
```

## Async Iterator

```python
from typing import AsyncIterator

async def stream_large_dataset() -> AsyncIterator[Dict]:
    """Stream large dataset asynchronously."""
    async with httpx.AsyncClient() as client:
        async with client.stream('GET', url) as response:
            async for chunk in response.aiter_lines():
                if chunk:
                    yield json.loads(chunk)

# Usage
async for item in stream_large_dataset():
    process(item)
```

## Async Error Handling

```python
async def safe_api_call(url: str) -> Optional[Dict]:
    """API call with comprehensive error handling."""
    try:
        async with httpx.AsyncClient() as client:
            response = await client.get(url, timeout=10.0)
            response.raise_for_status()
            return response.json()

    except httpx.HTTPStatusError as e:
        logger.error(f"HTTP error: {e.response.status_code}")
        return None

    except httpx.TimeoutException:
        logger.error(f"Timeout accessing {url}")
        return None

    except Exception as e:
        logger.error(f"Unexpected error: {e}", exc_info=True)
        return None
```

## Async Retry Logic

```python
from tenacity import retry, stop_after_attempt, wait_exponential

@retry(
    stop=stop_after_attempt(3),
    wait=wait_exponential(multiplier=1, min=4, max=10)
)
async def resilient_api_call(url: str) -> Dict:
    """API call with automatic retry."""
    async with httpx.AsyncClient() as client:
        response = await client.get(url)
        response.raise_for_status()
        return response.json()
```

## Async Background Task

```python
import asyncio
from typing import Callable

class AsyncTaskQueue:
    """Async task queue for background jobs."""

    def __init__(self):
        self.tasks: List[asyncio.Task] = []

    def add_task(self, coro: Callable) -> None:
        """Add task to queue."""
        task = asyncio.create_task(coro())
        self.tasks.append(task)

    async def wait_all(self) -> None:
        """Wait for all tasks to complete."""
        await asyncio.gather(*self.tasks)

# Usage
queue = AsyncTaskQueue()
queue.add_task(lambda: send_email(user))
queue.add_task(lambda: update_metrics())
await queue.wait_all()
```

## Async Testing

```python
import pytest

@pytest.mark.asyncio
async def test_fetch_user():
    """Test async user fetch."""
    user = await fetch_user("user_123")
    assert user["id"] == "user_123"
    assert user["email"]

@pytest.mark.asyncio
async def test_parallel_requests():
    """Test parallel async requests."""
    users = await fetch_all_users()
    assert len(users) == 3
```

## Common Mistakes

### Missing Await

```python
# WRONG
async def bad_example():
    result = fetch_data(url)  # Missing await!
    return result

# CORRECT
async def good_example():
    result = await fetch_data(url)
    return result
```

### Blocking I/O in Async

```python
# WRONG
async def bad_example():
    with open('file.txt') as f:  # Blocking I/O!
        content = f.read()
    return content

# CORRECT
import aiofiles

async def good_example():
    async with aiofiles.open('file.txt') as f:
        content = await f.read()
    return content
```

### Not Using AsyncClient

```python
# WRONG
async def bad_example():
    response = requests.get(url)  # Blocking!
    return response.json()

# CORRECT
async def good_example():
    async with httpx.AsyncClient() as client:
        response = await client.get(url)
        return response.json()
```
