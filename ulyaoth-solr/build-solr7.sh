# Set variables.
version=7.0.1

# create build environment.
rpmdev-setuptree

# Download the spec files
wget https://raw.githubusercontent.com/ulyaoth/repository/master/ulyaoth-solr/SPECS/ulyaoth-solr7.spec -O /home/ulyaoth/rpmbuild/SPECS/ulyaoth-solr7.spec
wget https://raw.githubusercontent.com/ulyaoth/repository/master/ulyaoth-solr/SPECS/ulyaoth-solr7-examples.spec -O /home/ulyaoth/rpmbuild/SPECS/ulyaoth-solr7-examples.spec
wget https://raw.githubusercontent.com/ulyaoth/repository/master/ulyaoth-solr/SPECS/ulyaoth-solr7-docs.spec -O /home/ulyaoth/rpmbuild/SPECS/ulyaoth-solr7-docs.spec

# Downloads solr 7 package and prepare for rpm build.
wget http://apache.mirrors.spacedump.net/lucene/solr/$version/solr-$version.tgz
tar xvf solr-$version.tgz
rm -rf /home/ulyaoth/solr-$version/example
rm -rf /home/ulyaoth/solr-$version/docs
rm -rf /home/ulyaoth/solr-$version/bin/init.d
rm -rf /home/ulyaoth/solr-$version/bin/install_solr_service.sh
rm -rf /home/ulyaoth/solr-$version/bin/solr.in.sh
rm -rf /home/ulyaoth/solr-$version/server/resources/log4j.properties
tar cvf solr-$version.tar.gz solr-$version/
mv solr-$version.tar.gz /home/ulyaoth/rpmbuild/SOURCES/

# Install the solr requirements for building the rpm.
if type dnf 2>/dev/null
then
  sudo dnf builddep -y /home/ulyaoth/rpmbuild/SPECS/ulyaoth-solr7.spec
elif type yum 2>/dev/null
then
  sudo yum-builddep -y /home/ulyaoth/rpmbuild/SPECS/ulyaoth-solr7.spec
fi

# Download additional from spec file.
spectool /home/ulyaoth/rpmbuild/SPECS/ulyaoth-solr7.spec -g -R

# Build Solr 7 rpm.
rpmbuild -ba /home/ulyaoth/rpmbuild/SPECS/ulyaoth-solr7.spec

# Clean
rm -rf /home/ulyaoth/rpmbuild/BUILD
rm -rf /home/ulyaoth/rpmbuild/SOURCES
rm -rf /home/ulyaoth/solr
rm -rf /home/ulyaoth/solr-$version

# Downloads solr 7 package and prepare for examples.
rpmdev-setuptree
tar xvf solr-$version.tgz
mv solr-$version solr
mkdir -p /home/ulyaoth/solr-$version
mv /home/ulyaoth/solr/example /home/ulyaoth/solr-$version/
tar cvf solr-$version.tar.gz solr-$version/
mv solr-$version.tar.gz /home/ulyaoth/rpmbuild/SOURCES/

# Build solr 7 examples rpm.
rpmbuild -ba /home/ulyaoth/rpmbuild/SPECS/ulyaoth-solr7-examples.spec

# Clean
rm -rf /home/ulyaoth/rpmbuild/BUILD
rm -rf /home/ulyaoth/rpmbuild/SOURCES
rm -rf /home/ulyaoth/solr
rm -rf /home/ulyaoth/solr-$version

# Downloads solr 7 package and prepare for documentation.
rpmdev-setuptree
tar xvf solr-$version.tgz
mv solr-$version solr
mkdir -p /home/ulyaoth/solr-$version
mv /home/ulyaoth/solr/docs /home/ulyaoth/solr-$version/
tar cvf solr-$version.tar.gz solr-$version/
mv solr-$version.tar.gz /home/ulyaoth/rpmbuild/SOURCES/

# Build Solr 7 Documentation rpm.
rpmbuild -ba /home/ulyaoth/rpmbuild/SPECS/ulyaoth-solr7-docs.spec