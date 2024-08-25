# syntax=docker/dockerfile:1
FROM debian:12

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
        # need this so that curl can connect via https
        ca-certificates \
        curl \
        gzip \
        make \
        g++ \
        rsync \
        python3 \ 
        python3-dev \
        python3-pip \
        python3-six \
        python3-full \
        less \
        vim \
        cmake \ 
	texlive-latex-recommended \
	texlive-latex-extra \
	texlive-pstricks \
	texlive-fonts-recommended \
        ghostscript \
	imagemagick \
        gfortran \
	subversion && \ 
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN url='https://gitlab.cern.ch/hepmc/HepMC3/-/archive/3.2.7/HepMC3-3.2.7.tar.gz' && \
    cd /root && \
    curl -sL "$url" | \
    tar xz && \
    cd 'HepMC3-3.2.7' && \
    cmake . -DHEPMC3_ENABLE_ROOTIO=NO  && \
    make && \
    make install && \
    cd - && \
    rm -rf 'HepMC3-3.2.7'

RUN url='https://fastjet.fr/repo/fastjet-3.4.3.tar.gz' && \
    cd /root && \
    curl -sL "$url" | \
    tar xz && \
    cd 'fastjet-3.4.3' && \
    ./configure --enable-pyext --enable-allcxxplugins && \
    make && \
    make install && \
    cd - && \
    rm -rf 'fastjet-3.4.3'

RUN url='http://fastjet.hepforge.org/contrib/downloads/fjcontrib-1.055.tar.gz' && \
    cd /root && \
    curl -sL "$url" | \
    tar xz && \
    cd 'fjcontrib-1.055' && \
    ./configure && \
    make && \
    make install && \
    make fragile-shared-install && \
    cd - && \ 
    rm -rf 'fjcontrib-1.055'

RUN url='https://yoda.hepforge.org/downloads?f=YODA-1.9.9.tar.gz' && \
    cd /root && \
    curl -sL "$url" | \
    tar xz && \
    cd 'YODA-1.9.9' && \
    PYTHON_VERSION=3 ./configure --disable-root && \
    make && \
    make install && \
    cd - && \
    rm -rf 'YODA-1.9.9'

RUN url='https://lhapdf.hepforge.org/downloads/?f=LHAPDF-6.5.4.tar.gz' && \
    cd /root && \
    curl -sL "$url" | \
    tar xz && \
    cd 'LHAPDF-6.5.4' && \
    PYTHON_VERSION=3 ./configure && \
    make && \
    make install && \
    /usr/bin/mkdir -p /usr/local/lib/python3.11/dist-packages/ && \
    cp -r /root/LHAPDF-6.5.4/wrappers/python/build/lhapdf /usr/local/lib/python3.11/dist-packages/ && \
    cd - && \
    rm -rf 'LHAPDF-6.5.4'

RUN url='https://rivet.hepforge.org/downloads/?f=Rivet-3.1.8.tar.gz' && \
    cd /root && \
    curl -sL "$url" | \
    tar xz && \
    cd 'Rivet-3.1.8' && \
    ./configure --with-hepmc3=`HepMC3-config --prefix` && \
    make && \
    make install && \
    cd - && \
    rm -rf 'Rivet-3.1.8'

RUN url='https://launchpad.net/mg5amcnlo/3.0/3.5.x/+download/MG5_aMC_v3.5.5.tar.gz' && \
    cd /root && \
    curl -sL "$url" | \
    tar xz 

RUN url='https://pythia.org/download/pythia83/pythia8312.tgz' && \
    cd /root && \
    curl -sL "$url" | \
    tar xz && \
    cd 'pythia8312' && \
    ./configure --prefix=/usr/local --with-python --with-python-include=/usr/include/python3.11 --with-hepmc3 --with-lhapdf6 --with-rivet --with-gzip && \
    make && \
    make install && \
    cd - && \
    rm -rf 'pythia8312'

RUN ln -s /usr/bin/python3 /usr/bin/python

RUN sed -i.bak -e '97d' /etc/ImageMagick-6/policy.xml

RUN lhapdf install NNPDF23_lo_as_0130_qed

RUN cd /root && \
    echo n | svn checkout --username anonymous --password anonymous svn://powhegbox.mib.infn.it/trunk/POWHEG-BOX-V2 && \
    cd POWHEG-BOX-RES && \
    echo n | svn checkout --username anonymous --password anonymous svn://powhegbox.mib.infn.it/trunk/User-Processes-V2/hvq && \
    cd hvq && \
   


ENV PATH=$PATH:/usr/local/bin:/root/MG5_aMC_v3_5_5/bin
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib/
ENV PYTHONPATH=$PYTHONPATH:/usr/local/lib/python3.11/site-packages:/usr/local/lib:/usr/lib/python3/dist-packages/:/usr/local/local/lib/python3.11/dist-packages
