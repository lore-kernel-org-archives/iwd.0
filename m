Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BC719258E
	for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 22:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724451836; cv=none; b=GdlknQX+SvxCOQQOGGzc+WoRx4rNVzMlnSu6T44VBnoSpavWKiG/gdX21VcV9rEvvM7jSCvLs64zHhTVeTz+rUtzVIVC1OD+ZQY3gbrEg967nX2QjIGKaRoJgRrPmCQmk2aIA6+bI9kNt22tSXMI1684vYXlVIv9IDmWnjB2WDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724451836; c=relaxed/simple;
	bh=1pYxZdt/cb6QaZROUOt/UXNKrd4LBk55ZWX1Jek2/YY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mtSPJyw/TAf94SRqGIAqnBbTv5oeG6B0pifDX6cl+U9F5cb/FJNGshRRqijtKlGkTbw4afzxrSByfTgaQIRJKf2ddnR9iqonI2LhrLkTxuZCkZYjclXEE/Lu6WyHj2qpWe00yvKhyupKvLGKnMugU+2oTTzV9ZVQXhF9WQ445+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X3xWc3fA; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3xWc3fA"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-498cfbc0b05so878841137.1
        for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 15:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724451834; x=1725056634; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6IFPs/YJKFaYy3RoCHH1SN5YV4xFWkPxPc6QvHkhBzc=;
        b=X3xWc3fAVYJPvetxdCOBTMP3IdhMyi0jbYsfPMruAftIW9NPQWQEzUWIkLGxOvU5y/
         zov3TJyjmVgxZTPofKWBuDimzvH5+mLRPcai9TTt9Im1bUKLX94NXrqSuLhgPA5mRTGJ
         ReHaaA3l90r+duohou44lGq+a8YR5dzdTmaH34zDT4m75AwE/5Q/m/VB4DcSVtjzIued
         W4C/s+puXrDyEa6OmDwZac9DxcZO0CjbYdC0YY455O4Gq1DHrVJpbs3bLtHR1zwdCkl4
         XfB338+E075FiuSkcqLFdwwI6zil8G3xB9onWI/sDpixUwKDS7hVLy78Wd2EnTeMWt3B
         i+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724451834; x=1725056634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6IFPs/YJKFaYy3RoCHH1SN5YV4xFWkPxPc6QvHkhBzc=;
        b=H0+Po2qML5F7z6nM6JZsRIItxB2S9XTV8HH1nwyXC6KTQffKbAitoy/ivK7U2/iI6e
         47o9VPOG/W/4eDyvMV3YTYJIRp91rXAU19DYx9Iak86/hTJaJkmkeBcwMS5nTHYK30aE
         WUe1z0Wud7xckLds/yjuKyqjym2nGQOLdJNbBhOegT57Y3xsZhusO85Tfso7b6a7T0yt
         0KD8fSMNPJiAcOQ2dlyV05U/LMNzzm/x+ghCm0W5OZwiMH+9yhw4MR8UBJ7RJ00K57Cz
         LKDQvhBAClAPJDagMOshmdROML61MyDxqZVjpNPE7uRxhc3Ry8JOiGnT1t1Y/piKt2pY
         BBAw==
X-Gm-Message-State: AOJu0YwiqpXudA3HBxnHN2Q/YFWf0x1t9BFVYJCs7tgwEjCTC5Rqk9qQ
	nfpA5LomXydrFvt2cR4ZdDColN563ieWuXRoIrrXcURaxWX+ZZ/Rf9GW2w==
X-Google-Smtp-Source: AGHT+IGtg7TG/21AqcWVwbyQCWgFfL4Xph4ffhY2qBy3rPvdY4cvIPP97htG7f2T1lbnyl7ms5mZeQ==
X-Received: by 2002:a05:6102:3953:b0:498:d3b7:be39 with SMTP id ada2fe7eead31-498f4c5efcdmr3904305137.29.1724451833799;
        Fri, 23 Aug 2024 15:23:53 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f41f507sm218860385a.132.2024.08.23.15.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 15:23:53 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 7/8] auto-t: add affinities property for station, and extended_service_set
Date: Fri, 23 Aug 2024 15:23:38 -0700
Message-Id: <20240823222339.328006-7-prestwoj@gmail.com>
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

