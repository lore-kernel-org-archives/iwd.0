Received: from erminea.space (skamirror.shkenev.ru [51.250.125.203])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 15202187C
	for <iwd@lists.linux.dev>; Sun,  9 Oct 2022 13:28:01 +0000 (UTC)
Received: (qmail 14883 invoked from network); 9 Oct 2022 13:27:55 -0000
Received: from unknown (HELO erminea.space) (127.0.0.1)
  by 127.0.0.1 with SMTP; 9 Oct 2022 13:27:55 -0000
Received: from localhost.localdomain ([188.32.162.54])
	by erminea.space with ESMTPSA
	id gmtYF1vMQmMfOgAAH+dm7w
	(envelope-from <mustela@erminea.space>); Sun, 09 Oct 2022 16:27:55 +0300
From: Peter Shkenev <mustela@erminea.space>
To: iwd@lists.linux.dev
Cc: Peter Shkenev <mustela@erminea.space>
Subject: [PATCH] src/station.c: remove excess if clause
Date: Sun,  9 Oct 2022 16:27:44 +0300
Message-Id: <20221009132744.8998-1-mustela@erminea.space>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional changes are intended.
---
 src/station.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/src/station.c b/src/station.c
index 1ebd13ad..fc0a40bf 100644
--- a/src/station.c
+++ b/src/station.c
@@ -183,12 +183,9 @@ struct network *station_get_connected_network(struct station *station)
 
 bool station_is_busy(struct station *station)
 {
-	if (station->state != STATION_STATE_DISCONNECTED &&
+	return station->state != STATION_STATE_DISCONNECTED &&
 			station->state != STATION_STATE_AUTOCONNECT_FULL &&
-			station->state != STATION_STATE_AUTOCONNECT_QUICK)
-		return true;
-
-	return false;
+			station->state != STATION_STATE_AUTOCONNECT_QUICK;
 }
 
 static bool station_is_autoconnecting(struct station *station)
-- 
2.34.1

