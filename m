Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92441643
	for <iwd@lists.linux.dev>; Sun, 26 Feb 2023 06:29:42 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (unknown [217.70.183.198])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 5C98AC3FAF
	for <iwd@lists.linux.dev>; Sun, 26 Feb 2023 06:25:55 +0000 (UTC)
Received: (Authenticated sender: c@jia.je)
	by mail.gandi.net (Postfix) with ESMTPSA id AA763C0004;
	Sun, 26 Feb 2023 06:25:45 +0000 (UTC)
From: Jiajie Chen <c@jia.je>
To: iwd@lists.linux.dev
Cc: Jiajie Chen <c@jia.je>
Subject: [PATCH 1/2] knownnetworks: fix potential out of bounds write
Date: Sun, 26 Feb 2023 14:25:25 +0800
Message-Id: <20230226062526.3115588-1-c@jia.je>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a very long ssid was used (e.g. CJK characters in SSID), it might do
out of bounds write to static variable for lack of checking the position
before the last snprintf() call.
---
 src/knownnetworks.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/knownnetworks.c b/src/knownnetworks.c
index 487b7017..6c575e50 100644
--- a/src/knownnetworks.c
+++ b/src/knownnetworks.c
@@ -176,7 +176,8 @@ static const char *known_network_get_path(const struct network_info *network)
 		pos += snprintf(path + pos, sizeof(path) - pos, "%02x",
 				network->ssid[i]);
 
-	snprintf(path + pos, sizeof(path) - pos, "_%s",
+	if (pos < sizeof(path))
+		snprintf(path + pos, sizeof(path) - pos, "_%s",
 			security_to_str(network->type));
 	path[sizeof(path) - 1] = '\0';
 
-- 
2.30.2

