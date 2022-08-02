Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE517F
	for <iwd@lists.linux.dev>; Tue,  2 Aug 2022 10:47:36 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id l4so17397205wrm.13
        for <iwd@lists.linux.dev>; Tue, 02 Aug 2022 03:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wz3RIueN5KpuN/E3m+Gi4gfge+0RUWDAqM0nf6WlZ0o=;
        b=g3hdJeXWnmnZCN2pjAaDXPrT1Y/4/OP18Yo9UhdHo8a9idzOPt1J/mFDYfm2aZ0OSk
         tVaquwM8iEHYWWvIhU0ri4gVREidYMI8c6CHpO1Slj7mvkAyhUvXQXgnoJicykKCa/I6
         FeMSJelrTq2gY43NpT6u6NCRcnKslRIZuj8glhCQDsuBENPB8bEVO4aje86Fd5fYQd4f
         DnUQU+fupq8KurYZ0UTuAj1RjKDUM/mIv9dE1E8fyt59RaCpY0gDgN8vYMS972+IH9Sn
         3jPDOXvRTb23Hx86gnDJec6kXMhYfVytnGnDusspSqHSguRW6Dh/lIwvd8oGZsHTmT/a
         55Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wz3RIueN5KpuN/E3m+Gi4gfge+0RUWDAqM0nf6WlZ0o=;
        b=3LF/PtKdQJQf8G3zc+sOYe1k5EYvlQrEzVKVmwkUjXj8elo8B30fay5W244wiu6T3c
         Wf+k/WdCoTnuVQspU47S3PgfhMZhUj/nt+XLgA5K+M3c1FP5Nto+76K7AViVDCxOKv3N
         72z7ePNNRuSjnpz3bhFYgp35LfzGn2YP4ZR4wEKYBjpBjvcYs2hDiuWOAHnkH6LV37pk
         hdLiyl4YVjjC7Ga03SY8NLVrRgr+4XQKr9wHxCTN3YG5mSkabY8HvPfcrrmuaExeYoDO
         6tkzMKR3MD8KsRunmSwwmmyymG6Eb9WUdQcFFf32lBQ8evnv6oK3IvOX8jQhLztTUH4V
         TJGg==
X-Gm-Message-State: ACgBeo2SakpDZJKvUEXMByroDKV126hATz/LHQBdSKvaAjzxuAWF2NA6
	QsCi1rHwRx5cxEOe5ts3BYEAX5g0vJSEFw==
X-Google-Smtp-Source: AA6agR6Nmmfxf7cO/DYd3f8GHjJKeIMWWIfDnzwpbv0v2SzSC7OPk4D82JxC86CqDDwrzJqKqED+Gw==
X-Received: by 2002:a5d:47cd:0:b0:220:70a2:5383 with SMTP id o13-20020a5d47cd000000b0022070a25383mr1658091wrc.258.1659437254079;
        Tue, 02 Aug 2022 03:47:34 -0700 (PDT)
Received: from localhost.localdomain (cpc156731-sgyl45-2-0-cust617.18-2.cable.virginm.net. [82.31.54.106])
        by smtp.gmail.com with ESMTPSA id p18-20020a5d4592000000b0021f73c66198sm10558389wrq.1.2022.08.02.03.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 03:47:33 -0700 (PDT)
From: Michael Johnson <mjohnson459@gmail.com>
To: iwd@lists.linux.dev
Cc: Michael Johnson <mjohnson459@gmail.com>
Subject: [PATCH v2] netdev: Add logging for CQM messages
Date: Tue,  2 Aug 2022 11:47:28 +0100
Message-Id: <20220802104728.48628-1-mjohnson459@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add extra logging around CQM events to help track wifi status. This is
useful for headless systems that can only be accessed over the network
and so information in the logs is invaluable for debugging outages.

Prior to this change, the only log for CQM messages is saying one was
received. This adds details to what attributes were set and the
associated data with them.

The signal strength log format was chosen to roughly match
wpa_supplicant's which looks like this:

CTRL-EVENT-SIGNAL-CHANGE above=1 signal=-60 noise=-96 txrate=6000
---
 src/netdev.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 5a6a7b70..47e076e2 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -1092,12 +1092,26 @@ static void netdev_cqm_event(struct l_genl_msg *msg, struct netdev *netdev)
 					rssi_event = (uint32_t *) data;
 					break;
 
+				case NL80211_ATTR_CQM_PKT_LOSS_EVENT:
+					if (len != 4)
+						continue;
+
+					l_debug("Packets lost event: %d",
+							*(uint32_t *) data);
+					break;
+
+				case NL80211_ATTR_CQM_BEACON_LOSS_EVENT:
+					l_debug("Beacon lost event");
+					break;
+
 				case NL80211_ATTR_CQM_RSSI_LEVEL:
 					if (len != 4)
 						continue;
 
 					rssi_val = (int32_t *) data;
 					break;
+				default:
+					l_debug("Unknown CQM event: %d", type);
 				}
 			}
 
@@ -1106,10 +1120,14 @@ static void netdev_cqm_event(struct l_genl_msg *msg, struct netdev *netdev)
 	}
 
 	if (rssi_event) {
-		if (rssi_val)
+		if (rssi_val) {
+			l_debug("Signal change event (above=%d signal=%d)",
+							*rssi_event, *rssi_val);
 			netdev_cqm_event_rssi_value(netdev, *rssi_val);
-		else
+		} else {
+			l_debug("Signal change event (above=%d)", *rssi_event);
 			netdev_cqm_event_rssi_threshold(netdev, *rssi_event);
+		}
 	}
 }
 
-- 
2.25.1

