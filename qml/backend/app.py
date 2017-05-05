# -*- coding: utf-8 -*-
"""
Created on Mon May  1 08:16:57 2017

@author: Dylan Van Assche
@title: App main
@description: Main Python script for BeRail, all the actions are performed from this script.
"""

# Import Sailbook modules
from berail import network, sfos

class _Stations(object):
    def __init__(self):
        pass
    
    def get_info(self): #BeRail 1.X information returned about station
        #return network.connection.send("/stations?alerts=true&format=json&lang=" + language.lang)
        pass
        
class _Liveboard(object):
    def __init__(self):
        pass
    
    def get_liveboard(self, station): #OK
        return network.connection.send("/liveboard/?station=" + station + "&alerts=true&format=json&lang=" + language.lang)
        
class _Route(object):
    def __init__(self):
        pass
    
    def get_route(self, fromStation, toStation, time, date, arriveFromGivenTime=False): #time format: 1403 (14h 3 min) and date format: 010115 (1 jan 2015) OK
        timeSel = "depart" 
        if arriveFromGivenTime:
            timeSel = "arrive"
            
        route = network.connection.send("/connections?to=" + toStation + "&from=" + fromStation + "&date=" + str(date) + "&time=" + str(time) + "&timeSel=" + timeSel + "&alerts=true&format=json&lang=" + language.lang)
        if route: #Valid connection found
            return route["connection"]
        return False
     
class _Vehicle(object): #OK
    def __init__(self):
        pass
    
    def get_vehicle(self, vehicle_id):
        return network.connection.send("/vehicle/?id=" + vehicle_id + "&alerts=true&format=json")
        
class _Connection(object):
    def __init__(self):
        pass
    
    def status(self):
        sfos.asynchronous.notify("network", network.connection.status())
        return network.connection.status()
        
class _Language(object):
    def __init__(self):
        self.lang = "EN"
    
    def set_language(self, new_language):
        self.lang = new_language
        
       
stations = _Stations()
liveboard = _Liveboard()
route = _Route()
vehicle = _Vehicle()
connection = _Connection()
language = _Language()

#print(route.get_route("Vilvoorde", "Mechelen", "1954", "030517"))