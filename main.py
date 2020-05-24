import inspect


class User:
    """
    ユーザクラス
    """

    def __init__(self):
        """
        Userオブジェクト
        """
        self.responder = Responder()

    def get_response(self, inputs):
        """
        応答オブジェクトから応答文字列を返却する

        @param inputs
        戻り値 応答文字列
        """

        return self.responder.response(inputs)


class Responder:
    """
    応答クラス
    """

    def __init__(self):
        """
        Responseオブジェクト
        """

    def response(self, inputs):
        """
        応答文字列を作って返す

        @param input
        戻り値　応答文字列を作って返す。
        """

        return inputs + "ってなに?"


if __name__ == "__main__":

    print("BOT SYSTEM : BOTTER")

    user = User()

    while True:
        inputs = input(" > ").rstrip()
        if not inputs:
            print("バイバイ")
            break

        response = user.get_response(inputs)
        print(response)
