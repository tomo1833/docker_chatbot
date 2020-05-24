FROM ubuntu:latest

# ビルドに必要なソフトウェアをインストール
RUN apt-get update && \
    apt-get install -y wget git build-essential python3 python3-pip python3-pyaudio python3-dev libasound2-dev

RUN pip3 install --upgrade pip
RUN pip3 install simpleaudio

WORKDIR /usr/local/src/

# Open JTalk関連のソフトウェアをセットアップ
RUN wget http://downloads.sourceforge.net/hts-engine/hts_engine_API-1.10.tar.gz && \
    tar zxvf hts_engine_API-1.10.tar.gz && \
    cd hts_engine_API-1.10/ && \
    ./configure && \
    make && \
    make install

#COPY manobi.patch manobi.patch

RUN wget http://downloads.sourceforge.net/open-jtalk/open_jtalk-1.09.tar.gz && \
    tar zxvf open_jtalk-1.09.tar.gz && \
    cd open_jtalk-1.09/ && \
    #    patch -p0 < /usr/local/src/manobi.patch && \
    ./configure --with-hts-engine-header-path=/usr/local/include --with-hts-engine-library-path=/usr/local/lib --with-charset=UTF-8 && \
    make && \
    make install

RUN wget http://downloads.sourceforge.net/open-jtalk/hts_voice_nitech_jp_atr503_m001-1.05.tar.gz && \
    tar zxvf hts_voice_nitech_jp_atr503_m001-1.05.tar.gz && \
    cp -r hts_voice_nitech_jp_atr503_m001-1.05 /usr/local/lib/hts_voice_nitech_jp_atr503_m001-1.05

RUN wget http://downloads.sourceforge.net/open-jtalk/open_jtalk_dic_utf_8-1.09.tar.gz && \
    tar zxvf open_jtalk_dic_utf_8-1.09.tar.gz && \
    cp -r open_jtalk_dic_utf_8-1.09 /usr/local/lib/open_jtalk_dic_utf_8-1.09

WORKDIR /usr/app/src


# 以下Docker コマンド

# 1. docker ビルド
#     $ docker build -t img_jtok01 .

# 2. docker コンポーネント実行
#     $ docker run -itd --name com_jtok01 img_jtok01
#     $ echo こんにちは | docker run -i --rm img_jtok01 > hello.wav
#     $ docker run --name com_jtok01 img_jtok01
#     $ docker run -itd --volume D:\work_space\windows_project_18:/usr/app/src --name com_jtok01 img_jtok01

# 3. docker コンポーネント入力
#     $ docker exec -it com_jtok01 python3 mainwav.py
#     $ docker exec -it com_jtok01 sh



docker run -itd --volume D:\work_space\windows_project_18:/usr/app/src  --device="class/916EF1CB-8426-468D-A6F7-9AE8076881B3" mcr.microsoft.com/windows/servercore:1809  --name com_jtok01 img_jtok01


# ディレクトリ構成
# prj
#    ┣ 