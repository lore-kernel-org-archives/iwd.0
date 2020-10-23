Content-Type: multipart/mixed; boundary="===============0054860502266000170=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/2] auto-t: only return expected number from list_devices
Date: Fri, 23 Oct 2020 15:19:00 -0700
Message-ID: <20201023221900.1974722-2-prestwoj@gmail.com>
In-Reply-To: <20201023221900.1974722-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0054860502266000170==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If the caller specifies the number of devices only return that many.
Some sub-tests may only need a subset of the total number of devices
for the test. If the number of devices expected is less than the total
being returned, python would throw an exception.
---
 autotests/util/iwd.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index c65dd4a2..b557c17f 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -1085,7 +1085,7 @@ class IWD(AsyncOpAbstract):
             if not self._wait_timed_out:
                 GLib.source_remove(timeout)
 =

-        return list(self._devices.values() if not p2p else self._devices.p=
2p_dict.values())
+        return list(self._devices.values() if not p2p else self._devices.p=
2p_dict.values())[:wait_to_appear]
 =

     def list_p2p_devices(self, *args, **kwargs):
         return self.list_devices(*args, **kwargs, p2p=3DTrue)
-- =

2.26.2

--===============0054860502266000170==--

