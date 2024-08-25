# syntax=docker/dockerfile:1
FROM --platform=linux/amd64 debian:10 

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
        ca-certificates \
        curl \
        gzip \
	make \
	g++ \
	zlib1g-dev \
        gfortran \
	subversion \
        python-dev \
	nano \
        less && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN url='https://lhapdf.hepforge.org/downloads/?f=LHAPDF-6.5.4.tar.gz' && \
    cd /root && \
    curl -sL "$url" | \
    tar xz && \
    cd 'LHAPDF-6.5.4' && \
    ./configure && \
    make && \
    make install && \
    rm -rf 'LHAPDF-6.5.4'

RUN url='http://lhapdfsets.web.cern.ch/lhapdfsets/current/PDF4LHC21_mc.tar.gz' && \
    cd /usr/local/share/LHAPDF && \
    curl -sL "$url" | \
    tar xz 

RUN cd /root && \
    echo n | svn checkout --username anonymous --password anonymous svn://powhegbox.mib.infn.it/trunk/POWHEG-BOX-V2 && \
    cd POWHEG-BOX-V2 && \
    echo n | svn checkout --username anonymous --password anonymous svn://powhegbox.mib.infn.it/trunk/User-Processes-V2/hvq && \
    cd hvq && \
    make && \
    mv pwhg_main pwhg_main-hvq 

RUN cd /root/POWHEG-BOX-V2 && \
    echo n | svn checkout --username anonymous --password anonymous svn://powhegbox.mib.infn.it/trunk/User-Processes-V2/Z && \
    cd Z && \
    sed -i.bak -e "s/ANALYSIS=default/ANALYSIS=none/" -e "s/^PWHGANAL=pwhg_analysis-dummy.o$/PWHGANAL=pwhg_analysis-dummy.o pwhg_bookhist.o/" Makefile && \
    make && \
    mv pwhg_main pwhg_main-Z

RUN sed -i.bak -e '9s/^#[ ]*//' -e '10,13s/^#[ ]*//' /root/.bashrc

ENV PATH=/root/POWHEG-BOX-V2/hvq:/root/POWHEG-BOX-V2/Z:$PATH
