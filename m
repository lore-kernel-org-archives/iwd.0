Content-Type: multipart/mixed; boundary="===============3193638179839480681=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [RFC 1/1] test-runner: allow anonymous Dbus access
Date: Tue, 24 Mar 2020 13:29:01 -0700
Message-ID: <20200324202901.26984-2-prestwoj@gmail.com>
In-Reply-To: <20200324202901.26984-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3193638179839480681==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The dbus config file doesn't play well with Fedora.
---
 tools/test-runner.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index 320dea0b..1be3f640 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -665,6 +665,8 @@ static void create_dbus_system_conf(void)
 	fputs("<type>system</type>\n", fp);
 	fputs("<listen>unix:path=3D/run/dbus/system_bus_socket</listen>\n", fp);
 	fputs("<limit name=3D\"reply_timeout\">2147483647</limit>", fp);
+	fputs("<auth>ANONYMOUS</auth>\n", fp);
+	fputs("<allow_anonymous/>\n", fp);
 	fputs("<policy context=3D\"default\">\n", fp);
 	fputs("<allow user=3D\"*\"/>\n", fp);
 	fputs("<allow own=3D\"*\"/>\n", fp);
-- =

2.21.1

--===============3193638179839480681==--

