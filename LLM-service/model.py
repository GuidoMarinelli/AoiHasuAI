from transformers import AutoModelForSeq2SeqLM, AutoTokenizer


class FlanT5:
    """Goggle flan-t5-large."""

    def __init__(self):
        self.model_name = "google/flan-t5-large"
        self.model = AutoModelForSeq2SeqLM.from_pretrained(self.model_name)
        self.tokenizer = AutoTokenizer.from_pretrained(self.model_name, use_fast=True)

    def generate(self, prompt: str) -> str:
        """Generate text from the given input text."""

        inputs = self.tokenizer(prompt, return_tensors='pt')
        output = self.tokenizer.decode(
            self.model.generate(
                inputs["input_ids"],
                max_new_tokens=50,
            )[0],
            skip_special_tokens=True
        )

        return output
