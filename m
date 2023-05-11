Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDDC363
	for <iwd@lists.linux.dev>; Thu, 11 May 2023 18:52:58 +0000 (UTC)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-61a80fcc4c9so40852166d6.2
        for <iwd@lists.linux.dev>; Thu, 11 May 2023 11:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683831177; x=1686423177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bvyiYUqoqdRmkFTliyZi62r+N0b0AOgiyYrPEVc04rg=;
        b=qy9mLVp6ivvYYveTmaOXqDnpl5pSch23B6LDICr0aKV5ayr4xdJwLx1KmPcePSA9EQ
         vqDjrkuMVIwRRAjwqKLJAJTgcdWK4KuW9VJRCzOu27eYjMFNNi5yzTlzCS3huGmByYqv
         KAJL/9blJfFfWTtbjN4tt6tCS27Fkv88FyC3aZsmXZtEfCxwyv4gmhuDDv/TlnAzUdR+
         pSN6tJUeEb7fIcpzedZ7n68ZsieJLDJbyiXN+d14YpVkQ9LmI4sUY2sBk3KlwSExx++c
         O2BqAxbLsYbmxRLyV1dIh9elGpS66QJRmTY37PUfs7QeTegrUsAFL68CGBj3gQEnTlMR
         1P6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683831177; x=1686423177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bvyiYUqoqdRmkFTliyZi62r+N0b0AOgiyYrPEVc04rg=;
        b=HaNayWm1cjH0g8F+Kv0ROmjG9H5qLEzvNM2z+mnwLOfiUK/T+OitCwMgDt5G1YpU+B
         wsBzri0nmKjFoZ3rdjiVplKO4scIadTK0tav8DnmHjz9FxTLljPigGB3Z7B2c2781zac
         fZ17c8tzQfn7YM+HUXb4PFopU8thfUrHyhzzn4oq475Vu6Dc27FJ+NPJCjUhNB7S9YgL
         wKnpM10gVONB+IC1HZH93PAodlDWAQpzGr0DbqQ2PfW3QCwMS464B111z2bWV4vjkkAR
         5ReUflO6SX6FsrCgPDKOQtCuxxt5XXrA6w4Q2vnE2/BD+Aas339fYB6pHqJBycEYhL+Q
         NdDA==
X-Gm-Message-State: AC+VfDyT/V7AYzKt2snfLjwvVwOkz7TxcD+Mrpe+hFxMZWa2+qcXfedP
	NlztzCj8Qv/oqLgGmaey8O+TvVTzTpM=
X-Google-Smtp-Source: ACHHUZ7n4Uy2utPWn1mEkzKEFr2E3/QNn/D0QZItg6pt2ZJTTSxrKoU2vZb30TEmRnvSFhueQpiwIA==
X-Received: by 2002:a05:6214:da5:b0:621:6217:f528 with SMTP id h5-20020a0562140da500b006216217f528mr6643628qvh.30.1683831177290;
        Thu, 11 May 2023 11:52:57 -0700 (PDT)
Received: from LOCLAP699.rst-01.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id c16-20020a0ca9d0000000b005ef6b124d39sm2484017qvb.5.2023.05.11.11.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 11:52:57 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 3/3] auto-t: increase timeout in testPSK-roam
Date: Thu, 11 May 2023 11:52:51 -0700
Message-Id: <20230511185251.79563-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230511185251.79563-1-prestwoj@gmail.com>
References: <20230511185251.79563-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This was causing random failures and increasing the timeout seems
to be a lot more reliable.
---
 autotests/testPSK-roam/roam_ap_disconnect_test.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/autotests/testPSK-roam/roam_ap_disconnect_test.py b/autotests/testPSK-roam/roam_ap_disconnect_test.py
index 130e1702..b5775990 100644
--- a/autotests/testPSK-roam/roam_ap_disconnect_test.py
+++ b/autotests/testPSK-roam/roam_ap_disconnect_test.py
@@ -33,7 +33,7 @@ class Test(unittest.TestCase):
         # Since both BSS's have low signal, the roam should fail and trigger
         # another roam scan.
         device.wait_for_event('roam-scan-triggered', timeout=30)
-        device.wait_for_event('no-roam-candidates', timeout=30)
+        device.wait_for_event('no-roam-candidates', timeout=60)
 
         # Hostapd sends disconnect
         self.bss_hostapd[0].disable()
-- 
2.25.1

