Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EBFD2E4
	for <iwd@lists.linux.dev>; Mon, 19 Jun 2023 22:58:01 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-311367a3e12so2821654f8f.2
        for <iwd@lists.linux.dev>; Mon, 19 Jun 2023 15:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687215480; x=1689807480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hC9aV+z0cPBb/pu6keGlOyYh+Nkai9ZUzUT65FfpSIM=;
        b=qvoseiuJLjY6KSUcWhrdu4spqkRB4Por0tG6cLWW9cNY2Rp+30QA1KjXodWaiGBepq
         kzCgoXvgl9+HHPIqvnbgVqPzPsw4ZZ3wnV00Y4Ir1DTa/MIutFB7YRS/SnAQHmaJ+v2B
         +uG1Wg7uUl5gpHNUEi9TyRLvg04+SiysRbqxIs2WbxlnvrAoJJzp8QQ8GVdPy95cYEo8
         VXiV4PKWyOGvQgtuWw+JQMIa8bStswZlbb/dm4oy+017ZAewzrZsNVQlnKoTDBYfFobv
         AVrOdmCp6+k67JyqLsQ/CCix8zTwp5GxcVC0dqUPhm9GcSFh4uJ2M56e23tXh+XzsbAt
         E3Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687215480; x=1689807480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hC9aV+z0cPBb/pu6keGlOyYh+Nkai9ZUzUT65FfpSIM=;
        b=iku7jlMaDdjSM8LVKJCCsPBAA+dq69LnJn7rrsDnzb2D/ZAI1fLvG6Tmf5yzSySE5B
         6C39g34FC6PPLN9s5NDJf2ETvcVgMk1COllSva2BpjvOHEfTf9V6oarl+ivCVm5HsRe1
         hyFcrfGihJ/Kf/6rJQRm+ArXATyseOvFYjDYUM4KVvSsF2Afv/ZE9fTn+e7xDaVFRAvt
         hUFZNO9i+BQKG1JxmkqQLyUWsOGA0JR07yfKO4BMpaXoH0KXnh7IysD3sTnTboB6HBRi
         u0gmTpAQTxxp5nkqk1T/snuzrX9bpjX7giefKdGUn/JI+LtP0OWHwNQFYRynLJ8550NW
         IUKg==
X-Gm-Message-State: AC+VfDxqaED/vIfi09Uj86W7851QtibnP+Fs9m+pW7tEhUf3bgzIgUfN
	qYw00M+17hT4LM2DQZnpzzb3j1dP2nr3Aw==
X-Google-Smtp-Source: ACHHUZ6xA6pd/jrGNTV8oknLvTp+ouzd1DCG0a02Kg8xpeM+icUzMzHwGUE+Xd0e4uQFe/JcS2iHMg==
X-Received: by 2002:a5d:6145:0:b0:30f:c4ca:e9d6 with SMTP id y5-20020a5d6145000000b0030fc4cae9d6mr8509467wrt.54.1687215480017;
        Mon, 19 Jun 2023 15:58:00 -0700 (PDT)
Received: from LOCLAP699.dhl-toledo.locus ([195.55.200.178])
        by smtp.gmail.com with ESMTPSA id z11-20020a5d4c8b000000b0030c4d8930b1sm571946wrs.91.2023.06.19.15.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 15:57:59 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 5/6] auto-t: add comment about FILS rekeys
Date: Mon, 19 Jun 2023 15:57:45 -0700
Message-Id: <20230619225746.462791-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230619225746.462791-1-prestwoj@gmail.com>
References: <20230619225746.462791-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FILS rekeys were fixed in hostapd somewhat recently but older
versions will fail this test. Document that so we don't get
confused when running tests against older hostapd versions.
---
 autotests/testFILS/fils_256_test.py | 4 ++++
 autotests/testFILS/fils_384_test.py | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/autotests/testFILS/fils_256_test.py b/autotests/testFILS/fils_256_test.py
index 7018f0f2..ca20f683 100644
--- a/autotests/testFILS/fils_256_test.py
+++ b/autotests/testFILS/fils_256_test.py
@@ -55,6 +55,10 @@ class Test(unittest.TestCase):
         testutil.test_iface_operstate()
         testutil.test_ifaces_connected(device.name, hapd.ifname)
 
+        #
+        # TODO: If this is failing its likely due to an older hostapd version
+        #       not containing commit 7ee814201b72
+        #
         hapd.rekey(device.address)
 
         device.disconnect()
diff --git a/autotests/testFILS/fils_384_test.py b/autotests/testFILS/fils_384_test.py
index ce8904df..5ff6ec36 100644
--- a/autotests/testFILS/fils_384_test.py
+++ b/autotests/testFILS/fils_384_test.py
@@ -55,6 +55,10 @@ class Test(unittest.TestCase):
         testutil.test_iface_operstate()
         testutil.test_ifaces_connected(device.name, hapd.ifname)
 
+        #
+        # TODO: If this is failing its likely due to an older hostapd version
+        #       not containing commit 7ee814201b72
+        #
         hapd.rekey(device.address)
 
         device.disconnect()
-- 
2.25.1

