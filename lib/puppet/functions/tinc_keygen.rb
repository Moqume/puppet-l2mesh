# This is an autogenerated function, ported from the original legacy version.
# It /should work/ as is, but will not have all the benefits of the modern
# function API. You should see the function docs to learn how to add function
# signatures for type safety and to document this function using puppet-strings.
#
# https://puppet.com/docs/puppet/latest/custom_functions_ruby.html
#
# ---- original file header ----
#
#    Copyright (C) 2012 eNovance <licensing@enovance.com>
#	
#    Author: Loic Dachary <loic@dachary.org>
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU Affero General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU Affero General Public License for more details.
#
#    You should have received a copy of the GNU Affero General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
# ---- original file header ----
#
# @summary
#   Returns an array containing the tinc private and public (in this order) key.
#
Puppet::Functions.create_function(:'tinc_keygen') do
  # @param args
  #   The original array of arguments. Port this to individually managed params
  #   to get the full benefit of the modern function API.
  #
  # @return [Data type]
  #   Describe what the function returns here
  #
  dispatch :default_impl do
    # Call the method named 'default_impl' when this is matched
    # Port this to match individual params for better type safety
    repeated_param 'Any', :args
  end


  def default_impl(*args)
    
  raise Puppet::ParseError, "There must be exactly one argument, the directory in which keys are created" if args.to_a.length != 1
  dir = args.to_a[0]
  ::FileUtils.mkdir_p(dir)
  private_key_path = File.join(dir, "rsa_key.priv")
  public_key_path = File.join(dir, "rsa_key.pub")
  if ! File.exists?(private_key_path) || ! File.exists?(public_key_path)
    output = Puppet::Util.execute(['/usr/sbin/tincd', '--config', dir, '--generate-keys'])
    raise Puppet::ParseError, "/usr/sbin/tincd --config #{dir} --generate-keys output does not match the 'Generating .* bits keys' regular expression. #{output}" unless output =~ /Generating .* bits keys/
  end
  [ File.read(private_key_path), File.read(public_key_path) ]

  end
end