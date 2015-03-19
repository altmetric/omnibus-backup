#
# Copyright 2015 Altmetric LLP
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# These options are required for all software definitions
name "backup"
default_version "3.11.0"

dependency "ruby"
dependency "rubygems"
dependency "libxml2"
dependency "libxslt"
dependency "libiconv"
dependency "liblzma"
dependency "zlib"

build do
  env = with_standard_compiler_flags(with_embedded_path)

  # Ensure that Nokogiri links to libraries inside the bundle
  gem "install nokogiri --version '1.5.10' --no-ri --no-rdoc --" \
    " --with-xml2-lib=#{install_dir}/embedded/lib" \
    " --with-xml2-include=#{install_dir}/embedded/include/libxml2" \
    " --with-xslt-lib=#{install_dir}/embedded/lib" \
    " --with-xslt-include=#{install_dir}/embedded/include/libxslt" \
    " --with-iconv-dir=#{install_dir}/embedded" \
    " --with-zlib-dir=#{install_dir}/embedded", env: env

  gem "install backup -n #{install_dir}/bin" \
    " --version '#{version}' --no-ri --no-rdoc", env: env

  # Clean up
  delete "#{install_dir}/embedded/docs"
  delete "#{install_dir}/embedded/share/man"
  delete "#{install_dir}/embedded/share/doc"
  delete "#{install_dir}/embedded/share/gtk-doc"
  delete "#{install_dir}/embedded/ssl/man"
  delete "#{install_dir}/embedded/man"
  delete "#{install_dir}/embedded/info"
end
