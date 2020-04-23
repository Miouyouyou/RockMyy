FROM ubuntu

RUN apt -y update
RUN apt -y install gcc make automake bison flex bc pkg-config wget git ncurses-dev gcc-arm-linux-gnueabi libssl-dev

COPY GetPatchAndCompileKernel.sh /GetPatchAndCompileKernel.sh
COPY docker/build.sh /entrypoint.sh

VOLUME ["/git", "/tmp/RockMyy-Build"]

CMD ["/entrypoint.sh"]
