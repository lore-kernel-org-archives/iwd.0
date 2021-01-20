Content-Type: multipart/mixed; boundary="===============4144195109979464665=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 8/8] test: add StationDiagnostic interface to monitor-iwd
Date: Wed, 20 Jan 2021 10:30:36 -0800
Message-ID: <20210120183036.477287-8-prestwoj@gmail.com>
In-Reply-To: <20210120183036.477287-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4144195109979464665==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/monitor-iwd | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/test/monitor-iwd b/test/monitor-iwd
index 707b0c39..df043bc3 100755
--- a/test/monitor-iwd
+++ b/test/monitor-iwd
@@ -66,7 +66,8 @@ relevant_ifaces =3D [ "net.connman.iwd.Device",
                     "net.connman.iwd.AgentManager",
                     "net.connman.iwd.KnownNetwork",
                     "net.connman.iwd.Station",
-                    "net.connman.iwd.AccessPointDiagnostic"]
+                    "net.connman.iwd.AccessPointDiagnostic",
+                    "net.connman.iwd.StationDiagnostic"]
 =

 def interfaces_added(path, interfaces):
     for iface, props in interfaces.items():
-- =

2.26.2

--===============4144195109979464665==--

