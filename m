Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8B91DED7F
	for <iwd@lists.linux.dev>; Fri, 22 Nov 2024 15:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732288562; cv=none; b=fMB860+a0Sd5qOwmounxx//dgy60Vsh9nIlHGOwn7jJ+6/IJJShij8Mz5Ua9ECJXB3VKRfRB+GYRmmioYtgj2PYhDISxz+dpZZf+RNottgr3Vr7BM3y/jGb/xIYctPqG0YHLAmXrFhqLNpQhrs+T5OtYMn2pkMVy+1q5ib+n0XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732288562; c=relaxed/simple;
	bh=T7EzbGP0zQxKW3CZyanatbIG6gM6n0XcTvl0ip0rhj4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UqUbjBp4T9XYX+O8+hxdYmhKN/pbh8qmGef16heLhnXaNPAg3RxQhx5PuEtXFDyBOthDlVHHx5KzMpC+03PIYesjKSdg2xzK0pv1SQcBi6r6S4I7H1nbHIUm6M3Xc3+Su2Ktb21yNru4ExuqpcMAmsXCwtZgm7nI16lytfl8WQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JfrwWoSy; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfrwWoSy"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6d41f721047so14779056d6.1
        for <iwd@lists.linux.dev>; Fri, 22 Nov 2024 07:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732288559; x=1732893359; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QAqtQzo2z/Xd6xeFf3E/w3pqkrQp9PxiPvRFri9XqHU=;
        b=JfrwWoSyc4AjoUD78xh/q8+a+AoOPcyN0J+B7cocEVxDKyqJDQ0yn8TC1+k5C9JAYn
         417sMo8RsEJsf/m90b6aEgzz25JgTk7z73khytcgOwP4FeiVeyRNf/VIAtfYnaXsiMsv
         y3InT5lDz0V+Eaj0X3roYpY8Vtw0BQVd1k5TkKcK5klTX4l+eXgrBh4QhG03dp9xTJlp
         7ZRVdoBjbnmG5JsViiNljArn1gVbCRqmFr+bin5MKmsjJHj8f1/9Tc/ttQ8CGBBXtJgS
         5Yy3R7bgSchZC2sz80IEzanFJoYGlqFeQZHLp2jNSbB0uGKz7u+ELfhCbaOZpZDWTdLM
         xf+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732288559; x=1732893359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QAqtQzo2z/Xd6xeFf3E/w3pqkrQp9PxiPvRFri9XqHU=;
        b=HvZDyqmoSVqPPIkEUrTWnNWKFlb0F7ko06zMsgNJlqOB4s4sHtV8YUGG7Uy3Xm7Ems
         GthiFX/zi0sam8bPs2j/VszzY/SPS2BAzDC7Wbn6AIOfHKyOL+9wRkUUjn+g/36jAAgF
         oWhoX28uMYmkmIfe+1znRRNLcRlmSNSfxmCCUMKtK7yfY0mwnnTjTQI58Ksrz7acGDGi
         6mq2xlcEJjI7B1j8wehucUieHao29rK//kuyW/Kwngz0bkG7n29fj1A+2ohksgf8Ml/X
         lpSA/QCtzThkC/EjPokeImNSaLDbUK7JyxGFPWFUX3lEG6l9EiH7nx00UvQXMhaVEjio
         Zxng==
X-Gm-Message-State: AOJu0YzMAJWD5jRECJEly5PsyjOlnJMXULCLGrMbOQs3q7y0RbpZhrDq
	6hURgLg9X2Ob4YFuTQZKFwAlYUWq//fHs9f6J8/gZSkg43zzuVtr+8g9rw==
X-Gm-Gg: ASbGnctQhN/Hvr43Skj69ljQakndg96yZBmtavzIzehdbGKEfSesix4RWTmcky/Kk+a
	fG+7n2LQgFgZHKayaKVGhD4Y0T6dHsRhwkLDYY85LgeJ+ZMYdgfRfeNXwadPaTYd+EHtAG43l3D
	OTXDMiNfdEZI7S2mKAFfOWPpqPsCqRgQJfgtbd2fdhQ8l18s++Te++ogNZLo58J3t/nGaWvjO8r
	PtAPSgdoFKU3DxXUsWymyiixHupX8hMUeCgN9r/nK87dAZ27SnpwafDfocC
X-Google-Smtp-Source: AGHT+IH5oWGSC7IXnxDMWH5VoFtWkBkYhi91/nHtkwYn/B/TW3IYm7XrwkOa4l29dNdcsiOvAcz8NQ==
X-Received: by 2002:a05:6214:2267:b0:6cb:eba0:267f with SMTP id 6a1803df08f44-6d450eb6858mr48548286d6.16.1732288558796;
        Fri, 22 Nov 2024 07:15:58 -0800 (PST)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d451a9a720sm10722706d6.50.2024.11.22.07.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 07:15:58 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 01/15] handshake: add ref counting to handshake_state
Date: Fri, 22 Nov 2024 07:15:37 -0800
Message-Id: <20241122151551.286355-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241122151551.286355-1-prestwoj@gmail.com>
References: <20241122151551.286355-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds a ref count to the handshake state object (as well as
ref/unref APIs). Currently IWD is careful to ensure that netdev
holds the root reference to the handshake state. Other modules do
track it themselves, but ensure that it doesn't get referenced
after netdev frees it.

Future work related to PMKSA will require that station holds a
references to the handshake state, specifically for retry logic,
after netdev is done with it so we need a way to delay the free
until station is also done.
---
 src/adhoc.c     |  4 ++--
 src/ap.c        |  2 +-
 src/handshake.c | 12 +++++++++++-
 src/handshake.h |  9 ++++++---
 src/netdev.c    |  5 +++--
 src/p2p.c       |  2 +-
 src/station.c   |  8 ++++----
 src/wsc.c       |  2 +-
 8 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/src/adhoc.c b/src/adhoc.c
index e787dab1..930240ae 100644
--- a/src/adhoc.c
+++ b/src/adhoc.c
@@ -94,13 +94,13 @@ static void adhoc_sta_free(void *data)
 		eapol_sm_free(sta->sm);
 
 	if (sta->hs_sta)
-		handshake_state_free(sta->hs_sta);
+		handshake_state_unref(sta->hs_sta);
 
 	if (sta->sm_a)
 		eapol_sm_free(sta->sm_a);
 
 	if (sta->hs_auth)
-		handshake_state_free(sta->hs_auth);
+		handshake_state_unref(sta->hs_auth);
 
 end:
 	l_free(sta);
diff --git a/src/ap.c b/src/ap.c
index 562e00c8..d52b7e55 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -230,7 +230,7 @@ static void ap_stop_handshake(struct sta_state *sta)
 	}
 
 	if (sta->hs) {
-		handshake_state_free(sta->hs);
+		handshake_state_unref(sta->hs);
 		sta->hs = NULL;
 	}
 
diff --git a/src/handshake.c b/src/handshake.c
index fc1978df..7fb75dc4 100644
--- a/src/handshake.c
+++ b/src/handshake.c
@@ -103,7 +103,14 @@ void __handshake_set_install_ext_tk_func(handshake_install_ext_tk_func_t func)
 	install_ext_tk = func;
 }
 
-void handshake_state_free(struct handshake_state *s)
+struct handshake_state *handshake_state_ref(struct handshake_state *s)
+{
+	__sync_fetch_and_add(&s->refcount, 1);
+
+	return s;
+}
+
+void handshake_state_unref(struct handshake_state *s)
 {
 	__typeof__(s->free) destroy;
 
@@ -117,6 +124,9 @@ void handshake_state_free(struct handshake_state *s)
 		return;
 	}
 
+	if (__sync_sub_and_fetch(&s->refcount, 1))
+		return;
+
 	l_free(s->authenticator_ie);
 	l_free(s->supplicant_ie);
 	l_free(s->authenticator_rsnxe);
diff --git a/src/handshake.h b/src/handshake.h
index d1116472..6c0946d4 100644
--- a/src/handshake.h
+++ b/src/handshake.h
@@ -170,6 +170,8 @@ struct handshake_state {
 	bool in_event;
 
 	handshake_event_func_t event_func;
+
+	int refcount;
 };
 
 #define HSID(x) UNIQUE_ID(handshake_, x)
@@ -186,7 +188,7 @@ struct handshake_state {
 					##__VA_ARGS__);			\
 									\
 			if (!HSID(hs)->in_event) {			\
-				handshake_state_free(HSID(hs));		\
+				handshake_state_unref(HSID(hs));	\
 				HSID(freed) = true;			\
 			} else						\
 				HSID(hs)->in_event = false;		\
@@ -194,7 +196,8 @@ struct handshake_state {
 		HSID(freed);						\
 	})
 
-void handshake_state_free(struct handshake_state *s);
+struct handshake_state *handshake_state_ref(struct handshake_state *s);
+void handshake_state_unref(struct handshake_state *s);
 
 void handshake_state_set_supplicant_address(struct handshake_state *s,
 						const uint8_t *spa);
@@ -316,4 +319,4 @@ void handshake_util_build_gtk_kde(enum crypto_cipher cipher, const uint8_t *key,
 void handshake_util_build_igtk_kde(enum crypto_cipher cipher, const uint8_t *key,
 					unsigned int key_index, uint8_t *to);
 
-DEFINE_CLEANUP_FUNC(handshake_state_free);
+DEFINE_CLEANUP_FUNC(handshake_state_unref);
diff --git a/src/netdev.c b/src/netdev.c
index e86ef1bd..4dccb78a 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -376,6 +376,7 @@ struct handshake_state *netdev_handshake_state_new(struct netdev *netdev)
 
 	nhs->super.ifindex = netdev->index;
 	nhs->super.free = netdev_handshake_state_free;
+	nhs->super.refcount = 1;
 
 	nhs->netdev = netdev;
 	/*
@@ -828,7 +829,7 @@ static void netdev_connect_free(struct netdev *netdev)
 	eapol_preauth_cancel(netdev->index);
 
 	if (netdev->handshake) {
-		handshake_state_free(netdev->handshake);
+		handshake_state_unref(netdev->handshake);
 		netdev->handshake = NULL;
 	}
 
@@ -4239,7 +4240,7 @@ int netdev_reassociate(struct netdev *netdev, const struct scan_bss *target_bss,
 		eapol_sm_free(old_sm);
 
 	if (old_hs)
-		handshake_state_free(old_hs);
+		handshake_state_unref(old_hs);
 
 	return 0;
 }
diff --git a/src/p2p.c b/src/p2p.c
index 676ef146..7d89da21 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -1497,7 +1497,7 @@ static void p2p_handshake_event(struct handshake_state *hs,
 static void p2p_try_connect_group(struct p2p_device *dev)
 {
 	struct scan_bss *bss = dev->conn_wsc_bss;
-	_auto_(handshake_state_free) struct handshake_state *hs = NULL;
+	_auto_(handshake_state_unref) struct handshake_state *hs = NULL;
 	struct iovec ie_iov[16];
 	int ie_num = 0;
 	int r;
diff --git a/src/station.c b/src/station.c
index 1238734f..c1c7ba9d 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1394,7 +1394,7 @@ static struct handshake_state *station_handshake_setup(struct station *station,
 	return hs;
 
 not_supported:
-	handshake_state_free(hs);
+	handshake_state_unref(hs);
 	return NULL;
 }
 
@@ -2484,7 +2484,7 @@ static void station_preauthenticate_cb(struct netdev *netdev,
 	}
 
 	if (station_transition_reassociate(station, bss, new_hs) < 0) {
-		handshake_state_free(new_hs);
+		handshake_state_unref(new_hs);
 		station_roam_failed(station);
 	}
 }
@@ -2687,7 +2687,7 @@ static bool station_try_next_transition(struct station *station,
 	}
 
 	if (station_transition_reassociate(station, bss, new_hs) < 0) {
-		handshake_state_free(new_hs);
+		handshake_state_unref(new_hs);
 		return false;
 	}
 
@@ -3734,7 +3734,7 @@ int __station_connect_network(struct station *station, struct network *network,
 				station_netdev_event,
 				station_connect_cb, station);
 	if (r < 0) {
-		handshake_state_free(hs);
+		handshake_state_unref(hs);
 		return r;
 	}
 
diff --git a/src/wsc.c b/src/wsc.c
index f88f5deb..44b8d3de 100644
--- a/src/wsc.c
+++ b/src/wsc.c
@@ -393,7 +393,7 @@ static int wsc_enrollee_connect(struct wsc_enrollee *wsce, struct scan_bss *bss,
 		return 0;
 
 error:
-	handshake_state_free(hs);
+	handshake_state_unref(hs);
 	return r;
 }
 
-- 
2.34.1

