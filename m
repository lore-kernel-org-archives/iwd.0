Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CCC1094D
	for <iwd@lists.linux.dev>; Wed, 28 Jun 2023 20:20:42 +0000 (UTC)
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-765a169001eso11363685a.3
        for <iwd@lists.linux.dev>; Wed, 28 Jun 2023 13:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687983641; x=1690575641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SqYFtqpJIjv73xYkZBWWjOxcCdTR2r+wujQNQdjD9Es=;
        b=A1ZI/NlS/QD+a7dqMf5ezKkNC6YhtjRPhk0ghZvP2+UQgNQHDJUOJaWZYc86uyh4i6
         /Mp8UoSFesaq0+xz0RjPSc+jNn4o4ZEISkrFxfuM6pI+5g1iMF939S76E1hxZ4jt6mpM
         SkNKzhybkVzNZn4RHj5yZB2mtbZK6FrM0CZfqNtZuE8ieEyeKhOCvwcjURITQNuXP/Q/
         FVfRS7Wwb6Qt6+p0CI52Zkz+wDXjJMrKHsPbvCzSBRUM7Gl20qx1Rrj8GdZGNNj3ABH7
         E0Q00N/wI901rde/Uje1J9phM3SoRIJOfcJYJpguGd4fG0j2FYfWCBrAXoOVWVl95b7s
         kSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687983641; x=1690575641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SqYFtqpJIjv73xYkZBWWjOxcCdTR2r+wujQNQdjD9Es=;
        b=EWe+OGOKgGalhPDFSF7LaXNUz3MjgsF7DmNyZExwcii/AFuPVVE7MSCHIBni7GVOIT
         57OU0ALgdIKL+TVPCTfwbniq2WIqMdwt4qybuYeXjn5CH9lX2H8ywxX5TvE2Jjt1UcD/
         ln8MlKuhgXhHVAkM3TZpOePfJEhLEHmWw+hztegQjRKRzKWN4OPNQhFZW3RbE4S0Yxjt
         hsykoaxOE4AxmGZwKHNdI0lmciCKp6+uJvVnGfTjq64HNcsrdSIuTy8Clm0iO2l2yHah
         buh63/y8+uellvHpW2hLHZtYsDVXg/4VY3rX5Z8t6JYOwj3ZxnO0uNs9LZcTtPW6N0vW
         TB2w==
X-Gm-Message-State: AC+VfDwTJvZMq/LGkgfXBtOL3f5F6PzkiwMfPvMr2dDvWZ3xRaSsmSAg
	Xc5zTU++N9Se1OG3waOBENa8xpYkMsc=
X-Google-Smtp-Source: ACHHUZ7Uz9LcJVWqzrrdhIQcabo8u4aS6VhsjR5BXxx3P1S63+plmmDHW5KY8Q1uIRaKwaeMYrYJnw==
X-Received: by 2002:a05:620a:bd3:b0:765:a678:977c with SMTP id s19-20020a05620a0bd300b00765a678977cmr11428832qki.67.1687983641465;
        Wed, 28 Jun 2023 13:20:41 -0700 (PDT)
Received: from LOCLAP699.rst-01.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id i4-20020a05620a144400b0076728319575sm672557qkl.27.2023.06.28.13.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 13:20:41 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/3] hwsim: handle ADD/DEL_MAC_ADDR events
Date: Wed, 28 Jun 2023 13:20:33 -0700
Message-Id: <20230628202033.2320994-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230628202033.2320994-1-prestwoj@gmail.com>
References: <20230628202033.2320994-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Handling these events notifies hwsim of address changes for interface
creation/removal outside the initial namespace as well as address
changes due to scanning address randomization.

Interfaces that hwsim already knows about are still handled via
nl80211. But any interfaces not known when ADD/DEL_MAC_ADDR events
come will be treated specially.

For ADD, a dummy interface object will be created and added to the
queue. This lets the frame processing match the destination address
correctly. This can happen both for scan randomization and interface
creation outside of the initial namespace.

For the DEL event we handle similarly and don't touch any interfaces
found via nl80211 (i.e. have a 'name') but need to also be careful
with the dummy interfaces that were created outside the initial
namespace. We want to keep these around but scanning MAC changes can
also delete them. This is why a reference count was added so scanning
doesn't cause a removal.

For example, the following sequence:

ADD_MAC_ADDR (interface creation)
ADD_MAC_ADDR (scanning started)
DEL_MAC_ADDR (scanning done)
---
 tools/hwsim.c | 132 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 132 insertions(+)

diff --git a/tools/hwsim.c b/tools/hwsim.c
index 2fee9b19..5cb28624 100644
--- a/tools/hwsim.c
+++ b/tools/hwsim.c
@@ -440,6 +440,7 @@ struct interface_info_rec {
 	uint8_t addr[ETH_ALEN];
 	char *name;
 	uint32_t iftype;
+	int ref;
 };
 
 static struct l_queue *radio_info;
@@ -515,6 +516,14 @@ static bool interface_info_match_id(const void *a, const void *b)
 	return rec->id == id;
 }
 
+static bool interface_info_match_addr(const void *a, const void *b)
+{
+	const struct interface_info_rec *rec = a;
+	const uint8_t *addr = b;
+
+	return memcmp(rec->addr, addr, ETH_ALEN) == 0;
+}
+
 static const char *radio_get_path(const struct radio_info_rec *rec)
 {
 	static char path[15];
@@ -1682,6 +1691,123 @@ static void hwsim_frame_event(struct l_genl_msg *msg)
 	process_frame(frame);
 }
 
+static bool get_tx_rx_addrs(struct l_genl_msg *msg, const uint8_t **tx_out,
+				const uint8_t **rx_out)
+{
+	struct l_genl_attr attr;
+	uint16_t type, len;
+	const void *data;
+	const uint8_t *tx = NULL, *rx = NULL;
+
+	if (!l_genl_attr_init(&attr, msg))
+		return false;
+
+	while (l_genl_attr_next(&attr, &type, &len, &data)) {
+		switch (type) {
+		case HWSIM_ATTR_ADDR_TRANSMITTER:
+			if (len != ETH_ALEN)
+				return false;
+
+			tx = data;
+			break;
+		case HWSIM_ATTR_ADDR_RECEIVER:
+			if (len != ETH_ALEN)
+				return false;
+
+			rx = data;
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (!tx || !rx)
+		return false;
+
+	*tx_out = tx;
+	*rx_out = rx;
+
+	return true;
+}
+
+static void hwsim_add_mac_event(struct l_genl_msg *msg)
+{
+	const uint8_t *tx = NULL, *rx = NULL;
+	struct radio_info_rec *radio_rec;
+	struct interface_info_rec *interface_rec;
+
+	if (!get_tx_rx_addrs(msg, &tx, &rx))
+		return;
+
+	/* No radio matches the TX address, hwsim must not have created it */
+	radio_rec = l_queue_find(radio_info, radio_info_match_addr1, tx);
+	if (!radio_rec)
+		return;
+
+	interface_rec = l_queue_find(interface_info,
+					interface_info_match_addr, rx);
+	if (interface_rec) {
+		/* Existing interface, address changes handled via nl80211 */
+		if (interface_rec->name)
+			return;
+
+		/*
+		 * Transient/dummy interface we already know about. This likely
+		 * was created, then a scan changed the address temporarily.
+		 * Reflect this change and increment the ref so the following
+		 * DEL event doesn't destroy it
+		 */
+		__atomic_fetch_add(&interface_rec->ref, 1, __ATOMIC_SEQ_CST);
+		memcpy(interface_rec->addr, rx, ETH_ALEN);
+		return;
+	}
+
+	/*
+	 * Create a dummy interface entry for this address that only contains
+	 * the radio and address. This is either a transient entry due to scan
+	 * randomization or an interface created outside this namespace.
+	 */
+	interface_rec = l_new(struct interface_info_rec, 1);
+	interface_rec->radio_rec = radio_rec;
+	interface_rec->ref = 1;
+	memcpy(interface_rec->addr, rx, ETH_ALEN);
+
+	l_queue_push_tail(interface_info, interface_rec);
+}
+
+static void hwsim_del_mac_event(struct l_genl_msg *msg)
+{
+	const uint8_t *tx = NULL, *rx = NULL;
+	struct radio_info_rec *radio_rec;
+	struct interface_info_rec *interface_rec;
+
+	if (!get_tx_rx_addrs(msg, &tx, &rx))
+		return;
+
+	/* No radio matches the TX address, hwsim must not have created it */
+	radio_rec = l_queue_find(radio_info, radio_info_match_addr1, tx);
+	if (!radio_rec)
+		return;
+
+	interface_rec = l_queue_find(interface_info,
+						interface_info_match_addr, rx);
+	if (!interface_rec)
+		return;
+
+	/*
+	 * This change is handled via nl80211 so we don't want to touch this
+	 * interface here.
+	 */
+	if (interface_rec->name)
+		return;
+
+	if (__atomic_sub_fetch(&interface_rec->ref, 1, __ATOMIC_SEQ_CST))
+		return;
+
+	l_queue_remove(interface_info, interface_rec);
+	l_free(interface_rec);
+}
+
 static void hwsim_unicast_handler(struct l_genl_msg *msg, void *user_data)
 {
 	uint8_t cmd;
@@ -1695,6 +1821,12 @@ static void hwsim_unicast_handler(struct l_genl_msg *msg, void *user_data)
 	case HWSIM_CMD_FRAME:
 		hwsim_frame_event(msg);
 		break;
+	case HWSIM_CMD_ADD_MAC_ADDR:
+		hwsim_add_mac_event(msg);
+		break;
+	case HWSIM_CMD_DEL_MAC_ADDR:
+		hwsim_del_mac_event(msg);
+		break;
 	default:
 		break;
 	}
-- 
2.25.1

