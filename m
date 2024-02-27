Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83233D387
	for <iwd@lists.linux.dev>; Tue, 27 Feb 2024 18:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709058878; cv=none; b=u5fL/3y2CnF4R6RvqOisooFh5Hg8Cs6hGnDatqnGgb0L/pzsg6/a9uFno165TvlavsQ0oPljfyF+nAaifPqDNiukTjDo6mTENyX67LEB7oPyOyIiOa5chj0DtT3CD66UnKnck/6QUilgrkQClZ8ao99SN0oQyLabgaxXeVDQuFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709058878; c=relaxed/simple;
	bh=u4/CapjLYiKQXd7+rGdv+iSe17B8CmqHvNF5qDElwMM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CZ2K786zQC58cwI2Oyf0wKOWvbUumPGjw6KXZ52/azL58pQfIbmdbzWXIbUdQCcFOC0mF0Ygxh0XE0RrLWT8zuEYN278aNavobZXorPXMnnIXRKNhSgdSG8KfAY16i3crWOvQfSNjz5Yc9lWWVqyyD4CqdzP4Mxf79d6ldiN1NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LnvfNYKR; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnvfNYKR"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-429de32dad9so30311211cf.2
        for <iwd@lists.linux.dev>; Tue, 27 Feb 2024 10:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709058875; x=1709663675; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rg2PNCZPcwjXqnwYpcqy+L+PMJ8eAB5YOS7ZXv6a7Ys=;
        b=LnvfNYKRhRV5U0UGEkCoygyoDQ4qm1fBqxjthHT0pIDXyMX3PrWaez+i5+rIaGU2a/
         ouTYL8Wgb7lHnt51u0ihbJVfdieMuOKds91rgShsOsuExRBe8xbkXkMwfFgJnjwtNPtA
         57vpW2WiHF3A2P9lR1BoJcDl1jbOVoQck/8kDgmgVtazbG2p/AwHRlKSHNCBaRL4fiLD
         RrmaxlUxKo6haX4TBjZM27+6j29Xvds1GODwhAOolopPxOlekP+XjyffFD4bCe1ukgOL
         nILbxBPdhByVIG5qPOmph99LWMwwSDDvt3bhXCsoR9dYLArfZNc7cu1PJmtHPcENw2G2
         oHVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709058875; x=1709663675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rg2PNCZPcwjXqnwYpcqy+L+PMJ8eAB5YOS7ZXv6a7Ys=;
        b=Eby7HAJx9w6O34pidqmh2Z+b8s0zx3IDP66lsZJB4JO0MhKSENvFpgl3AgDIc2xW0l
         4QZFNwlPNwQ25BKn+NkYAJjNIv+WzYZUnnwwPHtviBa71pLPZaA4AlPkcIOTYJ0Gmeme
         0jxbn2noT0vAcuiDuW2/4QMqTDhNQ79Jk2g9vZv7ZEXe1FE5/Y73ltXHdR0eN4hwQlMw
         q8cL4OkZ0akvThKZXIC45dCdCjAztmiEh6s9rMmLY2WpwGfkgbU+fcyKShoGufCUV9PK
         jCP0a+fXMgHJ0sfQyw3U84S+HpiPUBJ+uYd1mJxWdZu5hGSa7W/JihFjjwo0iO+1g8dm
         CKoQ==
X-Gm-Message-State: AOJu0Yycw5yM2eqK/hvT4gR9Mzf3yedDYKa8j+LIYExdhhTid//OS4ks
	KvDqj2tas47ThmsPZiiaOWGbOZxBdoSVWAZTHljHgURYwlx2WVJtxOIxV7RH
X-Google-Smtp-Source: AGHT+IHP4b9lUB6zmZ7BsffWpou7BEK3o/FkoVHEdiphX0ct+7g+TOG5wUoh9ArUty5GAg6vDQHzKQ==
X-Received: by 2002:ac8:5f11:0:b0:42e:5f6d:8f2d with SMTP id x17-20020ac85f11000000b0042e5f6d8f2dmr11956245qta.54.1709058875441;
        Tue, 27 Feb 2024 10:34:35 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id jy2-20020a05622a818200b0042e3468a98csm3819617qtb.4.2024.02.27.10.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 10:34:35 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 11/11] auto-t: add OWE test for auto default group
Date: Tue, 27 Feb 2024 10:34:05 -0800
Message-Id: <20240227183405.257206-11-prestwoj@gmail.com>
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

---
 autotests/testOWE/connection_test.py | 33 ++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/autotests/testOWE/connection_test.py b/autotests/testOWE/connection_test.py
index 1fdc990a..58e6560f 100644
--- a/autotests/testOWE/connection_test.py
+++ b/autotests/testOWE/connection_test.py
@@ -64,6 +64,39 @@ class Test(unittest.TestCase):
         self.assertRaises(Exception, testutil.test_ifaces_connected,
                           (hapd0.ifname, device.name, True, True))
 
+    def test_auto_default_group(self):
+        wd = IWD()
+        hapd = HostapdCLI(config='ssidOWE-1.conf')
+
+        devices = wd.list_devices(1)
+        device = devices[0]
+
+        device.get_ordered_network('ssidOWE')
+
+        device.connect_bssid(hapd.bssid)
+
+        condition = 'obj.state == DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
+
+        # Should have rejected group 20, but still connected on 19
+        self.assertEqual(device.event_ocurred("ecc-group-rejected"), True)
+
+        testutil.test_iface_operstate()
+        testutil.test_ifaces_connected(device.name, hapd.ifname)
+
+        device.disconnect()
+
+        device.connect_bssid(hapd.bssid)
+
+        condition = 'obj.state == DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
+
+        # IWD should have used the default group, no rejection
+        self.assertEqual(device.event_ocurred("ecc-group-rejected"), False)
+
+        testutil.test_iface_operstate()
+        testutil.test_ifaces_connected(device.name, hapd.ifname)
+
     @classmethod
     def setUpClass(cls):
         pass
-- 
2.34.1

