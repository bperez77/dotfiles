#-----------------------------------------------------------------------------------------------------------------------
#
# GDB Initialization File
#
# Author:           Brandon Perez <bmperez@alumni.cmu.edu>
# Creation Date:    Monday, October 12, 2015 at 01:26:12 PM EDT
#
# Description:
#   This file is read whenever a GDB sessions starts up, and it initializes and sets the global settings for GDB.
#   Namely, this file sets up GDB command history that is persistent across sessions.
#
#-----------------------------------------------------------------------------------------------------------------------

# Save the command history whenever a GDB session is closed. This enables persistent command history across sessions.
set history save

# Set the file where the GDB command history is saved.
set history filename ~/.gdb_history
