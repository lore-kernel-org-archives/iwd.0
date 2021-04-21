Content-Type: multipart/mixed; boundary="===============5906522140277186014=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: [PATCH 1/2] auto-t: add stop event/non-blocking to hlrauc.py
Date: Wed, 21 Apr 2021 11:52:38 -0700
Message-ID: <d01953b92d5880f59a19eeade70eb20159be4602.camel@gmail.com>
In-Reply-To: <20210421184228.2272285-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5906522140277186014==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Ignore this. It is not needed and redundant. Closing the socket
achieves the same goal. The problem is actually fixed in Patch 2.

On Wed, 2021-04-21 at 11:42 -0700, James Prestwood wrote:
> There was a problem with AuthCenter where if an unhandled exception
> was thrown the read thread never exited, since stop() would never
> be called. In addition the read() call itself was blocking which
> may have led to additional issues trying to stop the thread.
> =

> Now an explicit stop event was added and the socket was set to
> non-blocking. This will require autotest modification in order to
> stop AuthCenter in an appropriate location to handle any exceptions.
> ---
>  autotests/util/hlrauc.py | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> =

> diff --git a/autotests/util/hlrauc.py b/autotests/util/hlrauc.py
> index ab143acc..c79692f2 100644
> --- a/autotests/util/hlrauc.py
> +++ b/autotests/util/hlrauc.py
> @@ -3,6 +3,7 @@ import os
>  import threading
>  import sys
>  import signal
> +from time import sleep
>  from Crypto.Cipher import AES
>  =

>  class AuthCenter:
> @@ -15,11 +16,13 @@ class AuthCenter:
>          self._sock_path =3D sock_path
>          self._read_config(config_file)
>          self._socket =3D socket.socket(socket.AF_UNIX,
> socket.SOCK_DGRAM)
> +        self._socket.setblocking(0)
>          if os.path.exists(sock_path):
>              os.unlink(sock_path)
>          self._socket.bind(sock_path)
>  =

> -        self._rxhandle =3D threading.Thread(target=3Dself._rx_thread)
> +        self.stop_event =3D threading.Event()
> +        self._rxhandle =3D threading.Thread(target=3Dself._rx_thread,
> args=3D(self, self.stop_event))
>          self._rxhandle.ready =3D threading.Event()
>          self._rxhandle.start()
>  =

> @@ -30,15 +33,17 @@ class AuthCenter:
>          os.remove(self._sock_path)
>          self._socket.close()
>  =

> -    def _rx_thread(self):
> +    @staticmethod
> +    def _rx_thread(self, stop_event):
>          self._rxhandle.ready.set()
> -        while (True):
> +        while not stop_event.isSet():
>              try:
>                  data, addr =3D self._socket.recvfrom(1000)
>                  data =3D data.decode('ascii')
>                  resp =3D self._process_data(data)
> -            except OSError:
> -                break
> +            except BlockingIOError:
> +                sleep(0.5)
> +                continue
>              except:
>                  print("Exception:", sys.exc_info()[0])
>                  break
> @@ -241,6 +246,7 @@ class AuthCenter:
>          '''
>              Stop the Authentication server and close the socket
>          '''
> +        self.stop_event.set()
>          self._socket.shutdown(socket.SHUT_RDWR)
>          self._socket.close()
>          self._rxhandle.join()

--===============5906522140277186014==--

