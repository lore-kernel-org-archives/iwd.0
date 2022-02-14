Content-Type: multipart/mixed; boundary="===============2687951476235160542=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v3 07/10] auto-t: wpas.py: allow arbitrary events to be handled
Date: Mon, 14 Feb 2022 13:48:06 -0800
Message-ID: <20220214214809.1017870-7-prestwoj@gmail.com>
In-Reply-To: 20220214214809.1017870-1-prestwoj@gmail.com

--===============2687951476235160542==
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

--===============2687951476235160542==--

