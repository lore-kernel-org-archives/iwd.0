Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C1C4DE717
	for <iwd@lists.linux.dev>; Mon, 19 Oct 2026 12:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792411643; cv=none; b=DtFqMV7ACZGESyyDpWZibm62Z6722zgzyJFnWO3B6zIpjJuB3tTMrgjkc5jM52emNM0Ur7UcHyB/Bw/UGNDvTpHmYV29swYQLUXFKWR/KUiySHJMRnNYlCIFyBC6krqjddBa9LrgiADV7E0sf2t05RSwHVLQRk/3i86z9ybF2zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792411643; c=relaxed/simple;
	bh=nSMmsMKAgW+AGxsn1CWl75Ts6osYiEhHhmh6GHQTYhM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Zdmc6nA9z6ceiENOIAhXsh/peHGFnqJ5FYNz9qvOHiRARygOxfa8sOuR8IrVF0oPpUGeXJdXbFgxkLa3iyV3OtUZxjQrruZ2b9vK5BtsgTzyCrShgB7QlWAy9uAxnKIVjxuhtz/mjUHjPCpcP54tE9ItXDeqss7JXJq0Il0ZR4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M6uPmzgT; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6uPmzgT"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-93cb1c0e851so147608885a.0
        for <iwd@lists.linux.dev>; Mon, 19 Oct 2026 05:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792411641; x=1793016441; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lUj6q5s1WDc9AFZb5SWsQPDWxqL9DgEgcCXot6A5zFw=;
        b=M6uPmzgTpBdJsBwC9HZvXAjx84k1+/gB3k9UbNpZ2KliJWUw6CglshzoDunEOqIZ8X
         hjwiEZdrLS0wgDnSWN5y6hOV/6ZodlaMn8mE+2wGufx05CXrPKmEQlIgrrueDMhB3k3d
         wFIlELWPc5ktxioP2cOzWOGvbo5EUmTyzC1d0A3Y8V9zBng53CxTPIs/cjPs7+YK+ili
         +lWBn2gUTioDanO3dj8rKKCEI+lCC1b/weqvLlLLbdlHO+K2m1nVRqKlxjC1f6bMhRXz
         4m1dlr40+LBE44XDT307WG0whIgSwDSuees40pRk5Zmiro+fLQc2hEKTgKkOEEqBwvOd
         tbbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792411641; x=1793016441;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lUj6q5s1WDc9AFZb5SWsQPDWxqL9DgEgcCXot6A5zFw=;
        b=CKglRgH4G1ne+u5qi+T/LO3Ub2EaYufnhLHec7HVVihDbEFoouWcqWSkumrSe4Zv7z
         eNy2Q84A+GE8I6QpfCwHfTP/L/JQf7dxwpuj2tDKI8+Xazg2g1FXdO1+iukG8S27GiLc
         MncoWlvQT7bbDf0HzhflSf327/zhAvIswrVqjweMdrgKvzFWwWXijxT/pJ+sj7qcX4Tw
         Ys6fZezNT04y/W+FxeEzdpLcL28CvnZM34/OKAQjh8f+35Il7V/TyDaqzupXDJoa4YVx
         DDnalS18aNuG9fa7eVnz2rfGi9KPwchtRpoI1HfCLTON5lRQ+m0eq28dOZ4zcsdN+WI+
         /stg==
X-Gm-Message-State: AFq9FYI41KkR1U+EqOSZTRTYf9E6uBLIg0FXGhyu5BVYGlWbGKw1UMZG
	ZYKnatjydmKEaUl8GAyTz9PytlZ8sSYl6tADDsHmsW9h8sjn1OdficmIGdGEACNo
X-Gm-Gg: AYBFou2E0DL6zTKUntCebuSdWCF77nJRUjZpHuYomhXaePySkmKB8TXdw3uwBcb5F8X
	MY4lEvGD90s122B/NBZ0ufgimc8pMSZkCbNHjpvPrhzPnnkGPpb75xYITjsQPqPX/CCp/ZtkbTk
	7NpE0jlkU9f9JQamS/5S6FfX9zsSkatf+ffMtpd9CNGDZRcJ53bnpnrlBRHkEplpgURDPdi/TIk
	LhWkisM0cZVuSW9WacvW0Ijn+bZnpzyKRYFdGLu6bZY/0DSwNsbr72NRfPTXtRQQRxDvsDeEJr7
	A8LH1sCA5QQ2od9DVSePmZr5hki4hKhBdNIdn6x24N7SvcnctyOkF86mkqCWi9EUT/reOO+mx43
	5p/NU4IZPnwX6BDuf7q5H/eSFM8df+MOWw6IkyWeDzieI5F3mnDl1p1siA8vCz5XidX4iM3LQoz
	sNWh9Lbiu5FUAMHdMwi6rbNVOIhpmsf72syY/LKQj+8lJSFs+j2ijmPak8PA+xxeOH0Q206zXZU
	NKiA/sBC+pD5QTb2K77AgGQ7wOSzvs6vAqfT37w8tQH6TX3G3HFxWxwaqYWKgOLSmd2Z+xb3kMD
	caNz+YHhX+vZdSbK
X-Received: by 2002:a05:620a:25c6:b0:939:6c31:2318 with SMTP id af79cd13be357-93f29ce44a6mr1166750385a.34.1792411640522;
        Mon, 19 Oct 2026 05:07:20 -0700 (PDT)
Received: from framie ([2603:7000:8a00:daf::1553])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f2f045ca4sm596377685a.29.2026.10.19.05.07.19
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 05:07:19 -0700 (PDT)
From: John Rinehart <johnrichardrinehart@gmail.com>
To: iwd@lists.linux.dev
Subject: [PATCH] manager: create P2P device after default iface
Date: Mon, 19 Oct 2026 08:07:18 -0400
Message-ID: <20261019120718.159767-1-johnrichardrinehart@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With [DriverQuirks].DefaultInterface, iwd can set up a wiphy before the
driver creates its default interface. This happens when iwd starts while
mac80211 registers the card, for example during boot. The interface
dump is then empty, so manager_use_default() sets state->retry and
waits for a NEW_INTERFACE event.

manager_create_interfaces() still creates the P2P device in this case.
The NEW_INTERFACE event for that P2P device arrives first and clears
state->retry. The P2P device is not a default interface, so setup
finishes without a station device. The driver's NEW_INTERFACE event
arrives next, finds no pending setup, and is ignored. The wiphy has no
station until iwd restarts or the driver reloads:

  iwd: Wiphy phy0 will only use the default interface
  iwd: No default interface for wiphy 0
  kernel: iwlwifi 0000:aa:00.0 wlp170s0: renamed from wlan0

iwmon shows the order: an empty GET_INTERFACE dump, the NEW_INTERFACE
request for wlan0-p2p and its event, then the NEW_INTERFACE event for
the driver's wlan0.

Return from manager_create_interfaces() when manager_use_default()
fails. The retry calls manager_create_interfaces() again after the
default interface appears, and that pass creates the P2P device.

This patch does not change the path without DefaultInterface. There,
an EBUSY from the station NEW_INTERFACE also sets state->retry while
the P2P device is created, so the P2P event can clear the retry in the
same way. I could not reproduce EBUSY on this hardware, so the patch
leaves that path alone.

Tested on an Intel AX210 (iwlmvm) with kernel 7.2.9. Reloading the
driver under rtnl_lock contention and starting iwd during registration
reproduces the stuck wiphy with 3.12. With this patch, iwd logs
"No default interface" and then sets up the station and connects.
---
 src/manager.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/src/manager.c b/src/manager.c
index 436daa56..48c0acc6 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -203,7 +203,14 @@ static void manager_create_interfaces(struct wiphy_setup_state *state)
 		return;
 
 	if (state->use_default) {
-		manager_use_default(state);
+		/*
+		 * If the default interface does not exist yet, wait for its
+		 * NEW_INTERFACE event before creating the P2P device.  The
+		 * event for our own P2P device would otherwise end the wait,
+		 * and the default interface would never be set up.
+		 */
+		if (!manager_use_default(state))
+			return;
 
 		/*
 		 * Some drivers don't let us touch the default interface
-- 
2.56.0

