import asyncio
from fastapi import FastAPI, WebSocket, WebSocketDisconnect
import logging
from services.pydantic_models import ChatBody
from services.gemini import LLMService

# Set up logging
logging.basicConfig(level=logging.DEBUG)
logger = logging.getLogger(__name__)

app = FastAPI()
gemini = LLMService()

@app.websocket("/ws/chat")
async def websocket_chat_endpoint(websocket: WebSocket):
    await websocket.accept()
    logger.info("WebSocket connection established")
    try:
        while True:
            try:
                # Receive JSON data
                data = await websocket.receive_json()
                query = data.get("query")
                if not query:
                    await websocket.send_json({"type": "error", "message": "Missing 'query' in request"})
                    logger.error("Missing 'query' key in payload")
                    continue

                logger.info(f"Received query: {query}")

                # Stream Gemini API responses
                for chunk in gemini.generate_response(query):
                    await asyncio.sleep(0.1)
                    await websocket.send_json({"type": "content", "data": chunk})

            except WebSocketDisconnect:
                logger.warning("WebSocket disconnected")
                break
            except Exception as e:
                logger.error(f"Error in WebSocket handling: {e}", exc_info=True)
                await websocket.send_json({"type": "error", "message": str(e)})
                break
    finally:
        await websocket.close()
        logger.info("WebSocket connection closed")


@app.post("/chat")
def chat_endpoint(body: ChatBody):
    try:
        response = gemini.generate_response(body.query)
        return {"type": "success", "data": list(response)}
    except Exception as e:
        return {"type": "error", "message": str(e)}
