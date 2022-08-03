Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC284A26
	for <iwd@lists.linux.dev>; Wed,  3 Aug 2022 21:36:48 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id p8so17557840plq.13
        for <iwd@lists.linux.dev>; Wed, 03 Aug 2022 14:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=CYlxlKQU0Oo089JjqVpjHqwWqejqu67zM2tu84NxMS4=;
        b=VsmLRCkHEs4BW4fnRlOa6PrsHKX0RiM1HLtJQNxFWpnbSn18hhryK5riHnRCD2iuOi
         yCXN6g2U11zBUxw9WmFRBCEJBNQ2FZbpWqNORxDxlWa2u1KiTXT+cRo3i+q2fWC760Lm
         qhtpuEm1OB4EYtv+V8figFJ6zGi7UncHYVOYEz72+fWIF+pToA7HBlsvYUDCA4UXkHEZ
         rSyw7/7FLfMvetk3m6FIfrxIYP5bFhtGYExFV5uh5SF7PdbQlX4zSKsUwqbefYvLQyH4
         3B9gBxrcRr7DJPJ7RG1E+pto0pXz30vn367LQpD70PmsiJrtKNENfsIjvdY7nhUJZLQz
         gUFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=CYlxlKQU0Oo089JjqVpjHqwWqejqu67zM2tu84NxMS4=;
        b=jnQrxuWDtYzN7P4rpWDOoy9OZ9hQpGRxhiJzcGcfPOcVIcaKbsf40deHLzwBo08dj/
         KC3lvTq+1ZCTOwbcGuJDgJEzBLXPykH7NXyjPzqGcgX3ieAVIs6zo9R3WYWdVExtibVv
         EVmqdftplc4iH27lg1zZ4MvXxtEu+fY3gL1mvvpqhfmJXhSq6bsCdm3NwNFldZnGPb6v
         x6ORi/lHrgnmXWzpooXhKzy1ZeK73kJ/BTqyiS/tHR/ZxsWt8Vnmk3vXw6tlcxt6RfWq
         C1kYVnNwJO4iLNXs5yFj/bA978KOIZC0vQcAE+AH6XEBStwvxOAaEKxksOVm55JSV0Gq
         mMcg==
X-Gm-Message-State: ACgBeo2XGqnlfZI0X5nBUE/TOjr3rPLCvs2PpzxjEDf+SuCxUOwpZVbN
	wLj5bAvHDhWgpA6rxjyXMjUqtZRiQAU=
X-Google-Smtp-Source: AA6agR6AJsTxCCrYf8m+XC7Mkf8K/+8s06K0RViASOB1IHOlvTWdHviq4VPqkCv7aeGmCe2W+bMX2A==
X-Received: by 2002:a17:90a:558f:b0:1f5:bbc:c58e with SMTP id c15-20020a17090a558f00b001f50bbcc58emr6884657pji.102.1659562607483;
        Wed, 03 Aug 2022 14:36:47 -0700 (PDT)
Received: from jprestwo-xps.none ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id b13-20020a65578d000000b00419fc2c27d8sm11527066pgr.43.2022.08.03.14.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 14:36:47 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 02/13] scan: track scanned frequencies for entire request
Date: Wed,  3 Aug 2022 14:36:33 -0700
Message-Id: <20220803213644.277534-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220803213644.277534-1-prestwoj@gmail.com>
References: <20220803213644.277534-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The NEW_SCAN_RESULTS handling was written to only parse the frequency
list if there were no additional scan commands to send. This results in
the scan callback containing frequencies of only the last CMD_TRIGGER.

Until now this worked fine because a) the queue is only used for hidden
networks and b) frequencies were never defined by any callers scanning
for hidden networks (e.g. dbus/periodic scans).

Soon the scan command queue will be used to break up scan requests
meaning only the last scan request frequencies would be used in the
callback, breaking the logic in station.

Now the NEW_SCAN_RESULTS case will parse the frequencies for each scan
command rather than only the last.
---
 src/scan.c | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/src/scan.c b/src/scan.c
index 03e5b8d9..b666ba2e 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -98,6 +98,12 @@ struct scan_request {
 	/* The time the current scan was started. Reported in TRIGGER_SCAN */
 	uint64_t start_time_tsf;
 	struct wiphy_radio_work_item work;
+	/*
+	 * List of frequencies scanned so far. Since the NEW_SCAN_RESULTS event
+	 * contains frequencies of only the last CMD_TRIGGER we need to parse
+	 * and save these since there may be additional scan commands to run.
+	 */
+	struct scan_freq_set *freqs_scanned;
 };
 
 struct scan_context {
@@ -125,7 +131,6 @@ struct scan_context {
 struct scan_results {
 	struct scan_context *sc;
 	struct l_queue *bss_list;
-	struct scan_freq_set *freqs;
 	uint64_t time_stamp;
 	struct scan_request *sr;
 };
@@ -159,6 +164,8 @@ static void scan_request_free(struct wiphy_radio_work_item *item)
 
 	l_queue_destroy(sr->cmds, (l_queue_destroy_func_t) l_genl_msg_unref);
 
+	scan_freq_set_free(sr->freqs_scanned);
+
 	l_free(sr);
 }
 
@@ -609,6 +616,7 @@ static struct scan_request *scan_request_new(struct scan_context *sc,
 	sr->destroy = destroy;
 	sr->passive = passive;
 	sr->cmds = l_queue_new();
+	sr->freqs_scanned = scan_freq_set_new();
 
 	return sr;
 }
@@ -1624,14 +1632,11 @@ fail:
 	return NULL;
 }
 
-static struct scan_freq_set *scan_parse_attr_scan_frequencies(
-						struct l_genl_attr *attr)
+static void scan_parse_attr_scan_frequencies(struct l_genl_attr *attr,
+						struct scan_freq_set *set)
 {
 	uint16_t type, len;
 	const void *data;
-	struct scan_freq_set *set;
-
-	set = scan_freq_set_new();
 
 	while (l_genl_attr_next(attr, &type, &len, &data)) {
 		uint32_t freq;
@@ -1642,8 +1647,6 @@ static struct scan_freq_set *scan_parse_attr_scan_frequencies(
 		freq = *((uint32_t *) data);
 		scan_freq_set_add(set, freq);
 	}
-
-	return set;
 }
 
 static struct scan_bss *scan_parse_result(struct l_genl_msg *msg,
@@ -1927,14 +1930,12 @@ static void get_scan_done(void *user)
 
 	if (!results->sr || !results->sr->canceled)
 		scan_finished(sc, 0, results->bss_list,
-						results->freqs, results->sr);
+						results->sr->freqs_scanned,
+						results->sr);
 	else
 		l_queue_destroy(results->bss_list,
 				(l_queue_destroy_func_t) scan_bss_free);
 
-	if (results->freqs)
-		scan_freq_set_free(results->freqs);
-
 	l_free(results);
 }
 
@@ -1954,8 +1955,8 @@ static bool scan_parse_flush_flag_from_msg(struct l_genl_msg *msg)
 	return false;
 }
 
-static void scan_parse_new_scan_results(struct l_genl_msg *msg,
-					struct scan_results *results)
+static void scan_parse_result_frequencies(struct l_genl_msg *msg,
+					struct scan_freq_set *freqs)
 {
 	struct l_genl_attr attr, nested;
 	uint16_t type, len;
@@ -1972,8 +1973,7 @@ static void scan_parse_new_scan_results(struct l_genl_msg *msg,
 				break;
 			}
 
-			results->freqs =
-				scan_parse_attr_scan_frequencies(&nested);
+			scan_parse_attr_scan_frequencies(&nested, freqs);
 			break;
 		}
 	}
@@ -2052,8 +2052,11 @@ static void scan_notify(struct l_genl_msg *msg, void *user_data)
 			 */
 			if (l_queue_isempty(sr->cmds))
 				get_results = true;
-			else
+			else {
+				scan_parse_result_frequencies(msg,
+							sr->freqs_scanned);
 				send_next = true;
+			}
 		} else {
 			if (sc->get_scan_cmd_id)
 				break;
@@ -2098,7 +2101,7 @@ static void scan_notify(struct l_genl_msg *msg, void *user_data)
 		results->sr = sr;
 		results->bss_list = l_queue_new();
 
-		scan_parse_new_scan_results(msg, results);
+		scan_parse_result_frequencies(msg, sr->freqs_scanned);
 
 		scan_msg = l_genl_msg_new_sized(NL80211_CMD_GET_SCAN, 8);
 		l_genl_msg_append_attr(scan_msg, NL80211_ATTR_WDEV, 8,
-- 
2.34.3

