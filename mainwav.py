import inspect
import subprocess
import simpleaudio


class User:
    """
    ユーザクラス
    """

    def __init__(self, name):
        """
        Userオブジェクトの名前をnameに格納
        @param name
        """
        self.name = name
        self.responder = Responder("response name")

    def get_response(self, inputs):
        """
        応答オブジェクトから応答文字列を返却する
        @param name
        戻り値 応答文字列
        """

        # for x in inspect.getmembers(self.responder, inspect.ismethod):
        #    print(x[0])

        return self.responder.response(inputs)


class Responder:
    """
    応答クラス
    """

    def __init__(self, name):
        """
        Responseオブジェクトの名前をnameに格納

        @param name
        """
        self.name = name

    def response(self, inputs):
        """
        応答文字列を作って返す

        @param input
        戻り値　応答文字列を作って返す。
        """

        return inputs + "ってなに?"


if __name__ == "__main__":

    OPEN_PATH_SRC = "/usr/local/src/"
    OPEN_PATH_MAIN = OPEN_PATH_SRC + "open_jtalk-1.09/"
    OPEN_VOICE_MAIN = OPEN_PATH_SRC + "hts_voice_nitech_jp_atr503_m001-1.05/"

    OPENJTALK_BINPATH = OPEN_PATH_MAIN + "bin/"
    OPENJTALK_DICPATH = OPEN_PATH_MAIN + "mecab-naist-jdic"
    OPENJTALK_VOICEPATH = OPEN_VOICE_MAIN + "nitech_jp_atr503_m001.htsvoice"

    open_jtalk = [OPENJTALK_BINPATH + "open_jtalk"]
    mech = ["-x", OPENJTALK_DICPATH]
    htsvoice = ["-m", OPENJTALK_VOICEPATH]
    speed = ["-r", "1.0"]
    outwav = ["-ow", "open_jtalk.wav"]

    cmd = open_jtalk + mech + htsvoice + speed + outwav

    print(cmd)
    print("BOT SYSTEM : BOTTER")

    user = User("user name")

    while True:
        inputs = input(" > ").rstrip()
        if not inputs:
            print("バイバイ")
            break

        response = user.get_response(inputs)

        print(response)

        subpro = subprocess.Popen(cmd, stdin=subprocess.PIPE)
        subpro.stdin.write(response.encode("utf-8"))
        subpro.stdin.close()
        subpro.wait()

        wav_obj = simpleaudio.WaveObject.from_wave_file("/usr/app/src/open_jtalk.wav")
        play_obj = wav_obj.play()
        play_obj.wait_done()
