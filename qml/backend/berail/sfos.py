# -*- coding: utf-8 -*-
"""
Created on Fri Jan  6 19:02:42 2017

@author: Dylan Van Assche
@title: SFOS class 
@description: SFOS class for BeRail to control SFOS device specific stuff.

*   This file is part of BeRail.
*
*   BeRail is free software: you can redistribute it and/or modify
*   it under the terms of the GNU General Public License as published by
*   the Free Software Foundation, either version 3 of the License, or
*   (at your option) any later version.
*
*   Foobar is distributed in the hope that it will be useful,
*   but WITHOUT ANY WARRANTY; without even the implied warranty of
*   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*   GNU General Public License for more details.
*
*   You should have received a copy of the GNU General Public License
*   along with BeRail.  If not, see <http://www.gnu.org/licenses/>.

"""

#BeRail modules
from berail import filemanager, constants, logger
#Python modules
import os
try:
    import pyotherside
except ImportError:
    import sys
    # Allow testing Python backend alone.
    print("PyOtherSide module unavailable!")
    class pyotherside:
        def atexit(*args): pass
        def send(*args): pass
    sys.modules["pyotherside"] = pyotherside()

"""
ConnMan:
    * Read the ConnMan files and report them back
"""        
class _ConnMan(object):
    def __init__(self):
        self._files = ["NetworkState", "NetworkType", "SignalStrength", "NetworkName"]
        logger.log_to_file.debug("Init ConnMan class")
        
    """
    Read the ConnMan network state:
        * Read all the network state files in the connman dir 'Internet'
        * Return the ConnMan network state as a dictionary
    """       
    def read(self):
        connman_data = {}
        for item in self._files:
            myfile = filemanager.File(item, constants.filemanager.extension["NONE"], constants.filemanager.path["CONNMAN"], False)
            connman_data[item] = myfile.read()
            if connman_data[item] and not len(connman_data[item]): #Connman returns empty fileObjects when offline, replace them
                connman_data[item].append("")
        return connman_data

"""
ConnectionManager:
    * Launch Connection Selector Dialog
"""    
class _ConnectionManager(object):
    def __init__(self):
        logger.log_to_file.debug("Init SFOS class")
    
    """
    Launch Sailfish OS Connection Selector Dialog:
        * Run DBus command in terminal to show the connection dialog
    """          
    def launch_connection_dialog(self):
        try:
            os.system("dbus-send --print-reply --type=method_call --dest=com.jolla.lipstick.ConnectionSelector /  com.jolla.lipstick.ConnectionSelectorIf.openConnection string:")
            logger.log_to_file.debug("Connection selector dialog requested via DBUS")
            return True
        except OSError:
            logger.log_to_file.trace("Connection selector dialog error")
            return False
            
    def notify_connection_state(self, status):
        if status:
            pyotherside.send("network", True)
        else:
            pyotherside.send("network", False)
            
class _Asynchronous(object):
    def __init__(self):
        pass
    
    def notify(self, name, progress):
        self._execute_asynchronous_operation(name, progress)
        
    def data(self, name, payload):
        self._execute_asynchronous_operation(name, payload)
        
    def _execute_asynchronous_operation(self, name, data):
        pyotherside.send(name, data)
        
connection_manager = _ConnectionManager()
connman = _ConnMan()
asynchronous = _Asynchronous()