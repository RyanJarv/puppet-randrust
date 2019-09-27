# lint:ignore:autoloader_layout
#
# @api private
# @summery For internal mocking only.

class local(
  Hash $config = {},
) {
  notice( 'mocked class ==> randrust::foobar' )
}

include randrust

# lint:endignore
