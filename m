Content-Type: multipart/mixed; boundary="===============8121953648700198270=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] test-runner: open up dbus config for dbus-monitor
Date: Wed, 16 Sep 2020 12:40:06 -0700
Message-ID: <20200916194006.683635-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8121953648700198270==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

dbus-monitor was not able to eavesdrop on method calls without
some changed to the dbus config.
---
 tools/test-runner | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/test-runner b/tools/test-runner
index d1e1d42c..8a257be1 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -149,6 +149,8 @@ busconfig.dtd\">
 <allow receive_type=3D\"signal\"/>
 <allow receive_type=3D\"method_return\"/>
 <allow receive_type=3D\"error\"/>
+<allow send_destination=3D\"*\" eavesdrop=3D\"true\"/>
+<allow eavesdrop=3D\"true\"/>
 </policy>
 </busconfig>
 '''
-- =

2.26.2

--===============8121953648700198270==--

