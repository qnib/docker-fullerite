# QNIBTerminal image
FROM qnib/consul

#ENV GIT_BRANCH=dockerStats \
#    GIT_URL=https://github.com/qnib/fullerite/archive
ENV GIT_BRANCH=master \
    GIT_URL=https://github.com/Yelp/fullerite/archive/ \
    GOPATH=/usr/local/
RUN pip install configobj 
RUN dnf install -y make
RUN dnf install -y golang git-core mercurial
RUN dnf install -y git-core mercurial
RUN go get golang.org/x/tools/cmd/cover && \
    curl -fL ${GIT_URL}/${GIT_BRANCH}.zip  | bsdtar xf - -C /opt/ && \
    mv /opt/fullerite-${GIT_BRANCH} /opt/fullerite && \
    cd /opt/fullerite && \
    make && \
    mv /opt/fullerite/bin/fullerite /usr/local/bin/ && \
    rm -rf /opt/fullerite && \
    dnf remove -y make golang git-core mercurial bsdtar && \
    dnf autoremove -y
RUN dnf install -y jq
ADD conf/fullerite.conf /etc/fullerite/
ADD opt/qnib/fullerite/start.sh /opt/qnib/fullerite/
ADD etc/supervisord.d/fullerite.ini /etc/supervisord.d/
