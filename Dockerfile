# QNIBTerminal image
FROM qnib/consul

#ENV GIT_BRANCH=dockerStats \
#    GIT_URL=https://github.com/qnib/fullerite/archive
ENV GIT_BRANCH=master \
    GIT_URL=https://github.com/Yelp/fullerite/archive/ \
    GOPATH=/usr/local/
RUN pip install configobj mock
RUN dnf install -y make golang git-core mercurial && \
    go get golang.org/x/tools/cmd/cover && \
    curl -fL ${GIT_URL}/${GIT_BRANCH}.zip  | bsdtar xf - -C /opt/ && \
    mv /opt/fullerite-${GIT_BRANCH} /opt/fullerite && \
    cd /opt/fullerite && \
    make && \
    mv /opt/fullerite/bin/fullerite /usr/local/bin/ && \
    rm -rf /opt/fullerite
RUN dnf remove -y make golang git-core mercurial bsdtar && \
    dnf autoremove -y
ADD conf/fullerite.conf /etc/fullerite/
ADD opt/qnib/fullerite/start.sh /opt/qnib/fullerite/
ADD etc/supervisord.d/fullerite.ini /etc/supervisord.d/
