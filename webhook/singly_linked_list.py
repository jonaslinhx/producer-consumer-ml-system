from typing import Union, Any, Literal

class Node:

    # SinglyLinkedList
    def __init__(self, data, next=None, priority=None):
        self.next: Union[None, Node] = next
        self.data: Any = data
        self.priority: Union[None,int] = priority

class PriorityQueue:
    """
    Singly Linked List Implementation
    User does not provide priority value
    fifo - [new][head]
    lifo - [head][new]
    """

    def __init__(self, mode:Literal['fifo','lifo']='fifo'):
        self.mode: str = mode
        self.head: Union[None, Node] = None
        self.counter = 0
        self.step = -1 if self.mode == 'fifo' else 1

    def enqueue(self, data:Any):

        # No entry in queue
        if not self.head:
            self.head = Node(data, priority=self.counter)
            self.counter += self.step
            return
        
        pointer: Node = self.head
        while pointer.priority > self.counter:

            # Enqueue at the back
            if pointer.next == None:
                pointer.next = Node(data, priority=self.counter) # insert at back
                self.counter += self.step 
                return

            pointer = pointer.next

        # Enqueue at the front
        self.head = Node(data, next=pointer, priority=self.counter)
        self.counter += self.step

    def dequeue(self):
        if not self.head:
            return None
        else:
            data: Any = self.head.data
            self.head: Union[Node,None] = self.head.next
            self.counter -= self.step
            return data  