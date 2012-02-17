maintainer       "Atalanta Systems Ltd"
maintainer_email "support@atalanta-systems.com"
license          "All rights reserved"
description      "Installs/Configures git"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "2.0.2"
%w{ ubuntu solaris2 centos }.each do |os|
  supports os
end
