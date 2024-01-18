from fastapi import FastAPI
from pydantic import BaseModel
import logging

from singly_linked_list import PriorityQueue

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

class RequestModel(BaseModel):
    name: str
    age: int

webhook = FastAPI()
fifo_queue = PriorityQueue(mode="fifo")

@webhook.post("/webhook_listener")
def listen(payload: RequestModel):
    logger.info(f"payload type: {type(payload)}")
    logger.info(payload)
    fifo_queue.enqueue(payload)
    return {"statusCode": 200}

@webhook.get("/webhook_count")
def count():
    return {"count": abs(fifo_queue.counter)}

@webhook.get("/webhook_poll")
def poll():
    return fifo_queue.dequeue()