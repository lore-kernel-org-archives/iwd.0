Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1121CF85
	for <iwd@lists.linux.dev>; Fri, 20 Oct 2023 13:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQtU6NJn"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-581cb88f645so468560eaf.1
        for <iwd@lists.linux.dev>; Fri, 20 Oct 2023 06:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697810158; x=1698414958; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZpDYVjWUjJDBlTm6jgAEjY4V/rIr2sb4fsuwwH++URc=;
        b=fQtU6NJnA1GQZisPo4byGA3KzHnnolfVphQWgYqkFFv+V80KyewGw3PyYPo48aTxml
         yfEAg7eOPniyd0nWgGpZL2t8Nco+EeoCItIL54iPtkqgQHrf3GJWSZTGaFOf+OHUjvCl
         p/gq0lVHbojvVL4AAuFp9JCIgOUGKw1AhMGZi5ith7qwZmcVWAQw3cM2kqoUi9meFJwF
         6TblcLtCPdWqrWcz5EbpSFinQk/xzQycufS6BXvBEQXsWHxYe/pe8HULobJKpkc/GZvO
         WnyOr1YyR5qZ0xzSqjiw42Al6t7kJO8k0UZhgf8fYH83tQtZyreFOTZOeH3x0KmW9aG4
         HbEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697810158; x=1698414958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZpDYVjWUjJDBlTm6jgAEjY4V/rIr2sb4fsuwwH++URc=;
        b=sJiwCDwXx+375zWHHQ7hv9xLH1gso4x33JECcRsHGaMHTZtm/OXHnQHMxLeRqRsCrT
         DxPZ1L9mfeDgvuYRwkxvo+G6Vj5PfK7jrP5faeWz+sBGdAEyRzZMGRmN7W5DKOTpZZfv
         g4I1RbNgbvycuuTBo5gbjRgaUAsy1JZOfR5mnViTOnNZTZ17okbRoLTEeklw/gmbqTK9
         TAciMTTfTflXIQvNvB01I4Jt+uXJ56TUJPGzMkn4BiterHUrwpiXDhJG+4uLnVHqOo8A
         FLOPQWod5ZSCvX2bn01GBHayVuUbK0Y1o005cAViHqMpFZwOYS8xQ3uPZKiGPxC32ktN
         h2DQ==
X-Gm-Message-State: AOJu0Yxmqqynkn7APHq75XxtMZOaF/Yn2/LgSzAK+52AAdwL3AoTxtjy
	5ChUftAbaAr/xYcXjG8URreExZ1/mbg=
X-Google-Smtp-Source: AGHT+IFdq7RzLfMy75wggjyIZMiOYRrqIm8S8v4hx7l7QZmqf7ba7b/DvaC63E9dJrNl5UrBGgFrLA==
X-Received: by 2002:a05:6358:923:b0:168:9fa3:5016 with SMTP id r35-20020a056358092300b001689fa35016mr1671371rwi.2.1697810157962;
        Fri, 20 Oct 2023 06:55:57 -0700 (PDT)
Received: from localhost.localdomain ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id s187-20020a625ec4000000b0068ff267f094sm1609804pfb.158.2023.10.20.06.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 06:55:57 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] station: reload settings in 'netconfig_after_roam' case
Date: Fri, 20 Oct 2023 06:55:55 -0700
Message-Id: <20231020135555.139910-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If netconfig is canceled before completion (when roaming) the
settings are freed and never loaded again once netconfig is started
post-roam. Now after a roam make sure to re-load the settings and
start netconfig.
---
 src/station.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/src/station.c b/src/station.c
index e18847bc..9b224e5a 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2055,6 +2055,20 @@ static void station_netconfig_event_handler(enum netconfig_event event,
 	}
 }
 
+static bool netconfig_after_roam(struct station *station)
+{
+	const struct network *network = station_get_connected_network(station);
+
+	/* Netconfig was reset which frees all settings, reload now */
+	if (!netconfig_load_settings(station->netconfig,
+					network_get_settings(network)))
+		return false;
+
+	return netconfig_configure(station->netconfig,
+					station_netconfig_event_handler,
+					station);
+}
+
 static void station_roamed(struct station *station)
 {
 	station->roam_scan_full = false;
@@ -2086,9 +2100,7 @@ static void station_roamed(struct station *station)
 	/* Re-enable netconfig if it never finished on the last BSS */
 	if (station->netconfig_after_roam) {
 		station->netconfig_after_roam = false;
-		L_WARN_ON(!netconfig_configure(station->netconfig,
-						station_netconfig_event_handler,
-						station));
+		L_WARN_ON(!netconfig_after_roam(station));
 	} else
 		station_enter_state(station, STATION_STATE_CONNECTED);
 }
@@ -2126,9 +2138,7 @@ static void station_roam_failed(struct station *station)
 	/* Re-enable netconfig if needed, even on a failed roam */
 	if (station->netconfig_after_roam) {
 		station->netconfig_after_roam = false;
-		L_WARN_ON(!netconfig_configure(station->netconfig,
-						station_netconfig_event_handler,
-						station));
+		L_WARN_ON(!netconfig_after_roam(station));
 	}
 
 	/*
-- 
2.25.1

