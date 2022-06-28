Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE18C4C98
	for <iwd@lists.linux.dev>; Tue, 28 Jun 2022 21:59:47 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id go6so13896599pjb.0
        for <iwd@lists.linux.dev>; Tue, 28 Jun 2022 14:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TRfDtk8HaJy8p6giZR7R6zKWR8ucUIxUa7EKm3hKzms=;
        b=gD0zHuh9gS4SJKDRhckvtH4X2S4KcE6fsPtH1zQlhzayAw1/iwu85UBrcwAu6tbZ+J
         IsLyJOzVYbE9KT52weyUmMvfNP2GJo6J/B+ybwRGY7CkiHp+gxk72nqrRFUMsnt2Gh9d
         ay8PPPVGbIw1TaROtPnOaAY3+DqPtuxGHbcbgp+1iH4y+9rJs7/zVspMVd6Gsfisxwwj
         +E2cMqCttwYr1JEjOAufEtEWUSumIQEAyxR/BZBVK0H5Txhn2nnIuofOcfvdMsgItLZe
         MRsNe+sACbOKNDi5TljVUcXkR00kmdgPoCHhDmRjEOD5Liid/BIblJv0fKeQzYL3Ns1J
         F5iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TRfDtk8HaJy8p6giZR7R6zKWR8ucUIxUa7EKm3hKzms=;
        b=fuWnu1cl3sQt5cilr2lVf24iHosevGjrcfQAuqPH4xnPnXfO7to9eETBTizJ9BUfnE
         oNndD9Gq0JdxfOZpxxqydbqhamF6/OF4BLz805xqvj2JkITVXx2wRt4QV/Iiv4EZJt7C
         nRutbe7+QelvgeGc+7ArTXWvL4kNzMLR13EsICiFlxU+eWg1ijVli6le5Tzty5AIJhLS
         8Q9H/GfR81qGMPqBWTldzQACu3eCzz+RbSVgyOyPaPEqMcPshPtLbqt4oEoCEjN6UV79
         p3w4R9PQLoh5WMKCscE/3hez0fHXeIWj9VENt+wkd+jPZE2/82p+wI9hZoouGxgeNWSn
         BKXQ==
X-Gm-Message-State: AJIora9UV6Vh98hi1MWEy/EYpeu0USY9ldI2GM4QU+bmIXkzFOGeD78n
	ziO78IpjkHfhs41EK3Iqp3kydsnhT+c=
X-Google-Smtp-Source: AGRyM1tv3eW93UJitKw9augI12V4ZMW1aCXtNXjLnjybJUuJ3SKiSsmlMT5kuICB4SOHEjymqvxU8A==
X-Received: by 2002:a17:90a:9f03:b0:1ed:53c7:aa11 with SMTP id n3-20020a17090a9f0300b001ed53c7aa11mr1998081pjp.39.1656453587002;
        Tue, 28 Jun 2022 14:59:47 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id v6-20020a1709029a0600b0015edc07dcf3sm9851473plp.21.2022.06.28.14.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 14:59:46 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] client: fix crash from unknown properties
Date: Tue, 28 Jun 2022 14:57:39 -0700
Message-Id: <20220628215739.2332211-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dbus proxy code assumes that every interface has a set of
properties registered in a 'proxy_interface_property' structure,
assuming the interface has any properties at all. If the interface
is assumed to have no properties (and no property table) but
actually does, the property table lookup fails but is assumed to
have succeeded and causes a crash.

This caused iwctl to crash after some properties were added to DPP
since the DPP interface previously had no properties.

Now, check that the property table was valid before accessing it. This
should allow properties to be added to new interfaces without crashing
older versions of iwctl.
---
 client/dbus-proxy.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/client/dbus-proxy.c b/client/dbus-proxy.c
index 0373a3df..624ce4aa 100644
--- a/client/dbus-proxy.c
+++ b/client/dbus-proxy.c
@@ -107,6 +107,9 @@ static void proxy_interface_property_update(struct proxy_interface *proxy,
 	const struct proxy_interface_property *property_table =
 							proxy->type->properties;
 
+	if (!property_table)
+		return;
+
 	for (i = 0; property_table[i].name; i++) {
 		if (strcmp(property_table[i].name, name))
 			continue;
-- 
2.34.1

