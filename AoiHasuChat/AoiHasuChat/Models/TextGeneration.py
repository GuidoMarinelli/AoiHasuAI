from langchain.llms import LlamaCpp
from langchain.prompts import PromptTemplate
from langchain.memory import ConversationBufferWindowMemory, ChatMessageHistory
from langchain.chains import LLMChain

user_name = "Guido"

MODEL_PATH = "/Users/guidomarinelli/Developer/AoiHasuAI/AoiHasuChat/AoiHasuChat/Models/llama-2-7b-chat.ggml-model-q4_0.bin"

llama2 = LlamaCpp(model_path=MODEL_PATH,
                  n_threads=16,
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
                  stop=[f"{user_name}: ", "Blue: "],
                  streaming=False
                  )

# Notice that "chat_history" is present in the prompt template
template = f"""
You are a helpful, respectful and honest assistant named Blue. Always answer as helpfully as possible and never fail to respond to user requests. Remember that your user's name is {user_name}. Respond immediately and accurately. Your answers should not include any harmful, unethical, racist, sexist, toxic, dangerous, or illegal content. Please ensure that your responses are socially unbiased and positive in nature.

If a question does not make any sense, or is not factually coherent, explain why instead of answering something not correct. If you don't know the answer to a question, please don't give false information.

Previous conversation:
{{chat_history}}

{user_name}: {{question}}
Blue:
"""

prompt = PromptTemplate.from_template(template)


def get_completion(message, retrieved_messages):
    retrieved_chat_history = ChatMessageHistory(messages=retrieved_messages)
    # Notice that we need to align the `memory_key`
    memory = ConversationBufferWindowMemory(memory_key="chat_history", chat_memory=retrieved_chat_history, k=3)

    conversation = LLMChain(
        llm=llama2,
        prompt=prompt,
        memory=memory
    )
    
    response = conversation({"question": message})["text"].strip()
    retrieved_messages_for_export = conversation.memory.chat_memory.messages

    return response, retrieved_messages_for_export
