import panel as pn

from langchain.chains import LLMChain
from langchain.llms import CTransformers
from langchain.prompts import PromptTemplate
from langchain.memory import ConversationBufferMemory

pn.extension(theme='dark')

MODEL_PATH = "./meta_models/llama-2-7b-chat/ggml-model-q4_k_m.gguf"

TEMPLATE = """<s>[INST] You are a friendly chat bot named Blue who's willing to help answer the user:

{chat_history}
Human: {human_input}
AI: [/INST] </s>
"""

CONFIG = {"temperature": 0.5, "max_new_tokens": 256, "context_length": 2048, "stream": True}

memory = ConversationBufferMemory(memory_key="chat_history")


async def callback(contents: str, user: str, instance: pn.chat.ChatInterface):
    prompt = PromptTemplate(
        template=TEMPLATE, input_variables=["chat_history", "human_input"]
    )

    llm = CTransformers(model=MODEL_PATH, model_type="llama2", config=CONFIG, gpu_layers=1)

    llm_chain = LLMChain(llm=llm,
                         prompt=prompt,
                         memory=memory,
                         )
    message = None
    response = await llm_chain.apredict(human_input=contents)
    for chunk in response:
        message = instance.stream(chunk, user="Blue", message=message, avatar="https://upload.wikimedia.org/wikipedia/commons/thumb/0/04/ChatGPT_logo.svg/1024px-ChatGPT_logo.svg.png?20230318122128")


chat_interface = pn.chat.ChatInterface(callback=callback, placeholder_threshold=0.1)
chat_interface.send(
    "Send a message to get a reply from Llama 2!",
    user="System",
    respond=False,
)
chat_interface.servable()
