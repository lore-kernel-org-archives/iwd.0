Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273041DFE0
	for <iwd@lists.linux.dev>; Tue, 31 Oct 2023 18:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="muHa/xpg"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-77896da2118so399843085a.1
        for <iwd@lists.linux.dev>; Tue, 31 Oct 2023 11:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698778079; x=1699382879; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m0MlWvCYhCwlsmNdvrzrAosY7P3OZncO6qdkvW2lwOQ=;
        b=muHa/xpgEY/hmzadOA/qKNVWpVbAkfnqieCovpghGBQ+l6IThfUeRaWCAybE395fGc
         iWW2oijaq6ml7uJhYyoA5xL51XVK5c/V2W/6ofhmjpLV/VRMPTucsZW8Qeu+I4rOxsKl
         4MiLNMwXEViotyRoWw17Zp9gttEwjWetKOv05cbj66kCc6x9w/kc7DQYtZEdRKMgStNg
         tzdNeEBvfOKXF4RVGqM3IzwkORt2oAk4TJ9c+8dBsgjWiP3f048xPMiinzrmbNBO2XQ+
         3BJk4TibnmjNdpogfK87f8VHc0JuFQkSiWn997OC2ORMI7guVuYcG5snAgtGiyqahGbO
         GiDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698778079; x=1699382879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m0MlWvCYhCwlsmNdvrzrAosY7P3OZncO6qdkvW2lwOQ=;
        b=jxjadQRGN/y1T3PhezaXRyVlhDD4zq4D1eavL7BOd6608sKMC5K0mely4QOie+KmQv
         KkNdH1gcW+6awCGyhGcvVFZRh6Shf451G2TvVDCVzAtgwI1V09fTLQB4KXGuZfDsMmBq
         ksI5B1Sr8QdL+DOcKFQVFpzEy6kBUGMZXqhE0QbiuNzA1WQY/TQMnMHaK9ZVy5vgZedH
         +ho6PqYBJU+JMzAyKMu4NCq3WdoZUVwGfjkeArVSAFLaqgqCAxNA3NBVZfeBjtjIzw6B
         tQ0dzAxXZES1zedONT1XcCkecrAbiFF+paxG7KM++HtZD9GIlqouujRGwe3TWsqN7Swh
         CdHw==
X-Gm-Message-State: AOJu0Yzom1UZACY6l8Kr4ZEjJUUq0bWwMACOFeMxjpVHc3Ab41cmTdRb
	hxSjTksZkeLaYxW8JOtVKNokNbm1MJ0=
X-Google-Smtp-Source: AGHT+IF8IK5R7RfDKKsCkMxe+6gaLfV6wtrun7FhDI8o7imZ8uJw4N/ivcN1P3t7m9Cxlqf8vt1GrA==
X-Received: by 2002:a05:620a:2448:b0:779:e352:6db9 with SMTP id h8-20020a05620a244800b00779e3526db9mr16013523qkn.30.1698778078911;
        Tue, 31 Oct 2023 11:47:58 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id bj30-20020a05620a191e00b00774292e636dsm736351qkb.63.2023.10.31.11.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 11:47:58 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 1/9] dpp: remove scan_periodic_stop calls
Date: Tue, 31 Oct 2023 11:47:42 -0700
Message-Id: <20231031184750.722404-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231031184750.722404-1-prestwoj@gmail.com>
References: <20231031184750.722404-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Stopping periodic scans and not restarting them prevents autoconnect
from working again if DPP (or the post-DPP connect) fails. Since
the DPP offchannel work is at a higher priority than scanning (and
since new offchannels are queue'd before canceling) there is no risk
of a scan happening during DPP so its safe to leave periodic scans
running.
---
 src/dpp.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index 638d65e0..cfdfaa38 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -2553,8 +2553,6 @@ static struct l_dbus_message *dpp_dbus_start_enrollee(struct l_dbus *dbus,
 	 */
 	dpp_start_presence(dpp, &freq, 1);
 
-	scan_periodic_stop(dpp->wdev_id);
-
 	dpp_property_changed_notify(dpp);
 
 	return NULL;
@@ -2685,8 +2683,6 @@ static struct l_dbus_message *dpp_start_configurator_common(
 						network_get_ssid(network),
 						hs->akm_suite);
 
-	scan_periodic_stop(dpp->wdev_id);
-
 	dpp_property_changed_notify(dpp);
 
 	l_debug("DPP Start Configurator: %s", dpp->uri);
-- 
2.25.1

