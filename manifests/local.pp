# lint:ignore:autoloader_layout

# This file is only used for testing purposes

##################################################
#### MOCK CLASSES WHICH SHOULD NOT TESTED HERE
class local(
  Hash $config = {},
) {
  notice( 'mocked class ==> randrust::foobar' )
}

# INCLUDE THE CLASS
include randrust

# lint:endignore
