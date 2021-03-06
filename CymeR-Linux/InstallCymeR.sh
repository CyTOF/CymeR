#!/bin/bash
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
parentDIR="$(dirname "$DIR")"
grandparentDIR="$(dirname "$parentDIR")"
sudo true && \
sudo apt-get install xterm -y && \
sudo xset s off
sudo xset -dpms
sudo docker rmi -f $(docker images | grep "^<none>" | awk "{print $3}")
sudo docker pull bmuchmore/cymer
##sudo docker build -t bmuchmore/cymer $DIR/BaseFiles/Dockerfile && \
sudo echo '[Desktop Entry]' > $DIR/CymeR.desktop && \
sudo echo 'Type=Application' >> $DIR/CymeR.desktop && \
sudo echo 'Name=CymeR' >> $DIR/CymeR.desktop && \
sudo echo 'Exec='$DIR'/BaseFiles/Run/run.sh' >> $DIR/CymeR.desktop && \
sudo echo 'Icon='$DIR'/BaseFiles/Icons/knime.png' >> $DIR/CymeR.desktop && \
sudo echo '[Desktop Entry]' > $DIR/commit.desktop && \
sudo echo 'Type=Application' >> $DIR/commit.desktop &&
sudo echo 'Name=commit' >> $DIR/commit.desktop && \
sudo echo 'Exec='$DIR'/BaseFiles/Run/commit.sh' >> $DIR/commit.desktop && \
sudo echo 'Icon='$DIR'/BaseFiles/Icons/commit.png' >> $DIR/commit.desktop && \
##sudo mv $DIR/InstallCymeR.sh $DIR/BaseFiles/Install/InstallCymeR.sh && \
sudo chown 777 -R $grandparentDIR && \
sudo chmod 777 -R $grandparentDIR
sudo docker rmi -f $(docker images | grep "^<none>" | awk "{print $3}")
read -p "*** YOU CAN NOW CLOSE ME ***"
