Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D975C7E
	for <iwd@lists.linux.dev>; Thu, 16 Jun 2022 00:02:43 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id m39-20020a05600c3b2700b0039c511ebbacso1971128wms.3
        for <iwd@lists.linux.dev>; Wed, 15 Jun 2022 17:02:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IcX2R8FklC2JIsP5sECfz8s5rM4VE3SuVHPK/uFGlwI=;
        b=oxDO6+e5hBduP9FpAv2wEQiHkWvgSOGkxQDA+tYpb0bIzNshzuu0BiJcjcDLVfPW8b
         GZ85Sevzxfwzr2W0KwvrRMhQQ3SP1Nv9OYnbKtiQcpyQgdDTnmyqVBZKS7mBXMtbpuI6
         6JnVpH6gJvAG2M9gTE0R6KdAkGA+jRdMNqJ/LEQJ3AsDF2MaEra+g7FpCYtM3uAF/ouI
         iNw35WViqQHCasF9gBf3gjLoSGT6LMsEA36ALfFM3Bq8SVY6Le9MSIFUjgfgW4mQWaf0
         LDntEVMu8x5Tpl6YIwhuaAveEum59tLyibWjX+b8m6F4YgdW7wh6Vjk3mNWGbnH2Tuu+
         FKeA==
X-Gm-Message-State: AOAM533Ie2D2z7mHj03WN7ZxvOMdNJjVdmxIuppBDyjZZWMK4jDp1xxR
	0eBG60qLVHx7a8cE8O7+hBYc8WwB/G4=
X-Google-Smtp-Source: ABdhPJx/mK4QIJ/TgiqAjNCGccGQfD2oXQ13/Vr2tMQKOnMdeX+bGpAa5MZGYHxJxEj575dtQJjPbQ==
X-Received: by 2002:a1c:4c12:0:b0:39c:6750:be17 with SMTP id z18-20020a1c4c12000000b0039c6750be17mr12588942wmf.21.1655337761897;
        Wed, 15 Jun 2022 17:02:41 -0700 (PDT)
Received: from iss.Home ([82.213.231.20])
        by smtp.gmail.com with ESMTPSA id az10-20020adfe18a000000b00210396b2eaesm337452wrb.45.2022.06.15.17.02.41
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 17:02:41 -0700 (PDT)
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
To: iwd@lists.linux.dev
Subject: [PATCH 04/15] monitor: Print netlink errors from Extended ACKs if available
Date: Thu, 16 Jun 2022 02:02:20 +0200
Message-Id: <20220616000231.1966008-4-andrew.zaborowski@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220616000231.1966008-1-andrew.zaborowski@intel.com>
References: <20220616000231.1966008-1-andrew.zaborowski@intel.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 monitor/nlmon.c | 55 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 38 insertions(+), 17 deletions(-)

diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index 34c5eed6..ff23140d 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -50,6 +50,7 @@
 #include "linux/nl80211.h"
 
 #include "ell/useful.h"
+#include "ell/netlink-private.h"
 #include "src/ie.h"
 #include "src/mpdu.h"
 #include "src/eapol.h"
@@ -5332,15 +5333,7 @@ static const struct attr_entry rekey_table[] = {
 	{ }
 };
 
-#define NLA_OK(nla,len)         ((len) >= (int) sizeof(struct nlattr) && \
-				(nla)->nla_len >= sizeof(struct nlattr) && \
-				(nla)->nla_len <= (len))
-#define NLA_NEXT(nla,attrlen)	((attrlen) -= NLA_ALIGN((nla)->nla_len), \
-				(struct nlattr*)(((char*)(nla)) + \
-				NLA_ALIGN((nla)->nla_len)))
-
-#define NLA_LENGTH(len)		(NLA_ALIGN(sizeof(struct nlattr)) + (len))
-#define NLA_DATA(nla)		((void*)(((char*)(nla)) + NLA_LENGTH(0)))
+#undef NLA_PAYLOAD
 #define NLA_PAYLOAD(nla)	((int)((nla)->nla_len - NLA_LENGTH(0)))
 
 static void print_supported_commands(unsigned int level, const char *label,
@@ -6835,7 +6828,7 @@ static void netlink_str(char *str, size_t size,
 	}
 }
 
-static void print_message(struct nlmon *nlmon, const struct timeval *tv,
+static bool print_message(struct nlmon *nlmon, const struct timeval *tv,
 						enum msg_type type,
 						uint16_t flags, int status,
 						uint8_t cmd, uint8_t version,
@@ -6848,11 +6841,11 @@ static void print_message(struct nlmon *nlmon, const struct timeval *tv,
 	bool out = false;
 
 	if (nlmon->nowiphy && (cmd == NL80211_CMD_NEW_WIPHY))
-		return;
+		return false;
 
 	if (nlmon->noscan && ((cmd == NL80211_CMD_NEW_SCAN_RESULTS) ||
 			(cmd == NL80211_CMD_TRIGGER_SCAN)))
-		return;
+		return false;
 
 	switch (type) {
 	case MSG_REQUEST:
@@ -6911,6 +6904,8 @@ static void print_message(struct nlmon *nlmon, const struct timeval *tv,
 			print_field("Status: %d", status);
 		break;
 	}
+
+	return true;
 }
 
 struct nlmon_req_match {
@@ -6978,12 +6973,17 @@ static void nlmon_message(struct nlmon *nlmon, const struct timeval *tv,
 			enum msg_type type;
 			struct nlmsgerr *err;
 			int status;
+			bool print;
+			const char *err_str = NULL;
+			uint32_t err_offset = -1U;
 
 			switch (nlmsg->nlmsg_type) {
 			case NLMSG_ERROR:
 				type = MSG_RESPONSE;
 				err = NLMSG_DATA(nlmsg);
 				status = -err->error;
+				netlink_parse_ext_ack_error(nlmsg, &err_str,
+								&err_offset);
 				break;
 			case NLMSG_DONE:
 				type = MSG_COMPLETE;
@@ -6994,10 +6994,18 @@ static void nlmon_message(struct nlmon *nlmon, const struct timeval *tv,
 			}
 
 			store_message(nlmon, tv, nlmsg);
-			print_message(nlmon, tv, type, nlmsg->nlmsg_flags, status,
+			print = print_message(nlmon, tv, type,
+						nlmsg->nlmsg_flags, status,
 						req->cmd, req->version,
 						NULL, sizeof(status));
 			nlmon_req_free(req);
+
+			if (err_str && print)
+				print_field("Extended error: %s", err_str);
+
+			if (err_offset != -1U && print)
+				print_field("Offending element offset: %i "
+						"bytes", (int) err_offset);
 		}
 		return;
 	}
@@ -7795,6 +7803,8 @@ static void print_nlmsg(const struct timeval *tv, const struct nlmsghdr *nlmsg)
 {
 	struct nlmsgerr *err;
 	int status;
+	const char *err_str = NULL;
+	uint32_t err_offset = -1U;
 
 	print_nlmsghdr(tv, nlmsg);
 
@@ -7802,11 +7812,22 @@ static void print_nlmsg(const struct timeval *tv, const struct nlmsghdr *nlmsg)
 	case NLMSG_ERROR:
 		err = NLMSG_DATA(nlmsg);
 		status = err->error;
-		if (status < 0)
-			print_field("Error: %d (%s)",
-						status, strerror(-status));
-		else
+		if (status >= 0) {
 			print_field("ACK: %d", status);
+			break;
+		}
+
+		print_field("Error: %d (%s)", status, strerror(-status));
+
+		netlink_parse_ext_ack_error(nlmsg, &err_str, &err_offset);
+
+		if (err_str)
+			print_field("Extended error: %s", err_str);
+
+		if (err_offset != -1U)
+			print_field("Offending element offset: %i bytes",
+					(int) err_offset);
+
 		break;
 
 	case NLMSG_DONE:
-- 
2.34.1

