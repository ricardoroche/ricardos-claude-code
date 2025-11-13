---
description: Create a new FastAPI endpoint with validation, error handling, and best practices
---

Create a complete FastAPI endpoint following these guidelines:

## Endpoint Structure

1. **Define Pydantic Models:**
   - Request model with proper validation
   - Response model with type hints
   - Use Field() for descriptions and validation rules

2. **Implement Endpoint:**
   - Use proper HTTP method (GET, POST, PUT, DELETE)
   - Add route with clear path
   - Include operation_id and tags
   - Add response_model to endpoint decorator

3. **Error Handling:**
   - Use HTTPException for errors
   - Return proper status codes
   - Include descriptive error messages
   - Handle edge cases

4. **Documentation:**
   - Add docstring explaining purpose
   - Document parameters and returns
   - Include example requests/responses

5. **Type Safety:**
   - Full type hints on all parameters
   - No `any` types
   - Strict Pydantic validation

## Example Template:

```python
from fastapi import APIRouter, HTTPException, status
from pydantic import BaseModel, Field

router = APIRouter(prefix="/api/v1", tags=["example"])

class ExampleRequest(BaseModel):
    """Request model for example endpoint."""
    field_name: str = Field(..., description="Description of field")
    optional_field: str | None = Field(None, description="Optional field")

class ExampleResponse(BaseModel):
    """Response model for example endpoint."""
    result: str
    status: str

@router.post(
    "/example",
    response_model=ExampleResponse,
    status_code=status.HTTP_200_OK,
    operation_id="create_example",
)
async def create_example(request: ExampleRequest) -> ExampleResponse:
    """
    Create example resource.

    Args:
        request: Example request data

    Returns:
        ExampleResponse with result

    Raises:
        HTTPException: If validation fails
    """
    try:
        # Implementation here
        return ExampleResponse(
            result="success",
            status="completed"
        )
    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Failed to process request: {str(e)}"
        )
```

**Usage:**
```bash
/api
# Then describe the endpoint you want to create
```

**Best for:**
- Creating new API routes
- Adding endpoints to existing routers
- Scaffolding CRUD operations
