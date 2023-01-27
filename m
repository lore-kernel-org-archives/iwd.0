Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535F7522D
	for <iwd@lists.linux.dev>; Fri, 27 Jan 2023 23:33:31 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id h12so6365133wrv.10
        for <iwd@lists.linux.dev>; Fri, 27 Jan 2023 15:33:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bPfvtTKefW9D5MTT7P2Peq9kdMmemkMTpd6pyj45djU=;
        b=Q5SKQ45kE6gtd2XT/J+6Lr9wkOdt0I5xq/9OAR2c5MQMqQvAWBTenLysyfCFQOi6z4
         xdNINyPmcgWjzPzn6nT71at0bWkE8LNUD0DHSR4Z1Czmy5cZkMjxOvWMXUUHlBOy7Of+
         mqxQHswj9+Vt4++lielyUUmFw42grcG9ieG8EQclalI5LceS8RzgyEnM4rJ+P9YZfyOn
         JNxN4gQDmm/LuqUeXBC27QM/9OCaz+WSEAeCjEyoONLn3VYnCntTGKb4E0TMDWAXa+8/
         6Vnho1xVoY/r6AmMyX2hl0yZ5nl5ryf2/obk9d6etX+Lh6KDNO2tAzXvoCU2NYkPC/Nz
         tJ4Q==
X-Gm-Message-State: AO0yUKWi07dgXoZAks98a9Hx37WXJRhFiTCT5YMcEnQ2L3owmRvTZF47
	qaMP35jJbGnykcEl5noj0zQGOs3qnZE=
X-Google-Smtp-Source: AK7set9YbjH5CnuBDz8P6wuTJnaeo/KOShgmhgn7k0ZSZiSvX7nZlICmo5hDRFe/+A1uTxmeADOi5g==
X-Received: by 2002:adf:e50c:0:b0:2bf:b33b:fb7a with SMTP id j12-20020adfe50c000000b002bfb33bfb7amr12009590wrm.25.1674862408726;
        Fri, 27 Jan 2023 15:33:28 -0800 (PST)
Received: from iss.ger.corp.intel.com ([82.213.230.158])
        by smtp.gmail.com with ESMTPSA id m14-20020a5d6a0e000000b002bfd09f2ca6sm3216498wru.3.2023.01.27.15.33.27
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 15:33:27 -0800 (PST)
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
To: iwd@lists.linux.dev
Subject: [PATCH 1/2] eap-tls: Drop cached session when phase2 fails
Date: Sat, 28 Jan 2023 00:33:22 +0100
Message-Id: <20230127233323.3317642-1-andrew.zaborowski@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If we have a TLS session cached from this attempt or a previous
successful connection attempt but the overall EAP method fails, forget
the session to improve the chances that authentication succeeds on the
next attempt considering that some authenticators strangely allow
resumption but can't handle it all the way to EAP method success.
Logically the session resumption in the TLS layers on the server should
be transparent to the EAP layers so I guess those may be failed
attempts to further optimise phase 2 when the server thinks it can
already trust the client.
---
 src/eap-tls-common.c | 52 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 47 insertions(+), 5 deletions(-)

diff --git a/src/eap-tls-common.c b/src/eap-tls-common.c
index 784a57ee..e21e215b 100644
--- a/src/eap-tls-common.c
+++ b/src/eap-tls-common.c
@@ -115,6 +115,7 @@ struct eap_tls_state {
 
 	bool expecting_frag_ack:1;
 	bool tunnel_ready:1;
+	bool tls_session_resumed:1;
 
 	struct l_queue *ca_cert;
 	struct l_certchain *client_cert;
@@ -129,8 +130,11 @@ static struct l_settings *eap_tls_session_cache;
 static eap_tls_session_cache_load_func_t eap_tls_session_cache_load;
 static eap_tls_session_cache_sync_func_t eap_tls_session_cache_sync;
 
-static void __eap_tls_common_state_reset(struct eap_tls_state *eap_tls)
+static void __eap_tls_common_state_reset(struct eap_state *eap)
 {
+	struct eap_tls_state *eap_tls = eap_get_data(eap);
+	const char *peer_id;
+
 	eap_tls->version_negotiated = EAP_TLS_VERSION_NOT_NEGOTIATED;
 	eap_tls->method_completed = false;
 	eap_tls->phase2_failed = false;
@@ -145,6 +149,41 @@ static void __eap_tls_common_state_reset(struct eap_tls_state *eap_tls)
 	if (eap_tls->tunnel)
 		l_tls_reset(eap_tls->tunnel);
 
+	/*
+	 * Drop the TLS session cache for this peer if the overall EAP
+	 * method didn't succeed.
+	 *
+	 * Additionally if the session was cached previously, meaning
+	 * that we've had a successful authentication at least once before,
+	 * and we now used session resumption successfully and the method
+	 * failed, become suspicious of this server's TLS session
+	 * resumption support.  Some authenticators strangely allow
+	 * resumption but can't handle it all the way to EAP method
+	 * success.  This improves the chances that authentication
+	 * succeeds on the next attempt.
+	 *
+	 * Drop the cache even if we have no indication that the
+	 * method failed but it just didn't succeed, to handle cases like
+	 * the server getting stuck and a timout occuring at a higher
+	 * layer.  The risk is that we may occasionally flush the session
+	 * data when there was only a momentary radio issue, invalid
+	 * phase2 credentials or decision to abort.  Those are not hot
+	 * paths.
+	 *
+	 * Note: TLS errors before the ready callback are handled in l_tls.
+	 */
+	peer_id = eap_get_peer_id(eap);
+	if (peer_id && eap_tls_session_cache && !eap_method_is_success(eap) &&
+			l_settings_has_group(eap_tls_session_cache, peer_id)) {
+		eap_tls_forget_peer(peer_id);
+
+		if (eap_tls->tls_session_resumed)
+			l_warn("EAP: method did not finish after successful TLS"
+				" session resumption.");
+	}
+
+	eap_tls->tls_session_resumed = false;
+
 	eap_tls->tx_frag_offset = 0;
 	eap_tls->tx_frag_last_len = 0;
 
@@ -187,7 +226,7 @@ bool eap_tls_common_state_reset(struct eap_state *eap)
 {
 	struct eap_tls_state *eap_tls = eap_get_data(eap);
 
-	__eap_tls_common_state_reset(eap_tls);
+	__eap_tls_common_state_reset(eap);
 
 	if (eap_tls->variant_ops->reset)
 		eap_tls->variant_ops->reset(eap_tls->variant_data);
@@ -199,7 +238,7 @@ void eap_tls_common_state_free(struct eap_state *eap)
 {
 	struct eap_tls_state *eap_tls = eap_get_data(eap);
 
-	__eap_tls_common_state_reset(eap_tls);
+	__eap_tls_common_state_reset(eap);
 
 	eap_set_data(eap, NULL);
 
@@ -244,7 +283,9 @@ static void eap_tls_tunnel_ready(const char *peer_identity, void *user_data)
 {
 	struct eap_state *eap = user_data;
 	struct eap_tls_state *eap_tls = eap_get_data(eap);
-	bool resumed = l_tls_get_session_resumed(eap_tls->tunnel);
+
+	eap_tls->tls_session_resumed =
+		l_tls_get_session_resumed(eap_tls->tunnel);
 
 	if (eap_tls->ca_cert && !peer_identity) {
 		l_error("%s: TLS did not verify AP identity",
@@ -265,7 +306,8 @@ static void eap_tls_tunnel_ready(const char *peer_identity, void *user_data)
 	if (!eap_tls->variant_ops->tunnel_ready)
 		return;
 
-	if (!eap_tls->variant_ops->tunnel_ready(eap, peer_identity, resumed))
+	if (!eap_tls->variant_ops->tunnel_ready(eap, peer_identity,
+						eap_tls->tls_session_resumed))
 		l_tls_close(eap_tls->tunnel);
 }
 
-- 
2.34.1

