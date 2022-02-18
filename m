Content-Type: multipart/mixed; boundary="===============3800885731983818158=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v4 6/9] auto-t: wpas.py: allow arbitrary events to be handled
Date: Fri, 18 Feb 2022 11:31:31 -0800
Message-ID: <20220218193134.2143232-6-prestwoj@gmail.com>
In-Reply-To: 20220218193134.2143232-1-prestwoj@gmail.com

--===============3800885731983818158==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If an event is in response to some command which is returning an
unexpected value (unexpected with respect to wpas.py) handle_eow
would raise an exception.

Specifically with DPP this was being hit when the URI was being
returned.
---
 autotests/util/wpas.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/autotests/util/wpas.py b/autotests/util/wpas.py
index 6b845232..c8e65179 100644
--- a/autotests/util/wpas.py
+++ b/autotests/util/wpas.py
@@ -88,8 +88,6 @@ class Wpas:
         def handle_eow():
             nonlocal key, value, count, event
             if count =3D=3D 0:
-                if key is not None or not value:
-                    raise Exception('Bad event name')
                 key =3D 'event'
             elif key is None:
                 if not value:
-- =

2.34.1

--===============3800885731983818158==--

