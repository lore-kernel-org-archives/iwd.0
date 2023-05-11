Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F7020695
	for <iwd@lists.linux.dev>; Thu, 11 May 2023 18:48:26 +0000 (UTC)
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-757742c2e5fso470171885a.1
        for <iwd@lists.linux.dev>; Thu, 11 May 2023 11:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683830905; x=1686422905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bvyiYUqoqdRmkFTliyZi62r+N0b0AOgiyYrPEVc04rg=;
        b=AXAH/k3jqz5FJItuSYXazeCesIzZ5XpuhVfGWL6GfFx9DjjszYqZgWVS8N0flnuHEs
         KAdw6nmFcefzONvAbnR9SFv7riLcbEhTqYy64k33EbDSG+qQlIWjhB0lGI9aWv2uQBmU
         uIqzCjcX/54tr5mbTSYWZC+rn4GMio/QyWeu7hey6Q2SrKtObQpsrdWUmbeARR9wDD3M
         kFQ7iS9DhtwC/r5l/twiI3l2My8Rd3zSiMJ71fKwVcY9JU9+xK3HN4/uj0yPRf9RYngM
         GIhL9ubrVUF9PJnIbQRnNgA5/z3UXevkCDI3LZe/bF4NFPD0iEHJ9gJVMWYiIkHXoYLQ
         M/lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683830905; x=1686422905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bvyiYUqoqdRmkFTliyZi62r+N0b0AOgiyYrPEVc04rg=;
        b=lc8E/2KuIJymPpZjDF+TdPJJewfUsp16xrjT8M7iOxKVucPg8PZ4Oo9mPitBOXClqt
         lo12jz/gmMrpclbjLGjgwgwoDUWzx6T027kMTMLbH80+oUhExYnN/Ak2fwa2ifrl5sbP
         2zPcfHjLVS0v5o9mkHptgVcJjKHAh3pURwDsCSTD3/gYq9L5XMXtwekdJXqxLGk8W/HT
         fOoIxvtppVyxmECzZ6urxTA5zX9DnSpqqgP7/MD5rKUN4zAwXeFMMZEWvZ58L2MT2MRo
         3caFAyCdhF8FojAX2vEdpE9DXkhWNSGtGrgOffmSE5r7M+ZttIpS8wtBGAHc0TqHdXyB
         x8qg==
X-Gm-Message-State: AC+VfDwgqMvjhLHACnjUguqRM2ZOwyMFVH+564VJgUWQ67MeySjOctqU
	BE5dpgUr5pTup40fGG6tkbP5da1CZao=
X-Google-Smtp-Source: ACHHUZ6mhSnxh0CTXjynTv1hTWiyw5lv+i8KW24IhvXQsWe8RhuTrunpRXc9kLZpnpOE37xs1YicYw==
X-Received: by 2002:ad4:5ae5:0:b0:621:1b1d:7dde with SMTP id c5-20020ad45ae5000000b006211b1d7ddemr31546616qvh.8.1683830905070;
        Thu, 11 May 2023 11:48:25 -0700 (PDT)
Received: from LOCLAP699.rst-01.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id s17-20020a0cdc11000000b005ef42af7eb7sm2447221qvk.25.2023.05.11.11.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 11:48:24 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/3] auto-t: increase timeout in testPSK-roam
Date: Thu, 11 May 2023 11:48:17 -0700
Message-Id: <20230511184817.79203-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230511184817.79203-1-prestwoj@gmail.com>
References: <20230511184817.79203-1-prestwoj@gmail.com>
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

