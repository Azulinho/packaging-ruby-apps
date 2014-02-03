#!/bin/bas

RUBY_VERSION=1.9.3-p484
RUBY_INSTALL_PATH=/opt/ruby-local-$RUBY_VERSION

TIMESTAMP=$( date +%s) #used for the build version number

#disinfect work areas
BUILD_DIR=$PWD/build
rm -rf $BUILD_DIR
mkdir $BUILD_DIR

INSTALL_DIR=$PWD/install
rm -rf $INSTALL_DIR
mkdir $INSTALL_DIR

OUTPUT_DIR=$PWD/output
rm -rf $OUTPUT_DIR
mkdir $OUTPUT_DIR

#BUILD
RUBY_SERIES=$( echo $RUBY_VERSION | cut -f 1-2 -d "." )
wget -c http://cache.ruby-lang.org/pub/ruby/$RUBY_SERIES/ruby-$RUBY_VERSION.tar.gz
cd $BUILD_DIR
tar xzf ../ruby-$RUBY_VERSION.tar.gz
cd ruby-$RUBY_VERSION
./configure  --prefix $RUBY_INSTALL_PATH   --disable-install-doc --disable-install-rdoc --disable-install-capi
make clean
make  -j 4
make install DESTDIR=$INSTALL_DIR

#Move bundler into its own package
#$INSTALL_DIR/$RUBY_INSTALL_PATH/bin/gem install bundler

cd $INSTALL_DIR
rm -f $INSTALL_DIR/usr/bin/ruby-local-$RUBY_VERSION
mkdir -p $INSTALL_DIR/usr/bin/
ln -s /$RUBY_INSTALL_PATH/bin/ruby usr/bin/ruby-local-$RUBY_VERSION


fpm -s dir  -t rpm -n ruby-local-$RUBY_VERSION -v $TIMESTAMP -C $INSTALL_DIR -p $OUTPUT_DIR .

rm -rf $INSTALL_DIR
rm -rf $BUILD_DIR


