#-----------------------------------------------------------------------------------------------------------------------
#
# Bash Tab Completion Settings
#
# Author:           Brandon Perez <bmperez@alumni.cmu.edu>
# Creation Date:    Sunday, September 01, 2019 at 08:06:10 PM PDT
#
# Description:
#
#   This file contains the tab completion settings for a Bash interactive session.
#
#   Tab completion is used in Bash when a user wants to complete some phrase or object that Bash knows about (e.g.
#   finishing a partially typed path). This simply extends the tab completion settings from some additional programs.
#
#-----------------------------------------------------------------------------------------------------------------------


#-----------------------------------------------------------------------------------------------------------------------
# Tab Completion Settings
#-----------------------------------------------------------------------------------------------------------------------


# Setup the Vim Man command from the Vim SuperMan plugin to have the same completion behavior as Man.
complete -o default -o nospace -F _man vman
