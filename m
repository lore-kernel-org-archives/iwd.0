Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02B416132E
	for <iwd@lists.linux.dev>; Mon, 19 Aug 2024 17:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724089930; cv=none; b=kw34Bf0v44X9uBMaD5C9bO7ArRnyax8x0mrFEdoPF4/O38HkMFVlTxX51dymHvkbuWyMgiuwhtWs8r7284NfCvMJhex5P212ZfqzrRwES3O0y4WwcgvWqkwpnEiLGy20f6DT1PoNg1yVXhZjbxaLFvTtc2q+Tl19WBzxuo+v/5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724089930; c=relaxed/simple;
	bh=1pYxZdt/cb6QaZROUOt/UXNKrd4LBk55ZWX1Jek2/YY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gLs3lUvZzj3Jp08+EyLkElwx8eLliM4yd89WYbnDPwhOsAvtebyqoNpnnHUTz3CXFyW4wyP65iAoR1Oygl2X/7Fhy6xp31gEfzGz2FpwQqB/TqUK3vGsBBtw/asae8Vdoya1XURueTY6+rZIB4uOTOc2yvidk6HtRVQifgpMUBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UIs2SNQb; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIs2SNQb"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5d82eb2c4feso3026752eaf.2
        for <iwd@lists.linux.dev>; Mon, 19 Aug 2024 10:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724089927; x=1724694727; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6IFPs/YJKFaYy3RoCHH1SN5YV4xFWkPxPc6QvHkhBzc=;
        b=UIs2SNQbR5ngGpyrDttLNIi88Gui37Fm0IMd1HL+7+wTXtWbaZlJS5XR+yS9LWbGeJ
         tZXTGDltvq6azPmS2r/rQAtju5Mv8vq2HjUEBJW6UHeLzjQlLCczxwD7cyJjaxR5iuuZ
         5OeBD7ROKORdKftvVvtvmoHHIOjg20giKKuxpwdi0Ov05o75CbK1e0HUc/w/fj7WO0Id
         j80yAyOJqb7GNmyph2Oa+FwBzZXvIYotK4coeaoEiLvna52EwoUCt1JtW70q+209a6wI
         ZZgCi1edMjr31MP52+JMKeSyaZ00ER2EKOWeeVNq5ucXcWjKgP8BhWDxdAdjjT1xWgAB
         wPLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724089927; x=1724694727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6IFPs/YJKFaYy3RoCHH1SN5YV4xFWkPxPc6QvHkhBzc=;
        b=vc/Famnu1IQ+EULox3JOGtvWtEStNO6BTZWpwuMHao89kopocMj/TEYqQeP3Z/cK9/
         7Ot/WlWh1tn8tIfW3v55g4fr8bw48mA4GwaxcG//dHmGsiL41Iz/LwIr/GDPllr0PaNJ
         9//0f0vUP0vqyCFtis0vH1O1KNPYOLfV5VpoMmJ/HaGHPFK4PZ2pI8O2FAECQKcIZBrL
         ISmHrDl6hcx1FwMuq/3u/i64hOYbAIS2jM26xpBJvaGvB3PqXC0qpoS3qx2ykxMT1xHj
         ipggBiq7sEFcZ4VCxDbPcgMMJ9Bc12bPObcGRUZ3qQ+8yEavttYbbnbgfbKhQSLCSwRs
         UKHQ==
X-Gm-Message-State: AOJu0Yz3PxMeUYM0GDH7Si2uteebT4THJoH6IEgzv+qlALpHo2jgwXJY
	bbVTCxfZr+vHx1M2jBVCQzVqh0aYPYkmUaaYqAEruwq0KW7MacZck2DVgA==
X-Google-Smtp-Source: AGHT+IEt+YkZ+prg8ocwHalmf21Wx/6X559ZEQfXkSaPqBlF38hDD6B/ecZgTnGNtSKytB+6O3wMcQ==
X-Received: by 2002:a05:6359:4c89:b0:1af:4626:7e42 with SMTP id e5c5f4694b2df-1b39330c7ecmr1398627655d.25.1724089927493;
        Mon, 19 Aug 2024 10:52:07 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff0e5a1csm451854685a.74.2024.08.19.10.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 10:52:07 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 7/8] auto-t: add affinities property for station, and extended_service_set
Date: Mon, 19 Aug 2024 10:51:50 -0700
Message-Id: <20240819175151.1310546-7-prestwoj@gmail.com>
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

---
 autotests/util/iwd.py | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index 74bb25c0..83f2d9ef 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -596,6 +596,11 @@ class Device(IWDDBusAbstract):
         props = self._station_properties()
         return props.get('ConnectedNetwork')
 
+    @property
+    def connected_bss(self):
+        props = self._station_properties()
+        return props.get('ConnectedAccessPoint')
+
     @property
     def powered(self):
         '''
@@ -630,6 +635,19 @@ class Device(IWDDBusAbstract):
         self._station_debug._prop_proxy.Set(IWD_STATION_DEBUG_INTERFACE,
                                             'AutoConnect', value)
 
+    @property
+    def affinities(self):
+        return self._station_properties()['Affinities']
+
+    @affinities.setter
+    def affinities(self, values):
+        self._station_properties()
+        self._station_prop_if.Set(
+            IWD_STATION_INTERFACE, 'Affinities',
+            dbus.Array([dbus.ObjectPath(v) for v in values], signature="o"),
+            reply_handler=self._success, error_handler=self._failure)
+        self._wait_for_async_op()
+
     def scan(self, wait=True):
         '''Schedule a network scan.
 
-- 
2.34.1

