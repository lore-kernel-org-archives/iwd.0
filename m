Content-Type: multipart/mixed; boundary="===============2216263546231255085=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 7/8] test: add AccessPointDiagnostics to monitor-iwd
Date: Wed, 20 Jan 2021 10:30:35 -0800
Message-ID: <20210120183036.477287-7-prestwoj@gmail.com>
In-Reply-To: <20210120183036.477287-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2216263546231255085==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/monitor-iwd | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/test/monitor-iwd b/test/monitor-iwd
index e801ef54..707b0c39 100755
--- a/test/monitor-iwd
+++ b/test/monitor-iwd
@@ -65,7 +65,8 @@ relevant_ifaces =3D [ "net.connman.iwd.Device",
                     "net.connman.iwd.Network",
                     "net.connman.iwd.AgentManager",
                     "net.connman.iwd.KnownNetwork",
-                    "net.connman.iwd.Station" ]
+                    "net.connman.iwd.Station",
+                    "net.connman.iwd.AccessPointDiagnostic"]
 =

 def interfaces_added(path, interfaces):
     for iface, props in interfaces.items():
-- =

2.26.2

--===============2216263546231255085==--

