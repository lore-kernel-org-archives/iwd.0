Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABFC3C099
	for <iwd@lists.linux.dev>; Tue, 27 Feb 2024 18:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709058872; cv=none; b=LYVFyLpx8t15XApG3S97IBcDiT152s3TQCX8UYghaIvk8uAWEaaJ3Nm8QzPlzu+cDuYCgbEgvFBfeoLNOhjDKAUo0//LVCG1C+eRTANdEzkyZMEj1PZeNrJ3WEHgm7jAFKOxOZ1+JkNDVqLoeHHPign6CS5EmYFc8POjnf9j+qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709058872; c=relaxed/simple;
	bh=mJmGkX3XmuU37+W9ehiyLI/blKnA1DZVAj5STrBg3rY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ln+xpytfYm/M9Zb1YsdI04z6B/TDnFGFXdB+cagu+tXYMNHPQUwoLBx1kyg5Qd+ioS07doTdPhOwbU0D7T2O4z6PZnprzqUFEAfr2pIckLfJsdsQ6yLSix6PWt5f/+aeSgesq/hUOrcLehfqznlYDw0y5oFV4GfOphJGnP6JC5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mvVWuiWp; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvVWuiWp"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-42e7ed64b5fso10564301cf.1
        for <iwd@lists.linux.dev>; Tue, 27 Feb 2024 10:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709058869; x=1709663669; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=usvbDD5mOV6zAsHcYk7el9/xXUOzKSCHTYVwgCdesQg=;
        b=mvVWuiWpfLbAdMJmKnspmGeszWAhHkN5cefhoUilrZSE5brsPFith8fn31OgFiJ0ZH
         CKZgc25FiMmzlGXlghztg+piu805buEfz3Xd2q+cl+Zl3dGM7BQHrtSrJDvfoot7C5eH
         z2QN1x8JOVnDtjHelfHscj88TFl3E35j8isGtGLx+7K7IyHN9PsV9eb0SH+7tLLUjff1
         J6b0mYt362YlgPvME8bn/BmuhH6DMcuh8lL1ZErEesbh4CAKDPcDnXpfyCJ6X2kyVSi/
         Q25A42cINLirf3pIfuIqc8TlQlkQkN00TPISd85t5gsJ9NmKrPctzNaw8vvdd8u9nBlQ
         h5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709058869; x=1709663669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=usvbDD5mOV6zAsHcYk7el9/xXUOzKSCHTYVwgCdesQg=;
        b=kUAMkqqD5A34ceCsElyi7j3VYOjoo39/nB8EOC4L8Tq8Kh7DqTf8WCKYkcCZHOJB5K
         +DE+8ljxkqwqrDXxY4UiP9SZoBRuhIwRtdMFO5o44Ig09llEHWVu4WC0gLoEtqzM7sIP
         mAvXf+kcMoNGnMlodAPXmYpO8YDuLcoCFvTDE//HDBn/pad3Q6xFZ0P6PP85j/TBI+Vp
         u0U2UBR1128Yp9zpU/bL50cyaZIhfg76yvDywQdN8aiRsrq7rCbm+I6Tqws3iAFCwwmZ
         H4ueRzxGXB0s86MajHyu+UZZSO0U+c5wA1PVho4rpyMNMpjij6iaq7ce0NF6/0/fDWWP
         trGQ==
X-Gm-Message-State: AOJu0YxH6fZSMQIWQS7bqxv1cvxqGuLmmLQg2gpz91mK1pDy0YW4IVZV
	QZJla3wY9KoU+dOHH5/hYr0iSc8I6pupXTXWhbWctBJIXj8BJL15YuARABEr
X-Google-Smtp-Source: AGHT+IFEL4SplN2O73lJUJ/vdq5WlxmDnmUIE8ZK0emPHbT+qoNRs6UqZ0hrJqrRlPT1pOmRg7DXJQ==
X-Received: by 2002:ac8:5914:0:b0:42e:79e7:9110 with SMTP id 20-20020ac85914000000b0042e79e79110mr10405592qty.2.1709058869544;
        Tue, 27 Feb 2024 10:34:29 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id jy2-20020a05622a818200b0042e3468a98csm3819617qtb.4.2024.02.27.10.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 10:34:29 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 07/11] auto-t: add Device.event_ocurred
Date: Tue, 27 Feb 2024 10:34:01 -0800
Message-Id: <20240227183405.257206-7-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227183405.257206-1-prestwoj@gmail.com>
References: <20240227183405.257206-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Checks that an event happened previously, and consumes events. This
is useful for checking that an event did not happen after some
testing operations.
---
 autotests/util/iwd.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index 52c35e3d..511fb3a5 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -303,6 +303,9 @@ class StationDebug(IWDDBusAbstract):
         return ctx.non_block_wait(self._poll_event, timeout, event,
                                     exception=TimeoutError("waiting for event"))
 
+    def event_ocurred(self, event):
+        return self._poll_event(event)
+
 class DeviceProvisioning(IWDDBusAbstract):
     '''
         Class represents net.connman.iwd.DeviceProvisioning
@@ -856,6 +859,9 @@ class Device(IWDDBusAbstract):
     def wait_for_event(self, event, timeout=10):
         self._station_debug.wait_for_event(event, timeout)
 
+    def event_ocurred(self, event):
+        return self._station_debug.event_ocurred(event)
+
     def dpp_start_enrollee(self):
         ret = self._device_provisioning.start_enrollee()
 
-- 
2.34.1

