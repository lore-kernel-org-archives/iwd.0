Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A01647
	for <iwd@lists.linux.dev>; Sun, 26 Feb 2023 06:29:44 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::226])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id DD148C4009
	for <iwd@lists.linux.dev>; Sun, 26 Feb 2023 06:26:01 +0000 (UTC)
Received: (Authenticated sender: c@jia.je)
	by mail.gandi.net (Postfix) with ESMTPSA id E76ACC0002;
	Sun, 26 Feb 2023 06:25:52 +0000 (UTC)
From: Jiajie Chen <c@jia.je>
To: iwd@lists.linux.dev
Cc: Jiajie Chen <c@jia.je>
Subject: [PATCH 2/2] knownnetworks: fix printing SSID in hex
Date: Sun, 26 Feb 2023 14:25:26 +0800
Message-Id: <20230226062526.3115588-2-c@jia.je>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230226062526.3115588-1-c@jia.je>
References: <20230226062526.3115588-1-c@jia.je>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Force conversion to unsigned char before printing to avoid sign
extension when printing SSID in hex. For example, if there are CJK
characters in SSID, it will generate a very long string like
/net/connman/iwd/ffffffe8ffffffaeffffffa1.
---
 src/knownnetworks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/knownnetworks.c b/src/knownnetworks.c
index 6c575e50..d4d50a6f 100644
--- a/src/knownnetworks.c
+++ b/src/knownnetworks.c
@@ -174,7 +174,7 @@ static const char *known_network_get_path(const struct network_info *network)
 
 	for (i = 0; network->ssid[i] && pos < sizeof(path); i++)
 		pos += snprintf(path + pos, sizeof(path) - pos, "%02x",
-				network->ssid[i]);
+				(unsigned char)network->ssid[i]);
 
 	if (pos < sizeof(path))
 		snprintf(path + pos, sizeof(path) - pos, "_%s",
-- 
2.30.2

