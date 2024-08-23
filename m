Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DC518DF62
	for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 18:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724436024; cv=none; b=l/61hrFzHOfGhPqzv9QqFKGdJjxaiqERBoW2dPlAGi94IpUhOVcwci41tiUdP0fVSV7M/sVh0lRAeSIYx2K9ZtQUAW721RZoLbs5qRfwTp6HQFLmy6e/VovDyNAupB/VsJtr00sVuPiY201/7O3Qy+tWhr1KKb5Z6zps1/Gqexw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724436024; c=relaxed/simple;
	bh=77WYaDfYJJhEeptfZjfnvcSpDbjqVudeC27c8zeK0+g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oYN/vrEpB4KSwOMLwGXyxkaY4X8tKuD9+Hpo15TlIv0D+TPsWI7SKYBEBvtzYYlsp740Dn8zq9anQlnD8Sqt9WvYMYjcvf7JstKTnF0885Nx201SrORVEg7tHCiM0xJB0mosjJtIyErV0HHE7fQSm+L67fS+eBTkfYPwo4bmLOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Urqp05r4; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Urqp05r4"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-70cb1b959a6so1347956a34.3
        for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 11:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724436022; x=1725040822; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WhCvMDPW8lt7t7wlMZm6/J0hw/xGPZvrfOiiaITr7Ak=;
        b=Urqp05r4WLk954B8TT6+mlYOUNSvSbfqMdRzCmVYv0szZuR/jW5NGzvcEJJreqEmpr
         94/WwtVBICNqyp7hBRlGzWM5G794ySUxQRYNQbQNA6CNnStKUJrI35PFeqs+ID4pdJgC
         3mOnTlBC5Dxs2TXhbM8b4tTQ7v18JUocHvm14Gdb50g7pW17+WBPQwPP2auPWci0HSSK
         7/OKMfWiV6UiygO4FHr8Cb0ThkUB13OX+fPfik7dBbrQPjA3ZrlxQXjT3kjV6+h0OSb3
         QH0iKPNKsbaIJJHJirQs2Lu9l+NelG7D+28VnsaTc7xaRIVMYtnlsqoEgz1iOWn+IXzr
         KyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724436022; x=1725040822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WhCvMDPW8lt7t7wlMZm6/J0hw/xGPZvrfOiiaITr7Ak=;
        b=SIOFxDNF8jqXTCpt+BBfTjuh610He7cdCCcRU9crQ+zI+9QFjyw7SK+RaQSywgehx+
         Q9FMop1sAJkzznKkNC+NzqsYk9nj/AUskqwyiKY4nqTNT+rmYchtR5AXCY3w2UJCFxhz
         eO4YdTYgyczjcT1dRSYgq8LJsOCD74D1Kc7V47FYh0fMJaqEvZD/74f4cLGA4kVGVqDo
         VmmooMPniO2CU6VbDtC5HmYIt8ZVAcAnjeUSgeJW1+L5lY0g6F73XWaA0p6oyifNBHgg
         Ad6Np9xhru17QFss9808SPcwTv+eAMvjCdY+YMWU+QZlZvL2NlbxYhW01bO6QXHeHRIo
         VyUA==
X-Gm-Message-State: AOJu0YxObuVLZ+CwpDfYOd6zZgUAFTS4+Pqfblh+bZgRRi/9er7engGc
	Xy5OA4gGTQWLpHDLWlqmfY7rco9/l8drMmyLvTKz8NqhhW14OfEDIgXQeA==
X-Google-Smtp-Source: AGHT+IGkHmFmRtoGal8pZAJuRYnPX+KQYxcdR1RUB3XwxIfZ4trmrQb9dT0CTItIjeUUNsDWyOSi3Q==
X-Received: by 2002:a05:6830:268c:b0:709:2fa3:1329 with SMTP id 46e09a7af769-70e0eb909d7mr2822299a34.18.1724436022151;
        Fri, 23 Aug 2024 11:00:22 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-454fe0f0507sm19683131cf.47.2024.08.23.11.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 11:00:21 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 6/8] station: Use Affinities property to change roaming threshold
Date: Fri, 23 Aug 2024 11:00:04 -0700
Message-Id: <20240823180006.317353-6-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240823180006.317353-1-prestwoj@gmail.com>
References: <20240823180006.317353-1-prestwoj@gmail.com>
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
index c72d42ae..ca0b5329 100644
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

