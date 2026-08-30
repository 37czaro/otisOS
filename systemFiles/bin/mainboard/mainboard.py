import sys
import subprocess
import os
import json
from PyQt6.QtGui import QGuiApplication
from PyQt6.QtQml import QQmlApplicationEngine
from PyQt6.QtCore import QUrl, QObject, pyqtProperty

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
ROOT_DIR = os.path.abspath(os.path.join(BASE_DIR, "..", "..", ".."))
SYSTEM_ICONS_DIR = os.path.join(ROOT_DIR, "SystemFiles", "icons")
WALLPAPERS_DIR = os.path.join(ROOT_DIR, "users", "user", "wallpapers")

class mainboardManager(QObject):
    def __init__(self):
        super().__init__()
        self._search_icon = os.path.join(SYSTEM_ICONS_DIR, "search.svg")
        self._wifi3_icon = os.path.join(SYSTEM_ICONS_DIR, "wifi_3.svg")
        self._wifi2_icon = os.path.join(SYSTEM_ICONS_DIR, "wifi_2.svg")
        self._wifi1_icon = os.path.join(SYSTEM_ICONS_DIR, "wifi_1.svg")
        self._wifi0_icon = os.path.join(SYSTEM_ICONS_DIR, "wifi_0.svg")
        self._battery_full_icon = os.path.join(SYSTEM_ICONS_DIR, "battery_full.svg")
        self._battery_half_icon = os.path.join(SYSTEM_ICONS_DIR, "battery_half.svg")
        self._battery_low_icon = os.path.join(SYSTEM_ICONS_DIR, "battery_low.svg")
        self._battery_charging_icon = os.path.join(SYSTEM_ICONS_DIR, "battery_charging.svg")
        self._bluetooth_active_icon = os.path.join(SYSTEM_ICONS_DIR, "bluetooth_active.svg")
        self._bluetooth_inactive_icon = os.path.join(SYSTEM_ICONS_DIR, "bluetooth_inactive.svg")

    @pyqtProperty(str)
    def searchIcon(self):
        return self._search_icon

    @pyqtProperty(str)
    def wifi3Icon(self):
        return self._wifi3_icon

    @pyqtProperty(str)
    def wifi2Icon(self):
        return self._wifi2_icon

    @pyqtProperty(str)
    def wifi1Icon(self):
        return self._wifi1_icon

    @pyqtProperty(str)
    def wifi0Icon(self):
        return self._wifi0_icon

    @pyqtProperty(str)
    def batteryFullIcon(self):
        return self._battery_full_icon

    @pyqtProperty(str)
    def batteryHalfIcon(self):
        return self._battery_half_icon

    @pyqtProperty(str)
    def batteryLowIcon(self):
        return self._battery_low_icon

    @pyqtProperty(str)
    def batteryChargingIcon(self):
        return self._battery_charging_icon

    @pyqtProperty(str)
    def bluetoothActiveIcon(self):
        return self._bluetooth_active_icon

    @pyqtProperty(str)
    def bluetoothInactiveIcon(self):
        return self._bluetooth_inactive_icon


app = QGuiApplication(sys.argv)
engine = QQmlApplicationEngine()

manager = mainboardManager()
engine.rootContext().setContextProperty("mainboardManager", manager)

engine.load(QUrl.fromLocalFile(os.path.join(BASE_DIR, "mainboard.qml")))

sys.exit(app.exec())