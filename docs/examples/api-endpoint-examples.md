# API Endpoint Examples

Practical examples of FastAPI endpoint implementations with Pydantic models, validation, and error handling.

## Basic CRUD Endpoint

```python
from fastapi import APIRouter, Depends, HTTPException, status
from pydantic import BaseModel, Field
from typing import List, Optional
from datetime import datetime

router = APIRouter(prefix="/api/v1/users", tags=["users"])

# Models
class UserCreate(BaseModel):
    """User creation request."""
    email: EmailStr
    name: str = Field(..., min_length=1, max_length=100)
    age: Optional[int] = Field(None, ge=0, le=150)

class UserResponse(BaseModel):
    """User response."""
    id: str
    email: str
    name: str
    age: Optional[int]
    created_at: datetime

# Endpoints
@router.post("/", response_model=UserResponse, status_code=status.HTTP_201_CREATED)
async def create_user(
    user: UserCreate,
    db: DbDep
) -> UserResponse:
    """Create a new user."""
    # Implementation
    pass

@router.get("/{user_id}", response_model=UserResponse)
async def get_user(
    user_id: str,
    db: DbDep
) -> UserResponse:
    """Get user by ID."""
    user = await db.get_user(user_id)
    if not user:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="User not found"
        )
    return user

@router.get("/", response_model=List[UserResponse])
async def list_users(
    skip: int = 0,
    limit: int = 100,
    db: DbDep
) -> List[UserResponse]:
    """List users with pagination."""
    return await db.list_users(skip=skip, limit=limit)

@router.patch("/{user_id}", response_model=UserResponse)
async def update_user(
    user_id: str,
    update: UserUpdate,
    db: DbDep
) -> UserResponse:
    """Update user."""
    pass

@router.delete("/{user_id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_user(
    user_id: str,
    db: DbDep
):
    """Delete user."""
    pass
```

## Payment Processing Endpoint

```python
from decimal import Decimal
from pydantic import field_validator

class PaymentRequest(BaseModel):
    """Payment creation request."""

    amount: Decimal = Field(
        ...,
        gt=0,
        decimal_places=2,
        description="Payment amount in USD"
    )
    currency: str = Field(
        default="USD",
        pattern="^[A-Z]{3}$"
    )
    payment_method_id: str
    description: Optional[str] = Field(None, max_length=500)

    @field_validator('amount')
    @classmethod
    def validate_amount(cls, v: Decimal) -> Decimal:
        if v > Decimal("10000"):
            raise ValueError("Amount exceeds maximum")
        return v.quantize(Decimal("0.01"))

@router.post("/payments", response_model=PaymentResponse)
async def create_payment(
    payment: PaymentRequest,
    current_user: User = Depends(get_current_user),
    service: PaymentServiceDep
) -> PaymentResponse:
    """Create a payment."""
    try:
        return await service.create_payment(payment, current_user.id)
    except InsufficientFundsError:
        raise HTTPException(
            status_code=status.HTTP_402_PAYMENT_REQUIRED,
            detail="Insufficient funds"
        )
    except PaymentError as e:
        logger.error(f"Payment failed: {e}", exc_info=True)
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Payment processing failed"
        )
```

## File Upload Endpoint

```python
from fastapi import File, UploadFile

@router.post("/upload")
async def upload_file(
    file: UploadFile = File(...),
    description: Optional[str] = None
):
    """Upload a file."""
    # Validate file type
    if file.content_type not in ["image/jpeg", "image/png", "application/pdf"]:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Invalid file type"
        )

    # Validate file size (max 10MB)
    contents = await file.read()
    if len(contents) > 10 * 1024 * 1024:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="File too large"
        )

    # Process file
    file_id = await storage.save(contents, file.filename)

    return {
        "file_id": file_id,
        "filename": file.filename,
        "content_type": file.content_type,
        "size": len(contents)
    }
```

## Search Endpoint with Filters

```python
class SearchFilters(BaseModel):
    """Search filters."""
    query: Optional[str] = None
    min_price: Optional[Decimal] = Field(None, ge=0)
    max_price: Optional[Decimal] = Field(None, ge=0)
    category: Optional[str] = None
    sort_by: str = Field(default="created_at", pattern="^(created_at|price|name)$")
    sort_order: str = Field(default="desc", pattern="^(asc|desc)$")

@router.get("/products/search", response_model=List[ProductResponse])
async def search_products(
    filters: SearchFilters = Depends(),
    skip: int = 0,
    limit: int = 100
) -> List[ProductResponse]:
    """Search products with filters."""
    return await product_service.search(
        query=filters.query,
        min_price=filters.min_price,
        max_price=filters.max_price,
        category=filters.category,
        sort_by=filters.sort_by,
        sort_order=filters.sort_order,
        skip=skip,
        limit=limit
    )
```

## Batch Operations Endpoint

```python
class BatchCreateRequest(BaseModel):
    """Batch creation request."""
    items: List[ItemCreate] = Field(..., min_length=1, max_length=100)

class BatchCreateResponse(BaseModel):
    """Batch creation response."""
    created: List[ItemResponse]
    failed: List[dict]

@router.post("/items/batch", response_model=BatchCreateResponse)
async def batch_create_items(
    request: BatchCreateRequest,
    db: DbDep
) -> BatchCreateResponse:
    """Create multiple items in batch."""
    created = []
    failed = []

    for idx, item in enumerate(request.items):
        try:
            result = await db.create_item(item)
            created.append(result)
        except Exception as e:
            failed.append({
                "index": idx,
                "item": item.dict(),
                "error": str(e)
            })

    return BatchCreateResponse(created=created, failed=failed)
```

## WebSocket Endpoint

```python
from fastapi import WebSocket, WebSocketDisconnect

@app.websocket("/ws/{client_id}")
async def websocket_endpoint(websocket: WebSocket, client_id: str):
    """WebSocket endpoint for real-time updates."""
    await websocket.accept()

    try:
        while True:
            # Receive message
            data = await websocket.receive_text()

            # Process message
            response = await process_message(data, client_id)

            # Send response
            await websocket.send_json(response)

    except WebSocketDisconnect:
        logger.info(f"Client {client_id} disconnected")
```

## Async Background Task Endpoint

```python
from fastapi import BackgroundTasks

def process_report(report_id: str, email: str):
    """Generate and email report (background task)."""
    report = generate_report(report_id)
    send_email(email, report)

@router.post("/reports")
async def create_report(
    request: ReportRequest,
    background_tasks: BackgroundTasks,
    current_user: User = Depends(get_current_user)
):
    """Create report and send via email."""
    report_id = str(uuid.uuid4())

    # Queue background task
    background_tasks.add_task(
        process_report,
        report_id,
        current_user.email
    )

    return {
        "report_id": report_id,
        "status": "processing",
        "message": "Report will be emailed when ready"
    }
```
