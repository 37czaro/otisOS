import sys
import os
import json
from PyQt6.QtGui import QGuiApplication
from PyQt6.QtQml import QQmlApplicationEngine
from PyQt6.QtCore import QUrl, QObject, pyqtProperty

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
ROOT_DIR = os.path.abspath(os.path.join(BASE_DIR, "..", "..", ".."))
SYSTEM_ICONS_DIR = os.path.join(ROOT_DIR, "systemFiles", "icons")
HOMESCREEN_JSON = os.path.join(BASE_DIR, "homescreen.json")

class mainboardManager(QObject):
    def __init__(self):
        super().__init__()
        self._search_icon = os.path.join(SYSTEM_ICONS_DIR, "search.svg")
        self._wifi3_icon = os.path.join(SYSTEM_ICONS_DIR, "wifi_3.svg")
        self._bluetooth_inactive_icon = os.path.join(SYSTEM_ICONS_DIR, "bluetooth_inactive.svg")

    def _format_items(self, raw_list):
        items = []
        for item in raw_list:
            icon_url = ""
            if "icon" in item:
                abs_icon_path = os.path.join(ROOT_DIR, item["icon"])
                icon_url = QUrl.fromLocalFile(abs_icon_path).toString()
            
            items.append({
                "type": item.get("type", "app"),
                "id": item.get("id", ""),
                "name": item.get("name", ""),
                "icon": icon_url,
                "row": item.get("row", 0),
                "col": item.get("col", 0),
                "spanX": item.get("spanX", 1),
                "spanY": item.get("spanY", 1)
            })
        return items

    @pyqtProperty(list)
    def gridItems(self):
        if os.path.exists(HOMESCREEN_JSON):
            try:
                with open(HOMESCREEN_JSON, 'r', encoding='utf-8') as f:
                    data = json.load(f)
                    return self._format_items(data.get("grid", []))
            except Exception as e:
                print(f"Błąd czytania grid: {e}")
        return []

    @pyqtProperty(list)
    def dockItems(self):
        if os.path.exists(HOMESCREEN_JSON):
            try:
                with open(HOMESCREEN_JSON, 'r', encoding='utf-8') as f:
                    data = json.load(f)
                    return self._format_items(data.get("dock", []))
            except Exception as e:
                print(f"Błąd czytania dock: {e}")
        return []

    @pyqtProperty(str)
    def searchIcon(self): return self._search_icon
    @pyqtProperty(str)
    def wifi3Icon(self): return self._wifi3_icon
    @pyqtProperty(str)
    def bluetoothInactiveIcon(self): return self._bluetooth_inactive_icon


app = QGuiApplication(sys.argv)
engine = QQmlApplicationEngine()
manager = mainboardManager()
engine.rootContext().setContextProperty("mainboardManager", manager)
engine.load(QUrl.fromLocalFile(os.path.join(BASE_DIR, "mainboard.qml")))
sys.exit(app.exec())