Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638CF1CA81
	for <iwd@lists.linux.dev>; Wed,  3 Jan 2024 18:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HO1nf1Jk"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-781df3bc08fso103208985a.2
        for <iwd@lists.linux.dev>; Wed, 03 Jan 2024 10:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704307616; x=1704912416; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0CK+cEINYpyo2ATfomlbUmVtK/y40YR1O/Eme6ImURg=;
        b=HO1nf1JkqC5RbXektr0MF3jNyLzTFWXQQReH4E+TkAqZ75gqb5hWZPXnbbMdpN1ZWL
         Z1ubIKzkykp3fbKdbLEj21ekm1dri9kIo9hlSUmLcjt2H6+RNLsyckm7aqhYtE8eMI9N
         Pbxh9jBw2tFTrSGIKL66yEtdd/4YbVEAFfgkNaqlqKuzW9BTPje+iVybgIrAD1lvMs8l
         ZmDoglpc8afwY6vPjd3h8iigXmmwgckaVRdV/u/ZnLO7ovfiT7F86PINFXrnwEIabAm2
         P6ijAv20Ots/lQ3F+J8vSC7GhCpYtOCQKGLivvgiwvKEm2AQgoSIlLKqUi4NmPam5iD3
         YYmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704307616; x=1704912416;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0CK+cEINYpyo2ATfomlbUmVtK/y40YR1O/Eme6ImURg=;
        b=ijMhIBndmDAx4nq4sN1U/2bTRoEHMLiDsghlFaK5RaHXocIjgc6VdWoEpo2u3iBMO7
         hAevZOkVILn7L8wdQKo8ApJ5rsye3xxx1ZvBa1FgR2G8Xm05HlXF29asUjwQMLT2LfzS
         bpw4qqD66IXsDthu1X0p7fXSvMcYRGPUrGHqNAopCMHDUi8KSecF/WnF8fAv80guksg2
         j8byHWQ4ovtDXa04d1PxZhVBkJlPWYAaFkQvtttEY5sh1AEbxr7doq5vXpbjW7hZZ5Z5
         3zITeGYdrBGtnCGnxBaQNsCuRYRQe/2nYtOZOPLQHCpIldjMp2WAKTmd9eNzUn7Y6f6y
         YE5Q==
X-Gm-Message-State: AOJu0YzLIu0Y08lInThAXAsiMtxGHfV2oWAJG1RnrQnFUijLYDje4JPF
	gp2gj8f36UVOlcf7+oV33U8o+HFgwHXThg==
X-Google-Smtp-Source: AGHT+IFuIvWlTbiB3wOfpppIqKxTDO0+ZAstmXF4WlL0TryGit1PDkVRRHkIjqh98IwDq8+o4ewQVQ==
X-Received: by 2002:a05:620a:17a9:b0:781:182c:f668 with SMTP id ay41-20020a05620a17a900b00781182cf668mr17528838qkb.29.1704307615846;
        Wed, 03 Jan 2024 10:46:55 -0800 (PST)
Received: from LOCLAP699.rst-01.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id o21-20020a05620a22d500b00781a147e444sm3693370qki.92.2024.01.03.10.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 10:46:55 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/8] station: handle netconfig after roaming for FW roams
Date: Wed,  3 Jan 2024 10:46:31 -0800
Message-Id: <20240103184638.533221-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This was not taken into account for FW roams and would result in the
station state being set to connected regardless of netconfig's result.
---
 src/station.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/src/station.c b/src/station.c
index 73de26bb..5c9ede8b 100644
--- a/src/station.c
+++ b/src/station.c
@@ -3406,6 +3406,16 @@ static void station_beacon_lost(struct station *station)
 	station_roam_timeout_rearm(station, LOSS_ROAM_RATE_LIMIT);
 }
 
+static void station_event_roaming(struct station *station)
+{
+	if (station->netconfig && station->state != STATION_STATE_CONNECTED) {
+		netconfig_reset(station->netconfig);
+		station->netconfig_after_roam = true;
+	}
+
+	station_enter_state(station, STATION_STATE_FW_ROAMING);
+}
+
 static void station_netdev_event(struct netdev *netdev, enum netdev_event event,
 					void *event_data, void *user_data)
 {
@@ -3433,7 +3443,7 @@ static void station_netdev_event(struct netdev *netdev, enum netdev_event event,
 			station_signal_agent_notify(station);
 		break;
 	case NETDEV_EVENT_ROAMING:
-		station_enter_state(station, STATION_STATE_FW_ROAMING);
+		station_event_roaming(station);
 		break;
 	case NETDEV_EVENT_ROAMED:
 		station_event_roamed(station, (struct scan_bss *) event_data);
-- 
2.34.1

