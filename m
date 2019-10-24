Content-Type: multipart/mixed; boundary="===============0496611195876932114=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 8/8] p2putils: Fix length in Channel List parsing
Date: Thu, 24 Oct 2019 06:30:00 +0200
Message-ID: <20191024043000.13687-8-andrew.zaborowski@intel.com>
In-Reply-To: <20191024043000.13687-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0496611195876932114==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/p2putil.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/p2putil.c b/src/p2putil.c
index 7d1a7ad2..ce53b2a2 100644
--- a/src/p2putil.c
+++ b/src/p2putil.c
@@ -219,7 +219,7 @@ static bool extract_p2p_channel_list(const uint8_t *att=
r, size_t len,
 		l_queue_push_tail(out->channel_entries, entries);
 =

 		attr +=3D entries->n_channels;
-		len -=3D entries->n_channels;
+		len -=3D 2 + entries->n_channels;
 	}
 =

 	return true;
-- =

2.20.1

--===============0496611195876932114==--

