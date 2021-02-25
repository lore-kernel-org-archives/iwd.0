Content-Type: multipart/mixed; boundary="===============4745523190697136836=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 02/17] auto-t: hlrauc.py: remove unix socket on cleanup
Date: Thu, 25 Feb 2021 14:00:51 -0800
Message-ID: <20210225220106.1728411-2-prestwoj@gmail.com>
In-Reply-To: <20210225220106.1728411-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4745523190697136836==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/util/hlrauc.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/autotests/util/hlrauc.py b/autotests/util/hlrauc.py
index 4491a0ef..ab143acc 100644
--- a/autotests/util/hlrauc.py
+++ b/autotests/util/hlrauc.py
@@ -12,6 +12,7 @@ class AuthCenter:
         hostapd can communicate with to obtain SIM values.
     '''
     def __init__(self, sock_path, config_file):
+        self._sock_path =3D sock_path
         self._read_config(config_file)
         self._socket =3D socket.socket(socket.AF_UNIX, socket.SOCK_DGRAM)
         if os.path.exists(sock_path):
@@ -25,6 +26,10 @@ class AuthCenter:
         # wait for rx thread to start
         self._rxhandle.ready.wait()
 =

+    def __del__(self):
+        os.remove(self._sock_path)
+        self._socket.close()
+
     def _rx_thread(self):
         self._rxhandle.ready.set()
         while (True):
-- =

2.26.2

--===============4745523190697136836==--

