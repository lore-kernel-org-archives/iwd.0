Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E77A3CCFD
	for <iwd@lists.linux.dev>; Thu, 26 Oct 2023 20:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/Xas49t"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-778a108ae49so198479085a.0
        for <iwd@lists.linux.dev>; Thu, 26 Oct 2023 13:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698352027; x=1698956827; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MrJAgnVQwRPpzzzDsBMRhu+7IsVhw5HTRlf8DLudn5U=;
        b=M/Xas49t1h9JD2bieLd9EO/87Co/iR38JtvhWtWmEEEeH8zHVpWeUSj3sK1p0H7xWi
         6HYekX4unaoz89R7cB1/FlK2EA/abeiTTRT3TQ7eaqSxXwyTOfayp+RPH4oAWU51tIRY
         6DQjTVwEi2wOObShcjgcs+pd+AN3XcSqLLkBYIO37Z0Ta3ZmglyZVyPrw+FQq3i4iQay
         XuXk7W/4vnHvuQ4CyAKnQOXYKQp/ego+JG38jLKasPv+OMG2f7jKpjTQHzc3iX7jVs9p
         dGHGpUT0F0sBkdPUZNMlYsQ+6lT2tdO1f++GeSQqsPVhwyC3vTaIiuSxeoryxteJV1tg
         jXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698352027; x=1698956827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MrJAgnVQwRPpzzzDsBMRhu+7IsVhw5HTRlf8DLudn5U=;
        b=r93m5Xqk8hl6Ei3AxHi7J/RDCFXGPp9QvA6P84brsUV3Tg0d/aYx3cVljg3KaKW7/A
         xb416I+zEI8yi1fqM9UR+U6sWSXPwM67vg7I1erJhixPF1hnB7Mvhc8ejisWHdBiaW0J
         vc7HT1lv8aTdGxXbLiOF51i2Pi1TsvHC/g7cuas0zNxC+8DZtLhEy9+0a8XfmNYDo9x4
         +RM3s5CfIi9h0679PSOmuKMR9iNmfl0Ba/3BaLXO1bgbAvkaP2eBURbFV0tfL1wHfFZV
         nf8xsL0FbXXmu/Qm7nVn5AHySql4iFXcknRKeCBtC3zdxSc+tWJ6RE4b2EdTaIkwfamb
         1UIA==
X-Gm-Message-State: AOJu0YyPBYChyDCPAReDLVJAoHoYtHxJgraO945t7eaVq6gEKYvSe7PU
	jGG5pqFKX0MsCArRDhFyL2BV9x/DxC8=
X-Google-Smtp-Source: AGHT+IEZjEN9de5oq4hTVjM7fVcfCjSxQPORO4AoVKGcRVLvIUu/aoPvI27NB7WR72bbPGUW5CHXZA==
X-Received: by 2002:a05:620a:408f:b0:76d:a784:9685 with SMTP id f15-20020a05620a408f00b0076da7849685mr1219029qko.28.1698352026847;
        Thu, 26 Oct 2023 13:27:06 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id r4-20020a05620a298400b007742c2ad7dfsm7303qkp.73.2023.10.26.13.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 13:27:06 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 01/15] station: add station_get_autoconnect
Date: Thu, 26 Oct 2023 13:26:43 -0700
Message-Id: <20231026202657.183591-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231026202657.183591-1-prestwoj@gmail.com>
References: <20231026202657.183591-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Getter for stations current autoconnect state
---
 src/station.c | 5 +++++
 src/station.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/src/station.c b/src/station.c
index 9b224e5a..2b88335c 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1697,6 +1697,11 @@ bool station_set_autoconnect(struct station *station, bool autoconnect)
 	return true;
 }
 
+bool station_get_autoconnect(struct station *station)
+{
+	return station->autoconnect;
+}
+
 static void station_roam_state_clear(struct station *station)
 {
 	l_debug("%u", netdev_get_ifindex(station->netdev));
diff --git a/src/station.h b/src/station.h
index 24fab321..776641c6 100644
--- a/src/station.h
+++ b/src/station.h
@@ -87,6 +87,7 @@ uint32_t station_add_event_watch(station_event_watch_func_t func,
 void station_remove_event_watch(uint32_t id);
 
 bool station_set_autoconnect(struct station *station, bool autoconnect);
+bool station_get_autoconnect(struct station *station);
 
 int __station_connect_network(struct station *station, struct network *network,
 				struct scan_bss *bss);
-- 
2.25.1

