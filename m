Content-Type: multipart/mixed; boundary="===============4048046890989370980=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 03/15] ap: Fix leaking of ap->wsc_pbc_timeout
Date: Fri, 04 Jun 2021 03:50:40 +0200
Message-ID: <20210604015052.163727-3-andrew.zaborowski@intel.com>
In-Reply-To: <20210604015052.163727-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4048046890989370980==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/ap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/ap.c b/src/ap.c
index 20422d4e..0602792c 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -211,6 +211,7 @@ static void ap_reset(struct ap_state *ap)
 		l_uintset_free(ap->rates);
 =

 	l_queue_destroy(ap->wsc_pbc_probes, l_free);
+	l_timeout_remove(ap->wsc_pbc_timeout);
 =

 	ap->started =3D false;
 =

-- =

2.30.2

--===============4048046890989370980==--

