Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7179F14037F
	for <iwd@lists.linux.dev>; Wed,  7 Aug 2024 18:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723054483; cv=none; b=RgPG+X86FdOHqIJnWcm49Vf8dGzD7pIaN8Z8IOfvyid1iI8RArhKPzpqzv/2tNjXYdEFWSjQhp4RAvZY9AUX2oKH4hpnDTZmm3JxwxhrO6LU/Idjx+aEzY6Y/OlpgIcZh7QPWnYL5CuLAyKRKETHaDa5CV/Uy/sqpBBlTz1eH84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723054483; c=relaxed/simple;
	bh=khDb1JzHSc71QI9zEf0s7g+88AyidS87t6JIleKMjgc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oGGdx3Y8l16VYtRuIa94SLBFXvDFP0JzThHSbq/cn3aQ2HGlgUFwh/KrcWXI8/0NlzcNzIBDJUUAjEdqowcYiLXknJisg7a0Gi1GtWZQf2xnqJpoGwu5xdR7MM4qdqvYIU8kTq4noT0yTSYyCdniJ460H5HUljwMrgNQxcHK0B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DqGGXRFo; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DqGGXRFo"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a1dcc7bc05so13842285a.0
        for <iwd@lists.linux.dev>; Wed, 07 Aug 2024 11:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723054481; x=1723659281; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZBJoNkVUBgZ/+odBrbXlzFdMC8QOarTMTEXdnrZB4M=;
        b=DqGGXRFoBV72uXCSFS479USh7+/+kNTT6/ZyOpod0ZgVBfqWhkadmPQtM3ajvdaZdj
         fa9dPzQnWKdgXI7jeLxqRZWyR+G6P/vS9AP8D1ekkXWWZMznZrB2E1Urgd+LHEIFbkPQ
         Mt9d3LkFZbNjOV6ogSblhmijJOM2EYZzyXxtxWkm2Fo3PNm8jlhFvb7HEiorJNDrmw2q
         unJrd8CUM6Gtc2ezcLyqUZwZYhtiMX/Rt5buDF/ii3NxAvyn/03kwWjDfvVcKQiqH7bN
         yIcpuv01q6SeeePCwddY5ufTZnprUCkD7nYN0gu2Y4/JgDWS1m2PEH8lyITpSvcIBtpr
         QbMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723054481; x=1723659281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qZBJoNkVUBgZ/+odBrbXlzFdMC8QOarTMTEXdnrZB4M=;
        b=ceSn1akBtWktd6sW1wRqWYXkG0bjMQQGUyLJ6VYhNtm2FMauXfImpvxvv3ttaTEwt4
         AHmeuIIDzvyxSq6r4yCptWRhJMM6EJAgTYVFNif5f7znQa1hB3FFBXtGMkishk1Nuaw8
         BTJAUxpej6V3uiOLpkCMKm/DAe625400wTLGKFeOwariXNa5H7S0ZfiX75ao1Zzce5ye
         7R1qgY2FBLxJPSMT+yvzQEU1AFOrqUj/ZGkGoEVnGicFFyK0IsufwIMq8tAus7/g7dwO
         vAgdR9SZw6/yB5dA0RlZlV2m+1hQi0LqHUtDjctmKmR1IWoP5M2pwOELRn7dS5JuVw1Y
         jQWg==
X-Gm-Message-State: AOJu0YyhZcIdN72Blxqy4mX2vZmH1VzVRutT4zMI7cK/BB0b5K9Ssyjm
	AjeIw2LOgR4rTIVcu7KfnIWXnKEQJiFrYAWp1gl6DNWLrMrQf+bqXzKGWg==
X-Google-Smtp-Source: AGHT+IF4O27QW1emjr10NG/Wv8surlCb/bIY1xvvIvESIoyqdSS5pmFj07w9APwqx7MFGcoWYZeUfw==
X-Received: by 2002:a05:620a:2909:b0:79d:569a:6997 with SMTP id af79cd13be357-7a34f029668mr2177475285a.70.1723054481220;
        Wed, 07 Aug 2024 11:14:41 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3785d0db4sm82194685a.7.2024.08.07.11.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 11:14:40 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 07/14] station: add ConnectedBss property
Date: Wed,  7 Aug 2024 11:14:20 -0700
Message-Id: <20240807181427.170515-7-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807181427.170515-1-prestwoj@gmail.com>
References: <20240807181427.170515-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This property is a path that corresponds to a BasicServiceSet
object, the one the station is currently connected to.
---
 src/station.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/src/station.c b/src/station.c
index 2c4d686b..5a6360de 100644
--- a/src/station.c
+++ b/src/station.c
@@ -4363,6 +4363,23 @@ static bool station_property_get_connected_network(struct l_dbus *dbus,
 	return true;
 }
 
+static bool station_property_get_connected_bss(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	struct station *station = user_data;
+
+	if (!station->connected_network)
+		return false;
+
+	l_dbus_message_builder_append_basic(builder, 'o',
+			network_bss_get_path(station->connected_network,
+						station->connected_bss));
+
+	return true;
+}
+
 static bool station_property_get_scanning(struct l_dbus *dbus,
 					struct l_dbus_message *message,
 					struct l_dbus_message_builder *builder,
@@ -4770,6 +4787,9 @@ static void station_setup_interface(struct l_dbus_interface *interface)
 	l_dbus_interface_property(interface, "ConnectedNetwork", 0, "o",
 					station_property_get_connected_network,
 					NULL);
+	l_dbus_interface_property(interface, "ConnectedBss", 0, "o",
+					station_property_get_connected_bss,
+					NULL);
 	l_dbus_interface_property(interface, "Scanning", 0, "b",
 					station_property_get_scanning, NULL);
 	l_dbus_interface_property(interface, "State", 0, "s",
-- 
2.34.1

