#
# Copyright 2015 Altmetric LLP
#
# All Rights Reserved.
#

name "backup"
maintainer "Altmetric LLP"
homepage "https://github.com/altmetric/omnibus-backup"

# Defaults to C:/backup on Windows
# and /opt/backup on all other platforms
install_dir "#{default_root}/#{name}"

build_version do
  source :version, from_dependency: 'backup'
end

build_iteration 2

override :ruby, version: '1.9.3-p550'

dependency "preparation"
dependency "backup"
dependency "shebang-cleanup"
dependency "version-manifest"

exclude "**/.git"
exclude "**/bundler/git"
