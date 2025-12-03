import urllib.parse
from fastapi import FastAPI, File, UploadFile
from ultralytics import YOLO
import cv2
import numpy as np
import requests

app = FastAPI()

model = YOLO("runs/classify/train2/weights/best.pt")

WIKI_NAME_MAP = {
    "aloevera": "Aloe vera",
    "banana": "Banana",
    "bilimbi": "Bilimbi",
    "cantaloupe": "Cantaloupe",
    "cassava": "Cassava",
    "coconut": "Coconut",
    "corn": "Maize",
    "cucumber": "Cucumber",
    "curcuma": "Turmeric",
    "eggplant": "Eggplant",
    "galangal": "Galangal",
    "ginger": "Ginger",
    "guava": "Guava",
    "kale": "Kale",
    "longbeans": "Yardlong bean",
    "mango": "Mango",
    "melon": "Melon",
    "orange": "Orange",
    "paddy": "Rice",
    "papaya": "Papaya",
    "peper chili": "Chili pepper",
    "pineapple": "Pineapple",
    "pomelo": "Pomelo",
    "shallot": "Shallot",
    "soybeans": "Soybean",
    "spinach": "Spinach",
    "sweet potatoes": "Sweet potato",
    "tobacco": "Tobacco",
    "waterapple": "Water apple",
    "watermelon": "Watermelon"
}

def fetch_plant_info(plant_name: str) -> str:

    lookup_name = WIKI_NAME_MAP.get(plant_name.lower(), plant_name.capitalize())
    encoded = urllib.parse.quote(lookup_name)

    headers = {
        "User-Agent": "PlantInfoApp/1.0 (mailto:example@example.com)"
    }

    summary_url = f"https://en.wikipedia.org/api/rest_v1/page/summary/{encoded}"
    try:
        r1 = requests.get(summary_url, headers=headers, timeout=5)
        if r1.ok:
            data1 = r1.json()
            extract1 = data1.get("extract")
            if extract1:
                return extract1
    except Exception:

        pass

    action_url = (
        "https://en.wikipedia.org/w/api.php"
        f"?action=query&prop=extracts&exintro&explaintext&titles={encoded}&format=json"
    )
    try:
        r2 = requests.get(action_url, headers=headers, timeout=5)
        if r2.ok:
            data2 = r2.json()
            pages = data2.get("query", {}).get("pages", {})
            if pages:
                first_page = next(iter(pages.values()))
                extract2 = first_page.get("extract")
                if extract2:
                    return extract2
    except Exception:
        pass

    return "No information available."


@app.post("/classify")
async def classify_image(file: UploadFile = File(...)):
    image_bytes = await file.read()
    nparr = np.frombuffer(image_bytes, np.uint8)
    img = cv2.imdecode(nparr, cv2.IMREAD_COLOR)

    result = model(img)
    pred_idx = result[0].probs.top1
    plant_name_raw = result[0].names[pred_idx]

    info = fetch_plant_info(plant_name_raw)
    wiki_title = WIKI_NAME_MAP.get(plant_name_raw.lower(), plant_name_raw)

    return {
        "plant_name": plant_name_raw,
        "wiki_title_used": wiki_title,
        "info": info
    }