import google.generativeai as genai
from services.chatconfig import Settings

settings = Settings()


class LLMService:
    def __init__(self):
        genai.configure(api_key=settings.GEMINI_API_KEY)
        self.model = genai.GenerativeModel("gemini-2.0-flash-exp")

    def generate_response(self, query: str):
        try:
            full_prompt = f"""
            You are an advanced assistant designed to provide detailed, accurate, and context-aware responses. 
            Query: {query}
            """
            response = self.model.generate_content(full_prompt, stream=True)

            for chunk in response:
                yield chunk.text
        except Exception as e:
            logger.error(f"Gemini API error: {e}", exc_info=True)
            raise e
