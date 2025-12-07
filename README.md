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

### Python Backend (FastAPI)
* 🧠 **AI Powered:** Utilizes a **YOLOv8 classification model** (`yolov8n-cls.pt`).
* ⚡ **FastAPI Endpoint:** Exposes a `/classify` endpoint for efficient image processing.
* 📖 **Wiki Integration:** Processes the image → runs the model → fetches Wikipedia details automatically.
* 🔄 **Structured Output:** Returns a clean JSON response:

		json:
		{
  			"plant_name": "Watermelon",
  			"info": "Watermelon is a flowering plant species...",
  			"wiki_title": "Watermelon"
		} 

 ## 🧠 Tech Stack

Frontend
	•	Swift
	•	UIKit
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
	│   ├── main.py              # FastAPI application entry point
	│   ├── requirements.txt     # Python dependencies
	│   └── yolov8n-cls.pt       # Trained YOLOv8 model
	│
	├── Frontend/
	│   └── PlantDetectionApp/   # iOS Project Root
	│       ├── AppDelegate.swift
	│       ├── SceneDelegate.swift
	│       ├── ViewController.swift      # Main UI Logic
	│       ├── InfoViewController.swift  # Result Display Logic
	│       ├── Info.plist
	│       └── Base.lproj/
	│           ├── Main.storyboard       # UI Layout
	│           └── LaunchScreen.storyboard
	│
	└── README.md
	
<h3 align="center">📱 Screenshots</h3>

<p align="center">
  <table>
    <tr>
      <td align="center">
        <img src="https://github.com/sudeakd32/PlantDetectionApp/blob/main/screenshots/Ekran%20Resmi%202025-12-02%2011.07.52.png" width="200">
        <br>
        <sub><b>main screen</b></sub>
      </td>
      <td align="center">
        <img src="https://github.com/sudeakd32/PlantDetectionApp/blob/main/screenshots/Ekran%20Resmi%202025-12-02%2011.06.16.png" width="200">
        <br>
        <sub><b>analyzing</b></sub>
      </td>
      <td align="center">
        <img src="https://github.com/sudeakd32/PlantDetectionApp/blob/main/screenshots/Ekran%20Resmi%202025-12-02%2011.06.44.png" width="200">
        <br>
        <sub><b>sample result</b></sub>
      </td>
      <td align="center">
        <img src="https://github.com/sudeakd32/PlantDetectionApp/blob/main/screenshots/Ekran%20Resmi%202025-12-02%2011.07.11.png" width="200">
        <br>
        <sub><b>sample result</b></sub>
      </td>
    </tr>
  </table>
</p>


