from fastapi import FastAPI
from pydantic import BaseModel
from model import FlanT5

app = FastAPI()

llm = FlanT5()


class Request(BaseModel):
    inputs: str


class Response(BaseModel):
    output: str


@app.post("/generate", response_model=Response)
async def generate(prompt: Request):
    """
    Generate text from the given input text. The model used is `google/flan-t5-large`,
    which can be found [here](<https://huggingface.co/google/flan-t5-large>).
    """
    
    output = llm.generate(prompt.inputs)
    
    return Response(output=output)
