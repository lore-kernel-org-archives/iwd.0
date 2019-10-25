Content-Type: multipart/mixed; boundary="===============0515702671795805832=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH] client: Fix network name completion
Date: Fri, 25 Oct 2019 10:26:07 -0700
Message-ID: <20191025172607.10840-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0515702671795805832==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Exclude the network names that are shorter then the query text
from the autocompletion network name list.
---
 client/network.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/client/network.c b/client/network.c
index 023a505c..b4ce3235 100644
--- a/client/network.c
+++ b/client/network.c
@@ -228,6 +228,9 @@ static bool match_by_partial_name(const void *a, const =
void *b)
 		return false;
 	}
 =

+	if (*text)
+		return false;
+
 	return true;
 }
 =

-- =

2.13.6

--===============0515702671795805832==--

