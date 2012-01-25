Summary: Nexus Class Library build for iPlant
Name: iplant-ncl
Version: 2.1.14
Release: 3
Epoch: 0
Group: Applications/System
BuildRoot: %{_tmppath}/%{name}-%{version}-buildroot
License: GPL
Provides: iplant-ncl
BuildRequires: gcc-c++
BuildRequires: gcc

Source0: iplant-ncl-2.1.14.tar.gz

%description
Nexus Class Library build for iPlant

%prep
%setup -q

%build
CXXFLAGS=-m64 ./configure --prefix=$RPM_BUILD_ROOT/usr/local
make

%install
make install prefix=$RPM_BUILD_ROOT/usr/local

%clean
rm -rf $RPM_BUILD_ROOT

%files
/usr/local/bin/NCLconverter
/usr/local/bin/NEXUSnormalizer
/usr/local/bin/NEXUSvalidator
/usr/local/include/ncl/ncl.h
/usr/local/include/ncl/nxsallocatematrix.h
/usr/local/include/ncl/nxsassumptionsblock.h
/usr/local/include/ncl/nxsblock.cpp
/usr/local/include/ncl/nxsblock.h
/usr/local/include/ncl/nxscdiscretematrix.h
/usr/local/include/ncl/nxscharactersblock.h
/usr/local/include/ncl/nxscxxdiscretematrix.h
/usr/local/include/ncl/nxsdatablock.h
/usr/local/include/ncl/nxsdefs.h
/usr/local/include/ncl/nxsdiscretedatum.h
/usr/local/include/ncl/nxsdistancedatum.h
/usr/local/include/ncl/nxsdistancesblock.h
/usr/local/include/ncl/nxsexception.h
/usr/local/include/ncl/nxsmultiformat.h
/usr/local/include/ncl/nxspublicblocks.h
/usr/local/include/ncl/nxsreader.h
/usr/local/include/ncl/nxssetreader.h
/usr/local/include/ncl/nxsstring.h
/usr/local/include/ncl/nxstaxablock.h
/usr/local/include/ncl/nxstoken.h
/usr/local/include/ncl/nxstreesblock.h
/usr/local/include/ncl/nxsunalignedblock.h
/usr/local/include/ncl/nxsutilcopy.h
/usr/local/lib/ncl/libncl.so
/usr/local/lib/ncl/libncl-2.1.14.so
/usr/local/lib/ncl/libncl.a
/usr/local/lib/ncl/libncl.la
/usr/local/lib/pkgconfig/nclv2.1.pc
