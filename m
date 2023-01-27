Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB885234
	for <iwd@lists.linux.dev>; Fri, 27 Jan 2023 23:33:32 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id b7so6397569wrt.3
        for <iwd@lists.linux.dev>; Fri, 27 Jan 2023 15:33:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iKZjb78JIm17+U2V4YbgrzD3JOtP9MS8gj6BDOZ/MdU=;
        b=OAhc84HQXpnBFtiKwGCI50u8RYDqUQiAZC4u4k41tbRAlNct1DAdotRO5qQkzLWB/G
         F8bqf1wa+4ojKWgmvYRsbl+ISrodIgtY7DeD6WOBKK0JpPACh/n8ZKFZQTRpUInX2er+
         Lo1rsseHAzrStlVOMGvpkHXHbDLC6jPWJFNsJmR/gSQdRwISLvIIy9EcIOacI8dvNiXN
         /xN2YomChuYS5tYKhlegbNdDn3dciHlHOsVg2lkr4nzO53XuOj5qaHaehiq0pdhBhpU5
         ASup9oeF2THFJlVLMmXlYKlQz0Kf+7P714RRUAEeUIglmmh6QV3Vlz08FoOfNNfxpDmq
         Nobg==
X-Gm-Message-State: AO0yUKVqZ3ZnP3jf3bVQpmM6KaqkdjpdDDtzU3crOxMHDQqUrt0iYxEm
	SHD6k7baa+FulLV4VckuiHcL/5TrQXE=
X-Google-Smtp-Source: AK7set/ENR2ly0BOHzgpMxWnsxQqrjYnNj436suURT5ZnZA/9p49XFqOepkIo5XS0b5xArMp6WfLPA==
X-Received: by 2002:a5d:5348:0:b0:2bf:b9a4:f688 with SMTP id t8-20020a5d5348000000b002bfb9a4f688mr10671481wrv.23.1674862410489;
        Fri, 27 Jan 2023 15:33:30 -0800 (PST)
Received: from iss.ger.corp.intel.com ([82.213.230.158])
        by smtp.gmail.com with ESMTPSA id m14-20020a5d6a0e000000b002bfd09f2ca6sm3216498wru.3.2023.01.27.15.33.28
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 15:33:29 -0800 (PST)
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
To: iwd@lists.linux.dev
Subject: [PATCH 2/2] eap-tls: Add DisableEAPTLSCache bool setting
Date: Sat, 28 Jan 2023 00:33:23 +0100
Message-Id: <20230127233323.3317642-2-andrew.zaborowski@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230127233323.3317642-1-andrew.zaborowski@intel.com>
References: <20230127233323.3317642-1-andrew.zaborowski@intel.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Seeing that some authenticators can't handle TLS session caching
properly, allow the EAP-TLS-based methods session caching support to be
disabled per-network using a [Settings].DisableEAPTLSCache setting.
Defaults to false.

With the previous commit, authentication should succeed at least every
other attempt.  I'd also expect that EAP-TLS is not usually affected
because there's no phase2, unlike with EAP-PEAP/EAP-TTLS.
---
 src/eap-tls-common.c | 18 ++++++++++++++++--
 src/iwd.network.rst  | 10 ++++++++++
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/src/eap-tls-common.c b/src/eap-tls-common.c
index e21e215b..b621d395 100644
--- a/src/eap-tls-common.c
+++ b/src/eap-tls-common.c
@@ -116,6 +116,7 @@ struct eap_tls_state {
 	bool expecting_frag_ack:1;
 	bool tunnel_ready:1;
 	bool tls_session_resumed:1;
+	bool tls_cache_disabled:1;
 
 	struct l_queue *ca_cert;
 	struct l_certchain *client_cert;
@@ -179,7 +180,8 @@ static void __eap_tls_common_state_reset(struct eap_state *eap)
 
 		if (eap_tls->tls_session_resumed)
 			l_warn("EAP: method did not finish after successful TLS"
-				" session resumption.");
+				" session resumption.  If this repeats consider"
+				" setting [Settings].DisableEAPTLSCache.");
 	}
 
 	eap_tls->tls_session_resumed = false;
@@ -691,7 +693,7 @@ static bool eap_tls_tunnel_init(struct eap_state *eap)
 	if (eap_tls->domain_mask)
 		l_tls_set_domain_mask(eap_tls->tunnel, eap_tls->domain_mask);
 
-	if (!eap_tls_session_cache_load)
+	if (!eap_tls_session_cache_load || eap_tls->tls_cache_disabled)
 		goto start;
 
 	if (!eap_tls_session_cache)
@@ -1040,6 +1042,13 @@ int eap_tls_common_settings_check(struct l_settings *settings,
 		return -EINVAL;
 	}
 
+	if (l_settings_has_key(settings, "Settings", "DisableEAPTLSCache") &&
+			!l_settings_get_bool(settings, "Settings",
+						"DisableEAPTLSCache", NULL)) {
+		l_error("Can't parse DisableEAPTLSCache");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -1051,6 +1060,7 @@ bool eap_tls_common_settings_load(struct eap_state *eap,
 	struct eap_tls_state *eap_tls;
 	char setting_key[72];
 	char *domain_mask_str;
+	bool bool_val;
 
 	L_AUTO_FREE_VAR(char *, value) = NULL;
 
@@ -1080,6 +1090,10 @@ bool eap_tls_common_settings_load(struct eap_state *eap,
 		l_free(domain_mask_str);
 	}
 
+	eap_tls->tls_cache_disabled =
+		l_settings_get_bool(settings, "Settings", "DisableEAPTLSCache",
+					&bool_val) && bool_val;
+
 	eap_set_data(eap, eap_tls);
 
 	return true;
diff --git a/src/iwd.network.rst b/src/iwd.network.rst
index d3692834..8833f33b 100644
--- a/src/iwd.network.rst
+++ b/src/iwd.network.rst
@@ -174,6 +174,16 @@ The group ``[Settings]`` contains general settings.
        Properly configured Access Points will typically update this setting
        appropriately via Transition Disable indications.  User customization
        of this value is thus typically not required.
+   * - DisableEAPTLSCache
+     - Values: true, **false**
+
+       Disables TLS session caching in EAP-TLS, EAP-TTLS and EAP-PEAP.
+       Some network authenticators may be misconfigured in a way that TLS
+       session resumption is allowed but actually attempting it will cause
+       the EAP method to fail or time out.  In that case, assuming the
+       credentials and other settings are correct, every other connection
+       attempt will fail as sessions are cached and forgotten in alternating
+       attempts.  Use this setting to disable caching for this network.
 
 Network Authentication Settings
 -------------------------------
-- 
2.34.1

