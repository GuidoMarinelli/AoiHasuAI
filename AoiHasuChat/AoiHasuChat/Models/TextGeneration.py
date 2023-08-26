from langchain.llms import LlamaCpp
from langchain.prompts import PromptTemplate
from langchain.memory import ConversationBufferMemory, ChatMessageHistory
from langchain.chains import LLMChain

MODEL_PATH = "/Users/guidomarinelli/Developer/AoiHasuAI/AoiHasuChat/AoiHasuChat/Models/llama-2-7b-chat.ggml-model-q4_0.bin"

llama2 = LlamaCpp(model_path=MODEL_PATH,
                  n_threads=8,
                  # sampling
                  last_n_tokens_size=64,
                  repeat_penalty=1.0,
                  top_k=40,
                  top_p=0.95,
                  temperature=0.8,
                  # generate
                  n_ctx=512,
                  n_batch=512,
                  max_tokens=1024,
                  # par add
                  stop=["AI: ", "Human: ", "User: ", "Blue: ", "\n\n", "{user}"],
                  streaming=False
                 )

# Notice that "chat_history" is present in the prompt template
template = """
Transcript of a dialog, where the User interacts with an Assistant named Blue. Blue is helpful, kind, honest,
good at writing, and never fails to answer the User's requests immediately and with precision.

Previous conversation:
{chat_history}

User: {user}
Blue:
"""
prompt = PromptTemplate.from_template(template)


def get_completion(message, retrieved_messages):
    retrieved_chat_history = ChatMessageHistory(messages=retrieved_messages)
    # Notice that we need to align the `memory_key`
    memory = ConversationBufferMemory(memory_key="chat_history", chat_memory=retrieved_chat_history)

    conversation = LLMChain(
        llm=llama2,
        prompt=prompt,
        memory=memory
    )
    
    response = conversation({"user": message})["text"].strip()
    retrieved_messages_for_export = conversation.memory.chat_memory.messages

    return response, retrieved_messages_for_export
