Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA6A1AB503
	for <iwd@lists.linux.dev>; Wed, 28 Aug 2024 19:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724873081; cv=none; b=dGIzwU0iTRjT1w2Now8GeKcgndeDYzSnFhY2nj+zqKChn+fKg88oxERB42mu2si2q9JDpMG3+rgQfe48mXvNq9GwFJjE1UXeesPxcPtCiUxGehLfjMkiJaVxqElhJS8I1PRcImiDU45YifVgmd9HoeuCLVIXJiIHFLUdojRjM7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724873081; c=relaxed/simple;
	bh=QEhQJHRbOrtm97/kyHCtpnjRP4hsLDz84/vKfst8oR0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j0jlL/r/0JO7rf3IkXDEIQNOlWYlt99HtfIk/ixEkn0jiTbn20rqUh02hdbwOu6bZdd5coOhKGsw79dDNLa+fIGJjCbDL54PAL/AFOPwuWCPkPdj1ZKPF/+JqtbHDWPOoP03jekJS9y3lp0oJpptaMaV1kpSauA0Y7dyfZBGjq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UUnTvUkb; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUnTvUkb"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7141285db14so6073719b3a.1
        for <iwd@lists.linux.dev>; Wed, 28 Aug 2024 12:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724873079; x=1725477879; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nb9s9ZgiN2zlEoTES0mbLk7/Twa3l4AT7LI5Y3bD6LE=;
        b=UUnTvUkbyDeuv0k84hFcj4wab8DS8N2QpWnHjx5wAGS851iBW1nSmoQBY9i0R3vq3P
         3ZqzvJJiIboqo9TcnVwcetdHtL1xkV5AhUWAnp3AJuc/Bw3JPcWl9QQbNSaAHlV5Q/1R
         DUez4rJPVL0fSKKWCbd/mrt0yKjOQ9fE/l1jb+dsL37Oh3S1qIfLZmpqWTBqyyoD6I/h
         nko8fStQ/kzJ8t5CU+V3Rtzde74PgNExYeWnpMZVbCUC4NWnAhaItUAyI/7c7tfxv9ZK
         6y0t0Y5RfGfiJEbCpEiIMCp7oIk7vaNjzy16dm98dCDH3HbdLoimoaBMDIwWPwjIVCtO
         f28A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724873079; x=1725477879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nb9s9ZgiN2zlEoTES0mbLk7/Twa3l4AT7LI5Y3bD6LE=;
        b=EAkOp6JUOJuHneYQPu2xns0knE3ISBdWWRuUqOG8nwtuWEAR3DddAPmp6nKrP/Co8w
         G/r/RkP5eCQdeLiFoa+BYN8UEC4aB/0CtnN6HfPaUd2G00nykTX2LNM0k57E+vDP51RW
         WtVNB8HeaQaA/d8zVicVVeDoBX0b1aAmiSkrql0UfGTz2D4oBe1MrRL1+PxZiDybfxE/
         iSg3VFA4A3O/HqjFFDwYMcxNLIeyWR+RCxChi5bBCt76D0WnCRgJlnhNVrSnXAyx7JYq
         GOZMlQsvRxYj5xNF8WU3dEZzOBiXYdGygmgaw5u37WOaX3doFFSNNthXcAJy8Sicj7FG
         dxOw==
X-Gm-Message-State: AOJu0Yz7OZ9nWpsYH6T9XNwbbjx02OtCLNCr+NRT4wKaSnXHuYPBv7fT
	H1+Blw3QlHfYITBPRzCd6WP7WsbQt1V2ALU3/U8U5lGCFFkiesgm6ftPTQ==
X-Google-Smtp-Source: AGHT+IHIlii7Fs4EzKbUnolhUS7u9ZzaOEOaNInyy/FEI5MENQyk0qUjo6B9sJrRWy+ciCCcJ3jang==
X-Received: by 2002:a05:6a00:c92:b0:704:2f65:4996 with SMTP id d2e1a72fcca58-715dfb2e239mr575903b3a.11.1724873078902;
        Wed, 28 Aug 2024 12:24:38 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ac994a3sm11081635a12.16.2024.08.28.12.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 12:24:38 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v5 4/6] station: Use Affinities property to change roaming threshold
Date: Wed, 28 Aug 2024 12:24:26 -0700
Message-Id: <20240828192428.902761-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828192428.902761-1-prestwoj@gmail.com>
References: <20240828192428.902761-1-prestwoj@gmail.com>
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
index 1eeefe75..c45d13df 100644
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
@@ -4612,6 +4615,7 @@ static struct l_dbus_message *station_property_set_affinities(
 	const char *new_path = NULL;
 	struct scan_bss *new_bss = NULL;
 	struct scan_bss *old_bss = NULL;
+	bool lower_threshold = false;
 
 	if (!station->connected_network)
 		return dbus_error_not_connected(message);
@@ -4665,6 +4669,8 @@ static struct l_dbus_message *station_property_set_affinities(
 	if (new_path) {
 		l_queue_push_head(station->affinities, l_strdup(new_path));
 
+		lower_threshold = true;
+
 		if (!station->affinity_watch) {
 			station->affinity_client = l_strdup(sender);
 			station->affinity_watch = l_dbus_add_disconnect_watch(
@@ -4677,6 +4683,17 @@ static struct l_dbus_message *station_property_set_affinities(
 	} else if (station->affinity_watch)
 		l_dbus_remove_watch(dbus, station->affinity_watch);
 
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
 
 	l_dbus_property_changed(dbus, netdev_get_path(station->netdev),
-- 
2.34.1

