import logging
from fastapi import FastAPI

from lib import validation_handler
from model import ModelLoader

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

app = FastAPI()
model = ModelLoader()

# ALB Target Group Health Check => terraform/alb.tf aws_lb_target_group.target_group
@app.get("/invocations/alb-health")
def health():
    return {"message": "alb target group alive"}

# ECS Container Health Check => terraform/ecs.tf aws_ecs_task_definition.task
@app.get("/invocations/ecs-ping")
def ping():
    return {"message": "ecs container alive"}

@app.post("/invocations")
def invokcations(requestBody:validation_handler.requestBodyModel):

    output = model.predict(requestBody)

    return {
        "body": output
    }
