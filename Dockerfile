FROM martynas/archlinux

COPY ./1password-bin /1password-bin
WORKDIR /1password-bin

RUN ls -al

RUN sudo chown -R build .

RUN namcap PKGBUILD
RUN grep -E 'depends|makedepends' PKGBUILD | \
        sed -e 's/.*depends=//' -e 's/ /\n/g' | \
        tr -d "'" | tr -d "(" | tr -d ")" | \
        xargs yay -S --noconfirm
RUN makepkg --syncdeps --noconfirm
RUN namcap "1password-bin"-*
RUN source /etc/makepkg.conf
RUN pacman -Qip "1password-bin"-*
RUN pacman -Qlp "1password-bin"-*
RUN makepkg -si --noconfirm
# RUN makepkg --printsrcinfo | diff .SRCINFO - || \
#         { echo ".SRCINFO is out of sync. Please run 'makepkg --printsrcinfo' and commit the changes."; false; }
RUN eval "1password --version"
