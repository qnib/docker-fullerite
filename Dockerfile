# QNIBTerminal image
FROM qnib/consul

ENV GIT_BRANCH=dockerStats \
    GIT_URL=https://github.com/qnib/fullerite/archive
RUN \ 
    yum install -y bsdtar make golang git-core mercurial && \
    curl -fL ${GIT_URL}/${GIT_BRANCH}.zip  | bsdtar xf - -C /opt/ && \
    mv /opt/fullerite-${GIT_BRANCH} /opt/fullerite && cd /opt/fullerite && \
    GOPATH=/tmp/ make && \
    mv /opt/fullerite/bin/fullerite /usr/local/bin/ && \
    rm -rf /opt/fullerite && \
    yum remove -y make golang git-core mercurial bsdtar && \
    yum autoremove -y
RUN yum install -y jq
ADD conf/fullerite.conf /etc/fullerite/
ADD opt/qnib/fullerite/start.sh /opt/qnib/fullerite/
ADD etc/supervisord.d/fullerite.ini /etc/supervisord.d/
