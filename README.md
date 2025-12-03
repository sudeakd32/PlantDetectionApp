# 🌱 PlantDetectionApp

A mobile plant recognition system combining a Swift-based iOS application with a Python FastAPI backend powered by a custom-trained YOLOv8 classification model.
The app allows users to capture or upload plant images, identifies the plant species, provides botanical information, and visualizes related geolocation data on an interactive map.

## 📱 Features

iOS Frontend (Swift / UIKit)
	•	Capture or select a plant image
	•	Send image to backend using multipart/form-data
	•	Display:
	•	Plant name
	•	Botanical summary
	•	Plant image preview
	•	Map showing common growth regions
	•	Clean UIKit interface with MapKit integration

Python Backend (FastAPI)
	•	YOLOv8 classification model (yolov8n-cls.pt)
	•	/classify endpoint for image upload
	•	Processes image → runs model → fetches Wikipedia info
	•	Returns structured JSON response:
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
