name "nexus"
maintainer 'Myroslav Rys'
maintainer_email 'stonevil@gmail.com'
license 'Apache 2.0'
description 'Installs and configures Sonatype Nexus artifactory repository'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '3.0.0'

depends 'yum'
depends 'yum-epel'
depends 'apt'

depends 'java', '~> 1.31.0'
depends 'nginx', '~> 2.7.6'
depends 'artifact', '~> 1.12.2'
