Content-Type: multipart/mixed; boundary="===============8364374508307427638=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 4/4] peap: Fail auth. if invalid compound MAC is received
Date: Fri, 31 Jan 2020 14:25:17 -0800
Message-ID: <20200131222517.8182-4-tim.a.kourt@linux.intel.com>
In-Reply-To: <20200131222517.8182-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8364374508307427638==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since the interoperability with the Windows server has been achieved,
witch back to failing authentication if invalid compound MAC is
received.
---
 src/eap-peap.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/src/eap-peap.c b/src/eap-peap.c
index 6decbfb3..8c3ba2f3 100644
--- a/src/eap-peap.c
+++ b/src/eap-peap.c
@@ -244,11 +244,7 @@ static int eap_extensions_handle_cryptobinding_tlv(str=
uct eap_state *eap,
 					cryptobinding_compound_mac_len)) {
 		l_error("PEAP: Generated compound MAC and server compound MAC "
 							"don't match.");
-		/*
-		 * Ignore the Crypto-Binding TLV in the case of unmatched
-		 * compound MACs.
-		 */
-		return 0;
+		return -EIO;
 	}
 =

 	/* Build response Crypto-Binding TLV */
-- =

2.13.6

--===============8364374508307427638==--

