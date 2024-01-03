Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E771C6BC
	for <iwd@lists.linux.dev>; Wed,  3 Jan 2024 18:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RaLcLnS9"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7818ab57d7dso410562685a.2
        for <iwd@lists.linux.dev>; Wed, 03 Jan 2024 10:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704307620; x=1704912420; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=498VsVdajc3ch3Mu/qKE96ri+I/+iWfSAVzJ64kLtgY=;
        b=RaLcLnS9u7NUEJ0rxrRcc+tNoIu2xhsXA3VyoYwZwFN88hV911bXCy7otKR01tlQkj
         rZzg/kDul9dfq5mInM4MLJxSoElBH97n+Uucuwwsrb4EWudHGWYF8FsIJHGNJsPxJaxm
         RrbwnCVOH531+oyeJd5TfGKx9aNVKjk/mSn2mtqX55Ay/gGetTi8xS5u+Y3NuzKh60Yv
         tZ9h31wdT0W9UrjQ3xuCahegbEfoZ4iUvM6CuUy0u+1GJHCLVsVNnSN1qDalO48iAfSE
         ZoGMsNUXSkK2ALB+wKsK98Sl7BYfm9WWEIx880cp2AZi6mw+9wNkkWvY1LXRZtGVDIql
         c/Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704307620; x=1704912420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=498VsVdajc3ch3Mu/qKE96ri+I/+iWfSAVzJ64kLtgY=;
        b=jZB/FCdXD4KWCMHOwaofmrR6D4EJSW/3rKtcokUDqUuLCZ+AIn+h7zPZRjQY9Z2vsj
         9JJiaYsggdUTKR7Qlo+x5/LgpNxS72S6NpsK27R4awCO/hsA5M50s+drQqea8nsC4OP1
         9esyISJqWdPg2TjYoz7yNhtysNh0KERvaDLujxt8c7QBzQCRyhvxVvr2WCgdA9hhso22
         4pBaox9jeZrymEYkM/l8oeT8bYpIC4lVcTwTqD7D6Q1kE/85Do68yXJGHGSF58apuiNz
         zzm3YTGXYfe2qGopAVHi9pGw8lyemBs2RUoIepseCH0HgykC+wadbNMOVv7PaI6dAzTX
         qF5Q==
X-Gm-Message-State: AOJu0Ywev9Hll9Mi3nA8qRyRQFq7RAVYh2yJ44CmOyesTf+Jwq4xOibd
	gUNWOB2YKs7INv8OLckCsFGQqRVW64QDSw==
X-Google-Smtp-Source: AGHT+IH+kkMkps3us0n0VAwLWIk1/Epvn9w3K7C6m2yPH8Pqw4o93zDl/OtgOPDoXNVxhlsEOcBo8Q==
X-Received: by 2002:ae9:f10b:0:b0:781:5549:d12e with SMTP id k11-20020ae9f10b000000b007815549d12emr14079209qkg.3.1704307620124;
        Wed, 03 Jan 2024 10:47:00 -0800 (PST)
Received: from LOCLAP699.rst-01.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id o21-20020a05620a22d500b00781a147e444sm3693370qki.92.2024.01.03.10.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 10:46:59 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/8] station: add debug events for internal states
Date: Wed,  3 Jan 2024 10:46:34 -0800
Message-Id: <20240103184638.533221-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240103184638.533221-1-prestwoj@gmail.com>
References: <20240103184638.533221-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This gives the tests a lot more fine-tune control to wait for
specific state transitions rather than only what is exposed over
DBus.

The additional events for "ft-roam" and "reassoc-roam" were removed
since these are now covered by the more generic state change events
("ft-roaming" and "roaming" respectively).
---
 src/station.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/src/station.c b/src/station.c
index 8f310ec8..79f25d73 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1556,6 +1556,8 @@ static void station_enter_state(struct station *station,
 			station_state_to_string(station->state),
 			station_state_to_string(state));
 
+	station_debug_event(station, station_state_to_string(state));
+
 	disconnected = !station_is_busy(station);
 
 	if ((disconnected && state > STATION_STATE_AUTOCONNECT_FULL) ||
@@ -2222,8 +2224,6 @@ static int station_transition_reassociate(struct station *station,
 	station->preparing_roam = false;
 	station_enter_state(station, STATION_STATE_ROAMING);
 
-	station_debug_event(station, "reassoc-roam");
-
 	return 0;
 }
 
@@ -2366,8 +2366,6 @@ try_next:
 		station->preparing_roam = false;
 		station_enter_state(station, STATION_STATE_FT_ROAMING);
 
-		station_debug_event(station, "ft-roam");
-
 		break;
 	case -EINVAL:
 		/*
-- 
2.34.1

