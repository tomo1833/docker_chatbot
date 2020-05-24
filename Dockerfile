# ubuntu os のイメージダウンロード
FROM ubuntu:latest

# ビルドに必要なソフトウェアをインストール
RUN apt-get update && \
    apt-get install -y wget git build-essential python3 python3-pip python3-pyaudio python3-dev libasound2-dev

# パイソンライブラリ取得
RUN pip3 install --upgrade pip
RUN pip3 install simpleaudio

# Open JTalkライブラリパス
WORKDIR /usr/local/src/

# Open JTalk関連のソフトウェアをセットアップ
RUN wget http://downloads.sourceforge.net/hts-engine/hts_engine_API-1.10.tar.gz && \
    tar zxvf hts_engine_API-1.10.tar.gz && \
    cd hts_engine_API-1.10/ && \
    ./configure && \
    make && \
    make install

RUN wget http://downloads.sourceforge.net/open-jtalk/open_jtalk-1.09.tar.gz && \
    tar zxvf open_jtalk-1.09.tar.gz && \
    cd open_jtalk-1.09/ && \
    ./configure --with-hts-engine-header-path=/usr/local/include --with-hts-engine-library-path=/usr/local/lib --with-charset=UTF-8 && \
    make && \
    make install

RUN wget http://downloads.sourceforge.net/open-jtalk/hts_voice_nitech_jp_atr503_m001-1.05.tar.gz && \
    tar zxvf hts_voice_nitech_jp_atr503_m001-1.05.tar.gz && \
    cp -r hts_voice_nitech_jp_atr503_m001-1.05 /usr/local/lib/hts_voice_nitech_jp_atr503_m001-1.05

RUN wget http://downloads.sourceforge.net/open-jtalk/open_jtalk_dic_utf_8-1.09.tar.gz && \
    tar zxvf open_jtalk_dic_utf_8-1.09.tar.gz && \
    cp -r open_jtalk_dic_utf_8-1.09 /usr/local/lib/open_jtalk_dic_utf_8-1.09

# 実行環境
WORKDIR /usr/app/src


#　Dockerコマンド

# 1. Dockerビルドでimage作成
#     $ docker build -t img_botcat .

# 2. Dockerコンテナの作成
#   Volumeなし
#     $ docker run -itd --name com_botcat img_botcat
#   Volumeあり
#     $ docker run -itd --volume /home/vagrant/app/botchat_prj:/usr/app/src --device=/dev/snd:/dev/snd --name com_botcat img_botcat

# 3. Dockerコンテナ実行
#   文字出力
#     $ docker exec -it com_botcat python3 main.py
#   音声出力
#     $ docker exec -it com_botcat python3 mainwav.py
#   ターミナル
#     $ docker exec -it com_botcat sh
