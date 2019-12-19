Content-Type: multipart/mixed; boundary="===============3562660782553015531=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH] peap: Ignore Crypto-Binding TLVs with invalid compound MACs
Date: Wed, 18 Dec 2019 16:42:39 -0800
Message-ID: <20191219004239.7132-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3562660782553015531==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Some server implementation don't seem to provide the valid compound MACs.
In the meantime, iwd will ignore the invalid Crypto-Binding TLVs as their
usage is optional.
---
 src/eap-peap.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/src/eap-peap.c b/src/eap-peap.c
index 273a206f..005eacc4 100644
--- a/src/eap-peap.c
+++ b/src/eap-peap.c
@@ -231,8 +231,11 @@ static int eap_extensions_handle_cryptobinding_tlv(str=
uct eap_state *eap,
 					cryptobinding_compound_mac_len)) {
 		l_error("PEAP: Generated compound MAC and server compound MAC "
 							"don't match.");
-
-		return -EIO;
+		/*
+		 * Ignore the Crypto-Binding TLV in the case of unmatched
+		 * compound MACs.
+		 */
+		return 0;
 	}
 =

 	/* Build response Crypto-Binding TLV */
-- =

2.13.6

--===============3562660782553015531==--

