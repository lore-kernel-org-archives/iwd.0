Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E5018787E
	for <iwd@lists.linux.dev>; Mon, 19 Aug 2024 17:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724089929; cv=none; b=OxVOCreO2EKbH8MU9l9ppIXClkpDJiyvPEfCWjV2gn3nSThhQyn9VNGzodpgLDikTmG+ZEwHHq6CfXT3vmqd464XGzulewzeqNxgIYNGGCg8Dky5DnxIDv2xAXpk7Dyq0NkVKcCquu59Yiu1N5GWta/Kcy91Gx8+Bf2ieZWpyCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724089929; c=relaxed/simple;
	bh=O2Tm/DmKVyNIBo1VCiKb2tFPdHzhCB6yuWw9ik1DHns=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MX7wvSJGupJtjwEOC6gMs/dI8MpTsKvf7nB/HiAdw+GgH6dIM/wkp0DZsJLJGPWzIQg4SjxOkDfPiXR2paNOUWoUYKIrZxqfyay/y8LFb22/8CEUKQMn48CJGItxzrdSUhJk3SpnZh8TdNeFo/SwcKKxIArSVnioeyWH+ZdcFfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MHYsBIqv; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHYsBIqv"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4928fa870a9so1342228137.2
        for <iwd@lists.linux.dev>; Mon, 19 Aug 2024 10:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724089926; x=1724694726; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/p0vLPm1eouQISn2iDnK/ypztLjVsmPD/wZd6WRG3ek=;
        b=MHYsBIqvyYWtNH3a5PFeBTyCSTpDLfmsr+xymY6a2NSpx+QF8CTrmn35i9Kz5P6cRs
         bRadSD0afMpW/PHEMNoqowKmMDIDJQ5Ypy6NPoEBn7GYJ0Fg4r3sQY8Wlk2U+J9Geu97
         hd0JfRTatkyX8kmeo7pkcWxLu3FKcmbX9xUtsYY5AI90QkgWK4IBFhfle0aIDmsDbMrT
         R1Rsbn82eYXFFduvqwilVsTKHy0kupuuerEO51lsEwKdfm2JnMq3HUgZiIK4rH7aKOyH
         7Zs0qbdu+0TEVMR/l2fj8ulrMWBwR8UvF1KAq3shuY4ynP5QPpvJehXQcFbmNwNy9PMR
         tAhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724089926; x=1724694726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/p0vLPm1eouQISn2iDnK/ypztLjVsmPD/wZd6WRG3ek=;
        b=p4Kv6B2bYT5m1T/tndH2e8RcbvC1Iipama0woNFv3OD+crEJwQ0eCFv+D6BatKh9Td
         OnvpcBMfd4pdO3UBCaqlJAj00trPjUnsVHMYLWrHTk8jWo/o2Eb8U92pns8eYrVwpQbf
         /VCo91FlCh0YbpOvwj+xkMDlQbn3KfTAtrRzIGcA47iGyYhi8xF76p1UIoaVTqUzT6JE
         x6JVIba1tbKClNUh6OS8EnRsvJmmB5XnbL4bqTXREIU93eZOdbpAdHRLxfiWu+6dBSrl
         iedFASdzvtTUU0H2hAI0ZSkfLExKCagx0GE+u/HaSdVdnRppJlYn9jnL+n7gjmeLwEJJ
         5Ahw==
X-Gm-Message-State: AOJu0YwrN3EEjJEPWgIUHtBvDpq42O3+XImdL6TEbPLggqYeK1zf1vIi
	tL4FWSH65UXIkppaNK/Zzkp6VcZCWbAxTg42LC0Jn4LgvOBJGwrGygyzuA==
X-Google-Smtp-Source: AGHT+IEMcHF4F7tL8tmBHNdINOgSp1TO2ABU5TRAAh54bys+18walgod9Jbk2pyMFZ0l/eD8w3W7qw==
X-Received: by 2002:a05:6102:1626:b0:497:70db:ffc5 with SMTP id ada2fe7eead31-49779930599mr9712945137.8.1724089926221;
        Mon, 19 Aug 2024 10:52:06 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff0e5a1csm451854685a.74.2024.08.19.10.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 10:52:05 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 6/8] station: Use Affinities property to change roaming threshold
Date: Mon, 19 Aug 2024 10:51:49 -0700
Message-Id: <20240819175151.1310546-6-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240819175151.1310546-1-prestwoj@gmail.com>
References: <20240819175151.1310546-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the affinity is set to the current BSS lower the roaming
threshold to loosly lock IWD to the current BSS. The lower
threshold is automatically removed upon roaming/disconnection
since the affinity array is also cleared out.
---
 src/station.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/src/station.c b/src/station.c
index 3b64cd75..31faa5e8 100644
--- a/src/station.c
+++ b/src/station.c
@@ -4580,6 +4580,9 @@ static void station_affinity_disconnected_cb(struct l_dbus *dbus,
 	station->affinity_watch = 0;
 
 	l_debug("client that set affinity has disconnected");
+
+	/* The client who set the affinity disconnected, raise the threshold */
+	netdev_raise_signal_threshold(station->netdev);
 }
 
 static void station_affinity_watch_destroy(void *user_data)
@@ -4609,6 +4612,7 @@ static struct l_dbus_message *station_property_set_affinities(
 	const char *sender = l_dbus_message_get_sender(message);
 	const char *path;
 	struct l_queue *new_affinities;
+	bool lower_threshold = false;
 
 	if (!station->connected_network)
 		return dbus_error_not_connected(message);
@@ -4645,6 +4649,8 @@ static struct l_dbus_message *station_property_set_affinities(
 			return dbus_error_invalid_args(message);
 		}
 
+		lower_threshold = true;
+
 		l_queue_push_head(new_affinities, l_strdup(path));
 	}
 
@@ -4654,6 +4660,17 @@ static struct l_dbus_message *station_property_set_affinities(
 	l_dbus_property_changed(dbus, netdev_get_path(station->netdev),
 				IWD_STATION_INTERFACE, "Affinities");
 
+	/*
+	 * If affinity was set to the current BSS, lower the roam threshold. If
+	 * the connected BSS was not in the list raise the signal threshold.
+	 * The threshold may already be raised, in which case netdev will detect
+	 * this and do nothing.
+	 */
+	if (lower_threshold)
+		netdev_lower_signal_threshold(station->netdev);
+	else
+		netdev_raise_signal_threshold(station->netdev);
+
 	complete(dbus, message, NULL);
 
 	return NULL;
-- 
2.34.1

