# docker_chatbot

Dockerからチャットを行うアプリです。

## 環境

実行環境:ubuntu　18.4
※windowsで音声出力は出来ません。
※windowsのdockerではsoundデバイスが認識されません。

## 環境構築手順

## 1. Dockerビルドでimage作成

Imageファイルの作成
```sh
$ docker build -t img_botcat .
```

## 2. Dockerコンテナの作成

Volumeなし
```sh
$ docker run -itd --name com_botcat img_botcat
```

Volumeあり
```sh
$ docker run -itd --volume /home/vagrant/app/botchat_prj:/usr/app/src --device=/dev/snd:/dev/snd --name com_botcat img_botcat
```
※絶対パスを指定
※/home/vagrant/app/botchat_prjはホスト側のパスに変更してください。


## 3. Dockerコンテナ実行

文字出力
```sh
$ docker exec -it com_botcat python3 main.py
```

音声出力
```sh
$ docker exec -it com_botcat python3 mainwav.py
```

ターミナル
```sh
$ docker exec -it com_botcat sh
```
