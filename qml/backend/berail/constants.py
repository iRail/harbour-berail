# -*- coding: utf-8 -*-
"""
Created on Mon May  1 08:16:57 2017

@author: Dylan Van Assche
@title: Constants
@description: All constants used in BeRail.

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

#Python modules
import os


class _IRail(object):
    def __init__(self):
        self.HOST = "https://api.irail.be"

"""
HTTP: 
    * TYPE -> Type of HTTP request used by network.send()
    * SUCCESS -> HTTP CODES for a succesfull request
    * REDIRECTION -> HTTP CODES for a redirect request
    * CLIENT_ERROR -> HTTP CODES for a failed request client side
    * SERVER_ERROR -> HTTP CODES for a failed request server side
"""
class _HTTP(object):
    def __init__(self):
        self.TYPE = {"POST":0, "GET":1, "PUT":2, "DELETE": 3, "HEAD": 4}
        self.TEST = {"IPV4": "http://ipv4.jolla.com", "IPV6": "http://ipv6.jolla.com"}
        self.SUCCESS = {"OK":200, "CREATED":201, "NO_CONTENT":204, "RESET_CONTENT":205, "PARTIAL_CONTENT":206, "MULTI_STATUS":207, "ALREADY_REPORTED":208, "IM_USED":226}
        self.REDIRECTION = {"MULTIPLE_CHOICES":300, "MOVED_PERMANENTLY":301, "FOUND":302, "NOT_MODIFIED":304, "PERMANENT_REDIRECT":308}
        self.CLIENT_ERROR = {"BAD_REQUEST":400, "UNAUTHORIZED":401, "PAYMENT_REQUIRED":402, "FORBIDDEN":403, "NOT_FOUND":404, "METHOD_NOT_ALLOWED":405, "NOT_ACCEPTABLE":406, "PROXY_AUTHENTICATION_REQUIRED":407, "REQUEST_TIME_OUT":408, "CONFLICT":409, "GONE":410, "LENGTH_REQUIRED":411, "PRECONDITION_FAILED":412, "PAYLOAD_TO_LARGE":413, "URI_TOO_LONG":414,"UNSUPPORTED_MEDIA_TYPE":415, "RANGE_NOT_STATISFABLE":416, "EXPECTATION_FAILED":417, "MISDIRECTED_REQUEST":421, "UNPROCESSABLE_ENTITY":422, "LOCKED":423, "FAILED_DEPENDENCY":424, "UPGRADE_REQUIRED":426, "PRECONDITION_REQUIRED":428, "TOO_MANY_REQUESTS":429, "REQUEST_HEADER_FIELDS_TOO_LARGE":431, "UNAVAILABLE_FOR_LEGAL_REASONS":451}
        self.SERVER_ERROR = {"INTERNAL_SERVER_ERROR":500, "NOT_IMPLENTED":501, "BAD_GATEWAY":502, "SERVICE_UNAVAILABLE":503, "GATEWAY_TIME_OUT":504, "HTTP_VERSION_NOT_SUPPORTED":505, "VARIANT_ALSO_NEGOTIATES":506, "INSUFFICIENT_STORAGE":507, "LOOP_DETECTED":508, "NOT_EXTENDED":510, "NETWORK_AUTHENTICATION_REQUIRED":511}

"""
FileManager:
    * JSON -> Filemanager how to handle serialized JSON data
    * IMAGE -> Filemanager how to handle image PNG data
"""              
class _FileManager(object):
    def __init__(self):
        self.home = os.path.expanduser("~")
        self.cache_dirs = ["logging"]
        self.operation = {"READ":"r", "READ_BINARY":"rb", "WRITE":"w", "WRITE_BINARY":"wb", "APPEND":"a", "APPEND_BINARY":"ab", "REMOVE":0, "CREATE":1}
        self.extension = {"JSON": ".json", "JPG":".jpg", "LOG":".log", "GIF":".gif", "NONE":""}
        self.path = {"XDG_CONFIG_HOME": self.home + "/.config/harbour-berail", "XDG_DATA_HOME": self.home + "/.local/share/harbour-berail", "XDG_CACHE_HOME": self.home + "/.cache/harbour-berail", "CONNMAN":"/run/state/providers/connman/Internet", "LOG": self.home + "/.cache/harbour-berail/logging"}
        self.age = {"30_MIN":1800, "60_MIN":3600, "90_MIN":5400, "7_DAYS":604800}

"""
BeRail:
    * name -> name of the application
    * version -> version of the application
    * headers -> headers to show when we request data from the IRail API
"""   
class _Berail(object):
    def __init__(self):
        self.name = "harbour-berail"
        self.version = "1.0-1"
        self.agent = "BeRail/" + self.version +  " Sailfish OS/2.1"

filemanager = _FileManager()
berail = _Berail()
irail =_IRail()
http = _HTTP()