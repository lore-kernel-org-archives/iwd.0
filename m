Content-Type: multipart/mixed; boundary="===============7058978378803669925=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 12/12] p2putil: Tolerate GO Neg Response with empty Channel
 List
Date: Wed, 18 Mar 2020 15:45:31 +0100
Message-ID: <20200318144531.30613-12-andrew.zaborowski@intel.com>
In-Reply-To: <20200318144531.30613-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7058978378803669925==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Work around a parse error in GO Negotiation with some P2P devices.
---
 src/p2putil.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/src/p2putil.c b/src/p2putil.c
index 02c02b4d..58a75a11 100644
--- a/src/p2putil.c
+++ b/src/p2putil.c
@@ -193,7 +193,12 @@ static bool extract_p2p_channel_list(const uint8_t *at=
tr, size_t len,
 {
 	struct p2p_channel_list_attr *out =3D data;
 =

-	if (len < 6)
+	/*
+	 * Some devices reply with an empty Channel Entry List inside the
+	 * Channel List attribute of a GO Negotiation Response (status 1),
+	 * so tolerate a length of 3.
+	 */
+	if (len < 3)
 		return false;
 =

 	out->country[0] =3D *attr++;
-- =

2.20.1

--===============7058978378803669925==--

