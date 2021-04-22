Content-Type: multipart/mixed; boundary="===============3750662833929035362=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 5/7] auto-t: properly print wait_for_object_change exception
Date: Thu, 22 Apr 2021 10:37:44 -0700
Message-ID: <20210422173746.2324850-5-prestwoj@gmail.com>
In-Reply-To: <20210422173746.2324850-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3750662833929035362==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/util/iwd.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index 6cd7a1a8..e6421088 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -1064,7 +1064,8 @@ class IWD(AsyncOpAbstract):
                 # If neither the initial or expected condition evaluate the
                 # object must be in another unexpected state.
                 if not eval(from_str) and not eval(to_str):
-                    raise Exception('unexpected condition between [%s] and=
 [%s]' % from_str, to_str)
+                    raise Exception('unexpected condition between [%s] and=
 [%s]' %
+                                        (from_str, to_str))
 =

                 # Initial condition does not evaluate but expected does, p=
ass
                 if not eval(from_str) and eval(to_str):
-- =

2.26.2

--===============3750662833929035362==--

