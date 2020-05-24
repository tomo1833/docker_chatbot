import inspect


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

    print("BOT SYSTEM : BOTTER")

    user = User("user name")

    while True:
        inputs = input(" > ").rstrip()
        if not inputs:
            print("バイバイ")
            break

        response = user.get_response(inputs)
        print(response)
