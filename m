Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF8F314D37
	for <iwd@lists.linux.dev>; Thu,  9 Jul 2026 21:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783633555; cv=none; b=IlEEUSy+xrH/8KIBpA2jXGFljmQ3lcc/iSuhzrPhue+j5lSAjaQ23xu/Vi1eDcMCYT3MG8HB4n591vjzgPvmoHzlijFAGJW/svBjX1tghAiF7f6sjAd4YBmJc4/DJIB/3E5/U8M5fRV4vavbIG+DO+VdbBlnR2Ljfp+aLyyrRwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783633555; c=relaxed/simple;
	bh=ua338y3NmzGI+L0+Je1Ee+QjrzUrkRNK+vao+qO7cLQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=stzFJV2dx6iNrFQ4IfBBSNWyYgLerFFstJLx929W6NSF4io/ZtEAW5kfTqOGzGf5b0q4diwWijYAzkxRyD6teHd04DkZC5RSYYfvSTFn4ByxVm//wbVcm79UgC5Lb+N6bQDZRG0ZOZTJfYApZkGJ/WwZ7uON8mOWTfLTlQt7jMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sE1wfm+V; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sE1wfm+V"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51c2c8f43aaso2056731cf.1
        for <iwd@lists.linux.dev>; Thu, 09 Jul 2026 14:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783633553; x=1784238353; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0I6Z4G5g6B2NEPOYHFwFJ1WQcKWrdL+W7lri2taE22Y=;
        b=sE1wfm+VIfQfWs9BNyY43+Fdui+5Pm+TSywrJ8nHwOxx633BsBDvvr8PYCC+xZ9Nsk
         Xa7HKYOioeTbNOXZvW6C47U+wt/iiRuSG7Dq+mSKIK0ADoH8giXUmJOepuxc9niycjpx
         +bZhjWXgVv5pcVX4376YL0mLWOcvUqzXQfyE/WEjLRs0d4uEFQzJvHBBQdQNtB6cocR7
         v+LscpgPAuSmuDrILRbSL5jLwyt7bxWG4bdaYC8kuU+4yWGdM2z8TNFI96OfTie2l4WX
         Sul015a8I1USRtMzRWSw3phT6DNlt1/Usq/aD4pRUt8F3N5x7TNuoVxi004v19S2/jFJ
         a0Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783633553; x=1784238353;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0I6Z4G5g6B2NEPOYHFwFJ1WQcKWrdL+W7lri2taE22Y=;
        b=ZvqCtpW5le+PHv6vIJXM2eVAFRMb5UKCcp+P9MJsOmyu/TUOLCPAXkX0y7CM5jxF+a
         8ybAiPU0+5K4zJmHtatPd9gjjdo0oeITWOl/enFAqix2pD5wVDW81o7lQG5wUoBeNhUi
         18yt9cniwrjIgskMHgIwuR/UVGyo6//XEdWZSLlFtFBP4Fo6cTm7kEALD7+6rSO8dFDd
         wgkZOJO1wmYYCjlA9kYCSQZehguCrWDQjSD8Fbtf2/GHC31cgpoO9tYXxyAguiHkbwYd
         r0tumM8BB6aC+tOQWcinZCgG21jbmQCcjFDcRp89NTH9wovVP6AtpSc4jt6v7by3RPc7
         MJtQ==
X-Gm-Message-State: AOJu0YxzPmyZSQwbLWpegKwX1TUdXWJSFAgqFxvYvOZU8w0slcUaQVyx
	NFSmZs+toKYkJYvLwUzfAcK/6csKPOk2Jq+5lMulokUZst2zf8P1a9H6hm29BA==
X-Gm-Gg: AfdE7cmlg4+UiQ3N0IgTnjjFkBnupENxzJJKM6efbCsrriD40H0yTR1KvOWGO0+0D67
	7gtuNdJHTAAhli/yvG8m2nDAruzGax188jn6bCNeommA12Eu0NFZ4I+dOP/Pc2iCMVqgCBZcNbE
	EImkr1rgNK28aPovlzDacWFZJmsM+BJejSzMpZztK3/HsrfW8jlXKPPNC1aHEEWl4i/AxIj6uJb
	0gW6bfrYFmbXvZqLaOKYZt4VGU5cf1q1GLZt07mxUVNbsjMRm1SisQ22mUUm9EYm5sQ3RgnDMzO
	F41V908GOxoQ3JSh3OjbCg2jCfjcSqN/iga433L+5tLsMHnFYIY6S3K9AN5Hn9Febn3znYHvsuw
	EOwyguEROwEQGZEK6ZGwGFcFU4PUNgwVRdti11vje3ibx2Sz3IlA1GinHycrgxGiAPdRvqrY8Hi
	z7tIPdsRHmumjWZqhAMf6iZV+pLKiXnNabue/GMsg8fGeFLyBoZ8mkCWdXai25wzLpiZ62je4+1
	fburWg=
X-Received: by 2002:a05:622a:54b:b0:516:e062:1a83 with SMTP id d75a77b69052e-51c8b549a0cmr94947921cf.51.1783633552734;
        Thu, 09 Jul 2026 14:45:52 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caab6d574sm3857641cf.3.2026.07.09.14.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 14:45:51 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/3] station: Add Utilization/SNR/LastSeen to station diagnostics
Date: Thu,  9 Jul 2026 14:45:44 -0700
Message-Id: <20260709214546.659971-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For metric gathering and general debugging its convenient to query
the last known utilization and/or SNR from the currently connected
BSS. In addition another property was added, "BssLastSeen" which is
the seconds since the last scan returned the BSS. Since the
BSS's beacon info (like utilization/SNR) are only updated upon
getting scan results we need to also advertise the "age" of the
data so any consumers can decide whether or not to ignore these
values if they are too old.
---
 src/station.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/src/station.c b/src/station.c
index 8fcf8c70..05ed043e 100644
--- a/src/station.c
+++ b/src/station.c
@@ -5337,6 +5337,14 @@ static void station_destroy_interface(void *user_data)
 	station_free(station);
 }
 
+/* Gets the time in seconds since the BSS was last seen */
+static uint32_t bss_last_seen_time(const struct scan_bss *bss)
+{
+	uint64_t diff = l_time_diff(bss->time_stamp, l_time_now());
+
+	return (uint32_t)l_time_to_secs(diff);
+}
+
 static void station_get_diagnostic_cb(
 				const struct diagnostic_station_info *info,
 				void *user_data)
@@ -5346,6 +5354,7 @@ static void station_get_diagnostic_cb(
 	struct l_dbus_message_builder *builder;
 	struct handshake_state *hs = netdev_get_handshake(station->netdev);
 	uint16_t channel_num;
+	uint32_t last_seen;
 
 	if (!info) {
 		reply = dbus_error_aborted(station->get_station_pending);
@@ -5388,6 +5397,23 @@ static void station_get_diagnostic_cb(
 						's', str);
 	}
 
+	if (station->connected_bss->have_utilization) {
+		uint8_t percent =
+			(station->connected_bss->utilization * 100) / 255;
+		dbus_append_dict_basic(builder, "ChannelUtilization", 'y',
+			&percent);
+	}
+
+	if (station->connected_bss->have_snr) {
+		uint8_t snr = (uint8_t)station->connected_bss->snr;
+		dbus_append_dict_basic(builder, "SignalNoiseRatio", 'y', &snr);
+	}
+
+	last_seen = bss_last_seen_time(station->connected_bss);
+
+	dbus_append_dict_basic(builder, "BssLastSeen", 'u',
+			&last_seen);
+
 	diagnostic_info_to_dict(info, builder);
 
 	l_dbus_message_builder_leave_array(builder);
-- 
2.34.1

