Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC4313B288
	for <iwd@lists.linux.dev>; Thu, 18 Jul 2024 11:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721303123; cv=none; b=NUwjK5T5Ur3FjyL3bQMOt4YNHOQ/yoBAQmx/3BWVnWMhX6+JP+Of/LB8zD01ozEimm4tnjQ6h665OK87Gn/tE03E/rbRwuoB8WcI5KMf1C8JRJ7Jkf15t2kOQynQg1rdaIfQQpMfqSuldjwhpRLfZpfQDUXFlP3rRz96WasY38o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721303123; c=relaxed/simple;
	bh=JreGr0sHLZLl4XeUk5L1hDKAt+cr/UAmnzI7wM9H2Ps=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lOme1F/KZTM3DUrX8bgAgrm7s0Ubpr9xrUFvq0fMBkVVJirGx9Eu08GsbZPt9YDGQNAP4xzbsxS4IJhLkEAxq7JMNzi0Gsi5CdQmT6eV4PYfK67bOyEvvLBZ8HSxEyT+fLZw0Lagx+TtNAggbl7TLggE2k8P+zRS/2FN5xq3OQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XyeNk5BK; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XyeNk5BK"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6b78c980981so3966736d6.2
        for <iwd@lists.linux.dev>; Thu, 18 Jul 2024 04:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721303121; x=1721907921; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R2woAQ/OajhFJ9iSHb0ikY2m+Ui2/rCm2lDgkMgMWzc=;
        b=XyeNk5BKiCn8uW9fBqeJl8hdmH05Q6LpeMo/+dnyhDJxCSXGoZsrpnHIVGwnW6HxAC
         AWvfGFjuyYzMbhObIBzSdVWiY21/rLsYgOgwC8GHNkeqrPRWxZnEja6LNvJ/YVJvDmyn
         qWYAp0GB3C+vN3Fa6RK8UKM8eddCoB7PKwpmCC41bJs2S7Key0PUEG/klqb5WqiLnfqJ
         NjqQH9ll+mYrlsCZ/kxwTZIa0kpJkokBWsWhuoxiU1WxJgxsA/WvtqM0k9XsMM3EyZGu
         bg+6hWFRjnVD80gerlPdFWRWlgFJa+XJoXFS+zPgPmojNPZxyPkP5l9OOuzNVJH6+jJS
         hMgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721303121; x=1721907921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R2woAQ/OajhFJ9iSHb0ikY2m+Ui2/rCm2lDgkMgMWzc=;
        b=c0hkGJPBJG0uB9VR2O6xk5C44PYtR/Gc1142BcZq7w3JWVH4H1lQyxcxQtCTrQarr6
         EvXL5baG7OapasMCCVTcw9DcT9GpM02yKcQPwNWib22aT+a0B1Etw8qdXVkC3/mPYNw+
         sPAZy5V8RgJUHSkAyQAFjIUo+yJXCaVEv0EBQncu8Bnt/or5Vngw8Pl4hkByCNRLgnQE
         zukaPf2VzePdRAZVt/IAC7YmsERJUDjifeF8nyMXQiiyFbc6ZqdAxpvab4HHIq8mvrOk
         8NDhjCLwwkO25DeNvd3ANNQ321XatU8Cmjni0iaTbdpfoSeM6iAyn7oZRtyFtEd8En91
         5xKA==
X-Gm-Message-State: AOJu0Yz04g1Qb4pjDjEIISjsZL/jAt8oF4LZuiknTDtlhf3PeOU1lFLX
	SV/db+oHQfspQmx0dVptHbysKHetaNKMDkcoRBLIj+NYACFrqiu0fV9CeQ==
X-Google-Smtp-Source: AGHT+IHJEJ/YlGJUQepGunHpBUBBENtPX58g1Fmt4Vr67orhOzlCCCGymIV3GWtcJKgp6JjuUCVd8Q==
X-Received: by 2002:ad4:5be8:0:b0:6b5:da13:bf42 with SMTP id 6a1803df08f44-6b78e464d26mr53253566d6.58.1721303120825;
        Thu, 18 Jul 2024 04:45:20 -0700 (PDT)
Received: from LOCLAP699.localdomain ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b79c5138bbsm7292006d6.61.2024.07.18.04.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 04:45:20 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 02/11] netdev: add NETDEV_RESULT_DISCONNECTED
Date: Thu, 18 Jul 2024 04:45:05 -0700
Message-Id: <20240718114514.2916258-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718114514.2916258-1-prestwoj@gmail.com>
References: <20240718114514.2916258-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This new result is meant to handle cases where a disconnect
event (deauth/disassoc) was received during an ongoing connection.
Whether that's during authentication, association, the 4-way
handshake, or key setting.
---
 src/netdev.h  | 2 ++
 src/p2p.c     | 1 +
 src/station.c | 1 +
 3 files changed, 4 insertions(+)

diff --git a/src/netdev.h b/src/netdev.h
index 671d0d40..db0440d0 100644
--- a/src/netdev.h
+++ b/src/netdev.h
@@ -36,6 +36,7 @@ enum netdev_result {
 	NETDEV_RESULT_HANDSHAKE_FAILED,
 	NETDEV_RESULT_KEY_SETTING_FAILED,
 	NETDEV_RESULT_ABORTED,
+	NETDEV_RESULT_DISCONNECTED,
 };
 
 enum netdev_event {
@@ -86,6 +87,7 @@ typedef void (*netdev_command_cb_t)(struct netdev *netdev, int result,
  * NETDEV_RESULT_HANDSHAKE_FAILED - MMPDU_REASON_CODE
  * NETDEV_RESULT_KEY_SETTING_FAILED - unused
  * NETDEV_RESULT_ABORTED - unused.
+ * NETDEV_RESULT_DISCONNECTED - MMPDU_REASON_CODE
  */
 typedef void (*netdev_connect_cb_t)(struct netdev *netdev,
 					enum netdev_result result,
diff --git a/src/p2p.c b/src/p2p.c
index 205d4fcb..e8c7c5de 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -1366,6 +1366,7 @@ static void p2p_netdev_connect_cb(struct netdev *netdev,
 	case NETDEV_RESULT_ASSOCIATION_FAILED:
 	case NETDEV_RESULT_HANDSHAKE_FAILED:
 	case NETDEV_RESULT_KEY_SETTING_FAILED:
+	case NETDEV_RESULT_DISCONNECTED:
 		/*
 		 * In the AUTHENTICATION_FAILED and ASSOCIATION_FAILED
 		 * cases there's nothing to disconnect.  In the
diff --git a/src/station.c b/src/station.c
index 3ead4326..01f6b78e 100644
--- a/src/station.c
+++ b/src/station.c
@@ -3319,6 +3319,7 @@ static void station_connect_cb(struct netdev *netdev, enum netdev_result result,
 		blacklist_remove_bss(station->connected_bss->addr);
 		station_connect_ok(station);
 		return;
+	case NETDEV_RESULT_DISCONNECTED:
 	case NETDEV_RESULT_HANDSHAKE_FAILED:
 		/* reason code in this case */
 		if (station_retry_with_reason(station, l_get_u16(event_data)))
-- 
2.34.1

