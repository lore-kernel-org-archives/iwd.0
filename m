Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D715D1C871D
	for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 22:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724451835; cv=none; b=Fo8008JxluLNZcDxzRinx3vS+v+iMkS8h6y3hwcQhjfJRvB3q6VkskZogPeSb8j7SxYFJA5aLCwjwFqjgbo5lTdJABuABlvkBAxRja+Nxpiz5mZjoV1rxQxq+EmqOq4oDZsvZBkfTZ/Hw+9LsRWo9EL42tlJVOG04GuKV4q9Qqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724451835; c=relaxed/simple;
	bh=77WYaDfYJJhEeptfZjfnvcSpDbjqVudeC27c8zeK0+g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gf6TeHoX7KLrmUsoGkbuUGiVeXAWwmHakV/MgbRpe+qwUQAHT13fjYcXBT8ANO6eOZPP1Cv9IucCKGifF1zcA1qPuW/1rwnIbjIgx6qc5u/3cE08IlE6A1IfvUGm8vEfLbqo3t86/aLXAhIdpMFZ08hW5d7iRos1SHY/krgqRXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5Cx/yba; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5Cx/yba"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a4df9dc885so163682785a.0
        for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 15:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724451832; x=1725056632; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WhCvMDPW8lt7t7wlMZm6/J0hw/xGPZvrfOiiaITr7Ak=;
        b=a5Cx/yba8nmMwrG/smD+/PEpYoWSCRgsauUDdUMRMzPJbF4uiGR7jbh25S8VE08b+9
         DEsFvhkA5eVlCgDqsZx5WrL9dBLfdXp6M2V2/EwEdntyF/s9T3j6mPHzNhyFpwHYMhHM
         TQy7UrVa7FmbXqK9AswGduXlC9IRih/rERMzA0fzdKA4Hjzre5YwWTgyioX9dxCv3/WE
         A5/WFBTZg7TVMCy8XX/v+OBbBGM28PvqtNuwksT8JFA0BuZ0J+9QTVOAe+eHox39mvVO
         /d5vqObUwNg+zR/3HKfC7jk3hFAq8VFHTL0RZ51SEacJJoyWvyCNNXnqpmH9ILEbbPcV
         GGvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724451832; x=1725056632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WhCvMDPW8lt7t7wlMZm6/J0hw/xGPZvrfOiiaITr7Ak=;
        b=kL3Rf/2kg7LuPgXNFhO4JAcKa0uE9rIWILEr1YRW76vY//EM06FZtJeuSvTGJjZs2B
         mOT85TJ2aRFgEeMg5PdUyNfZ65VjkfXU2xd36gxPM0l4MlJvpAkIfdLrxgWiIOOui0cF
         SSAkR+xeQnHy6nEAM0P2ZljUuoxy+U9K4Nlt78MBXh7ZGZMy5LvnEpHVapOVIj7WRL75
         7VYS12LjkuQTPLovGRFztbnIJOPBDtatyDnxN5DHUBVBouHJnQT5gI6UvT6KAHHerJmv
         tOeF+JX75QdHrEavICWeIAlbooYbmYNOqBJfjTZg+ZEEXrIMIyxTu/P8w+yNNbiM76h8
         GHFw==
X-Gm-Message-State: AOJu0Ywdz2VaedkL0bq48Smd5kXmtQaOp6/59FjYSj48yTckHG5Zhgg8
	89arxYuIRFfeTyUDv+oLoUwoFGdy0Ma4TYkvYsQflkNYXulemMHYL/pCRw==
X-Google-Smtp-Source: AGHT+IGoMaFYtVnqv9LWIRVnA7XbAe5JzwPwIOxavIZUB5PgPyC0ejSaI9PZwaUk4mawTcZsYmeD5Q==
X-Received: by 2002:a05:620a:178c:b0:7a3:505f:62ec with SMTP id af79cd13be357-7a67d3fdd0bmr1482303485a.10.1724451832641;
        Fri, 23 Aug 2024 15:23:52 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f41f507sm218860385a.132.2024.08.23.15.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 15:23:52 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 6/8] station: Use Affinities property to change roaming threshold
Date: Fri, 23 Aug 2024 15:23:37 -0700
Message-Id: <20240823222339.328006-6-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240823222339.328006-1-prestwoj@gmail.com>
References: <20240823222339.328006-1-prestwoj@gmail.com>
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

