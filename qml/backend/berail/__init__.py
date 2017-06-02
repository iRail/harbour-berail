"""
Created on Fri Jan  6 19:02:42 2017

@author: Dylan Van Assche
@title: Init module
@description: Init BeRail module

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
from berail import logger, filemanager, constants

#Init our cache directories
for directory in constants.filemanager.cache_dirs:
    current_dir = filemanager.Directory(directory, constants.filemanager.path["XDG_CACHE_HOME"])
    current_dir.create()
