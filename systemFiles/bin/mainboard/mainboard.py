import sys
import subprocess
import os
import json
from PyQt6.QtGui import QGuiApplication
from PyQt6.QtQml import QQmlApplicationEngine
from PyQt6.QtCore import QUrl

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
ROOT_DIR = os.path.abspath(os.path.join(BASE_DIR, "..", "..", ".."))
SYSTEM_ICONS_DIR = os.path.join(ROOT_DIR, "SystemFiles", "icons")
WALLPAPERS_DIR = os.path.join(ROOT_DIR, "users", "user", "wallpapers")
app = QGuiApplication(sys.argv)
engine = QQmlApplicationEngine()
engine.load(QUrl("mainboard.qml"))

class AppManager(QObject):
    def __init__(self):
        super().__init__()
        self.search_icon = os.path.join(SYSTEM_ICONS_DIR, "search.svg")
        self.wifi4_icon = os.path.join(SYSTEM_ICONS_DIR, "wifi4.svg")
        self.wifi3_icon = os.path.join(SYSTEM_ICONS_DIR, "wifi3.svg")
        self.wifi2_icon = os.path.join(SYSTEM_ICONS_DIR, "wifi2.svg")
        self.wifi1_icon = os.path.join(SYSTEM_ICONS_DIR, "wifi1.svg")
        self.wifi0_icon = os.path.join(SYSTEM_ICONS_DIR, "wifi0.svg")
        self.battery_full_icon = os.path.join(SYSTEM_ICONS_DIR, "battery_full.svg")
        self.battery_half_icon = os.path.join(SYSTEM_ICONS_DIR, "battery_half.svg")
        self.battery_low_icon = os.path.join(SYSTEM_ICONS_DIR, "battery_low.svg")
        self.battery_charging_icon = os.path.join(SYSTEM_ICONS_DIR, "battery_charging.svg")
        self.bluetooth_active_icon = os.path.join(SYSTEM_ICONS_DIR, "bluetooth_active.svg")
        self.bluetooth_inactive_icon = os.path.join(SYSTEM_ICONS_DIR, "bluetooth_inactive.svg")

sys.exit(app.exec())