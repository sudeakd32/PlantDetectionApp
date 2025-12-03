# 🌱 PlantDetectionApp

**PlantDetectionApp** is a mobile plant recognition system that combines a **Swift-based iOS application** with a **Python FastAPI backend**, powered by a custom-trained **YOLOv8 classification model**.

The app allows users to capture or upload plant images to identify species, receive botanical information, and visualize related geolocation data on an interactive map.

---

## 📱 Features

### iOS Frontend (Swift / UIKit)
* 📷 **Image Capture:** Capture photos using the camera or select from the gallery.
* 📡 **Smart Upload:** Sends images to the backend using `multipart/form-data`.
* 🌺 **Rich Display:**
    * Identified Plant Name
    * Botanical Summary
    * Plant Image Preview
* 🗺️ **Map Integration:** Clean UIKit interface with **MapKit** to show common growth regions.

### Python Backend (FastAPI)
* 🧠 **AI Powered:** Utilizes a **YOLOv8 classification model** (`yolov8n-cls.pt`).
* ⚡ **FastAPI Endpoint:** Exposes a `/classify` endpoint for efficient image processing.
* 📖 **Wiki Integration:** Processes the image → runs the model → fetches Wikipedia details automatically.
* 🔄 **Structured Output:** Returns a clean JSON response:

```json
{
  "plant_name": "Watermelon",
  "info": "Watermelon is a flowering plant species...",
  "wiki_title": "Watermelon"
} 
 ## 🧠 Tech Stack

Frontend
	•	Swift
	•	UIKit
	•	MapKit
	•	URLSession (multipart upload)

Backend
	•	Python 3.9
	•	FastAPI
	•	Ultralytics YOLOv8
	•	OpenCV
	•	Wikipedia API (via requests)

## 📂 Project Structure

PlantDetectionApp/
│
├── Backend/
│   ├── main.py
│   ├── requirements.txt
│   └── yolov8n-cls.pt
│
├── Frontend/
│   └── PlanDetectionApp/
│       ├── AppDelegate.swift
│       ├── ViewController.swift
│       ├── InfoViewController.swift
│       ├── SceneDelegate.swift
│       ├── Info.plist
│       └── Base.lproj/
│           ├── Main.storyboard
│           └── LaunchScreen.storyboard
│
└── README.md
