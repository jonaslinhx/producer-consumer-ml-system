from pydantic import (
    BaseModel,
    field_validator,
    PositiveInt,
    constr
)

class requestBodyModel(BaseModel):
    field: str