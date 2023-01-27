Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCA815AC
	for <iwd@lists.linux.dev>; Fri, 27 Jan 2023 12:31:51 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id q5so4874236wrv.0
        for <iwd@lists.linux.dev>; Fri, 27 Jan 2023 04:31:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eyulQvEFqhgNtWHWtHTiZbrBHfmwCUYKD1GCUyIxNsI=;
        b=IWoNBsCotboNnU714AJpTMCrK5G+EuSzJd44OF9EmEu94DP4Hh5rfy5Po9aa5lc7Fb
         CwTcpwd7SQFudis0O1rK5LdwBmXzFkFyeaf63m8upxwSNSDGUVSOE2JDO9qIfzLbvJXU
         +k5lICapXHMWIC1upX+wmhyDjpL7lugwgS7iendc8ak/JIyhZljdxABVCYlzQaUlRwUM
         K0m1KCahJCAYew+t0Nf+mMH3o+a8XsEnfrbcti6DEO5yfANJhvoGU6pbTOfqWttz6a5o
         CM2KOUD6a4LSlRV2wtii8jwwvDQo5QrFQgqbkqShqypo+HiRHMrLdp/rkUZDZ48V4uhc
         JM/g==
X-Gm-Message-State: AO0yUKUndfjcUyVyfuLhAhctOPr29gYaF++ntb4l5Q7x/2uta4XHD5Ud
	07KGbwlhD9LpLMV/sUWyLTQUlg6j4eg=
X-Google-Smtp-Source: AK7set+FjV8wscWk6HR7z8NEYOMvVO/vx6oc4isuzoVuUcFX3EBekjxvaaoHAno8ViDoYFbju4SebA==
X-Received: by 2002:a05:6000:1105:b0:2bf:b77c:df78 with SMTP id z5-20020a056000110500b002bfb77cdf78mr9026839wrw.20.1674822709301;
        Fri, 27 Jan 2023 04:31:49 -0800 (PST)
Received: from localhost.localdomain ([82.213.230.158])
        by smtp.gmail.com with ESMTPSA id c7-20020adffb47000000b002ba2646fd30sm4472161wrs.36.2023.01.27.04.31.48
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 04:31:48 -0800 (PST)
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
To: iwd@lists.linux.dev
Subject: [PATCH 1/2] eap-tls: Drop cached session when phase2 fails
Date: Fri, 27 Jan 2023 13:31:36 +0100
Message-Id: <20230127123137.3274713-1-andrew.zaborowski@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If we used TLS session resumption successfully but the overall EAP method
failed, forget the session to improve the chances that authentication
succeeds on the next attempt considering that some authenticators
strangely allow resumption but can't handle it all the way to EAP method
success.  Logically the session resumption in the TLS layers on the
server should be transparent to the EAP layers so I guess those may be
failed attempts to further optimise phase 2 when the server thinks it can
already trust the client.
---
 src/eap-tls-common.c | 37 ++++++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/src/eap-tls-common.c b/src/eap-tls-common.c
index 784a57ee..b909d0cc 100644
--- a/src/eap-tls-common.c
+++ b/src/eap-tls-common.c
@@ -115,6 +115,7 @@ struct eap_tls_state {
 
 	bool expecting_frag_ack:1;
 	bool tunnel_ready:1;
+	bool tls_session_resumed:1;
 
 	struct l_queue *ca_cert;
 	struct l_certchain *client_cert;
@@ -129,8 +130,10 @@ static struct l_settings *eap_tls_session_cache;
 static eap_tls_session_cache_load_func_t eap_tls_session_cache_load;
 static eap_tls_session_cache_sync_func_t eap_tls_session_cache_sync;
 
-static void __eap_tls_common_state_reset(struct eap_tls_state *eap_tls)
+static void __eap_tls_common_state_reset(struct eap_state *eap)
 {
+	struct eap_tls_state *eap_tls = eap_get_data(eap);
+
 	eap_tls->version_negotiated = EAP_TLS_VERSION_NOT_NEGOTIATED;
 	eap_tls->method_completed = false;
 	eap_tls->phase2_failed = false;
@@ -145,6 +148,27 @@ static void __eap_tls_common_state_reset(struct eap_tls_state *eap_tls)
 	if (eap_tls->tunnel)
 		l_tls_reset(eap_tls->tunnel);
 
+	/*
+	 * If we used TLS session resumption successfully but the overall
+	 * EAP method failed, forget the session to improve the chances
+	 * that authentication succeeds on the next attempt considering
+	 * that some authenticators strangely allow resumption but can't
+	 * handle it all the way to EAP method success.  Do this even if
+	 * we have no indication that the method failed but it just didn't
+	 * succeed, to handle cases like the server getting stuck and a
+	 * timout occuring at a higher layer.  The risk is that we may
+	 * occasionally flush the session data when there was only a
+	 * momentary radio issue, invalid phase2 credentials or decision
+	 * to abort.  Those are not hot paths.
+	 *
+	 * TLS errors before the ready callback are already handled in
+	 * l_tls so we only need to look at .tls_session_resumed here.
+	 */
+	if (eap_tls->tls_session_resumed && !eap_method_is_success(eap))
+		eap_tls_forget_peer(eap_get_peer_id(eap));
+
+	eap_tls->tls_session_resumed = false;
+
 	eap_tls->tx_frag_offset = 0;
 	eap_tls->tx_frag_last_len = 0;
 
@@ -187,7 +211,7 @@ bool eap_tls_common_state_reset(struct eap_state *eap)
 {
 	struct eap_tls_state *eap_tls = eap_get_data(eap);
 
-	__eap_tls_common_state_reset(eap_tls);
+	__eap_tls_common_state_reset(eap);
 
 	if (eap_tls->variant_ops->reset)
 		eap_tls->variant_ops->reset(eap_tls->variant_data);
@@ -199,7 +223,7 @@ void eap_tls_common_state_free(struct eap_state *eap)
 {
 	struct eap_tls_state *eap_tls = eap_get_data(eap);
 
-	__eap_tls_common_state_reset(eap_tls);
+	__eap_tls_common_state_reset(eap);
 
 	eap_set_data(eap, NULL);
 
@@ -244,7 +268,9 @@ static void eap_tls_tunnel_ready(const char *peer_identity, void *user_data)
 {
 	struct eap_state *eap = user_data;
 	struct eap_tls_state *eap_tls = eap_get_data(eap);
-	bool resumed = l_tls_get_session_resumed(eap_tls->tunnel);
+
+	eap_tls->tls_session_resumed =
+		l_tls_get_session_resumed(eap_tls->tunnel);
 
 	if (eap_tls->ca_cert && !peer_identity) {
 		l_error("%s: TLS did not verify AP identity",
@@ -265,7 +291,8 @@ static void eap_tls_tunnel_ready(const char *peer_identity, void *user_data)
 	if (!eap_tls->variant_ops->tunnel_ready)
 		return;
 
-	if (!eap_tls->variant_ops->tunnel_ready(eap, peer_identity, resumed))
+	if (!eap_tls->variant_ops->tunnel_ready(eap, peer_identity,
+						eap_tls->tls_session_resumed))
 		l_tls_close(eap_tls->tunnel);
 }
 
-- 
2.34.1

