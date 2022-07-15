Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A576E33F0
	for <iwd@lists.linux.dev>; Fri, 15 Jul 2022 15:26:27 +0000 (UTC)
Received: by mail-ot1-f51.google.com with SMTP id e1-20020a05683013c100b0061c1a6b8d11so3710243otq.8
        for <iwd@lists.linux.dev>; Fri, 15 Jul 2022 08:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gbFFYnCcdI6CbSbosGv5qlAVAln+W+0+7FZIT5UuY4M=;
        b=NXp1alGI1s990O1C4KuCzxxV/uuWSSm+NgFjqzugn40xG/txmIFyKcI8jXtB7/jlv/
         JDnoUN1guy51Fnw1mMwmpQc2e7b6Rtu+emfWAtvqGR03Hnj2pBXxICN463as509RJ7OW
         /9plfwG7K+756xe/EvHXgmB/mGr5hUt1dPVIX8nENoVOTLsTaE1iDYugOpokMX19tff3
         6dfTnurjy7opG/5VsGqXrLi1EhQmHBh5lJ1XKN2NYBcHpofKBJkwiy2AjjjBuMriqTp1
         kfIGWBcvZLWv0lAbWZjJ0LwXIX5q0GM3M+Ty2/qJwQiHjbrn6MEN9Z2IQfAKpS1gML/q
         q7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gbFFYnCcdI6CbSbosGv5qlAVAln+W+0+7FZIT5UuY4M=;
        b=R/+o+EGgPb8P8MkNqdbz4KocTfwRjv9ijvhVXKhx4zO3/FTw+6z9uP864u5OCfU0oE
         jQ0yE9DE6+9qEvCaQq9TseiTWmGZnpnaTBz0bAafAI+9GGc2pe56zKCeNWWcGLpGERo1
         Sp7TbmzJUD2xn8xul4PUWekZbNWmZ6Li7vwS/xm7hfMz+UPWY14GdQJzYIPY8Rlv87DP
         KHX+MdhAcS167Y3Tt/GylwJfhx0daiNSFP/+5/pb1STO7SN1P3x9Xp+qn2Efx01mxS+c
         w6X3jlnm+V0fHD0oKOFkY8zVFK5Vxzf8XhDRnu3/bpqoWPdszhykSpq/ogF/gW+2Hork
         fJmA==
X-Gm-Message-State: AJIora95P25OH5lI2dKmY66KkAQPLiD3sfbjffuRJlgNMhWglE/Z2D5p
	33TwqaPjPR9GsDnk3as4km67gXJ9W1E=
X-Google-Smtp-Source: AGRyM1tbx3+j4ty3KB7L7+j4ACSI2JzJbUoGuzvrwYezIxxDlnnLSAlptbVqIzknniU6i3/eN+T77w==
X-Received: by 2002:a05:6830:44b:b0:61c:380c:8cd6 with SMTP id d11-20020a056830044b00b0061c380c8cd6mr5641017otc.34.1657898786465;
        Fri, 15 Jul 2022 08:26:26 -0700 (PDT)
Received: from localhost.localdomain (216.106.68.145.reverse.socket.net. [216.106.68.145])
        by smtp.gmail.com with ESMTPSA id t3-20020a4aadc3000000b00425cd32b1absm1931002oon.25.2022.07.15.08.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 08:26:26 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH] iwd: Add missing module dependencies
Date: Fri, 15 Jul 2022 10:14:42 -0500
Message-Id: <20220715151442.5355-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220714165240.244e25gcyjtaxhx2@bang-olufsen.dk>
References: <20220714165240.244e25gcyjtaxhx2@bang-olufsen.dk>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Certain module dependencies were missing, which could cause a crash on
exit under (very unlikely) circumstances.

  #0  l_queue_peek_head (queue=<optimized out>) at ../iwd-1.28/ell/queue.c:241
  #1  0x0000aaaab752f2a0 in wiphy_radio_work_done (wiphy=0xaaaac3a129a0, id=6)
      at ../iwd-1.28/src/wiphy.c:2013
  #2  0x0000aaaab7523f50 in netdev_connect_free (netdev=netdev@entry=0xaaaac3a13db0)
      at ../iwd-1.28/src/netdev.c:765
  #3  0x0000aaaab7526208 in netdev_free (data=0xaaaac3a13db0) at ../iwd-1.28/src/netdev.c:909
  #4  0x0000aaaab75a3924 in l_queue_clear (queue=queue@entry=0xaaaac3a0c800,
      destroy=destroy@entry=0xaaaab7526190 <netdev_free>) at ../iwd-1.28/ell/queue.c:107
  #5  0x0000aaaab75a3974 in l_queue_destroy (queue=0xaaaac3a0c800,
      destroy=destroy@entry=0xaaaab7526190 <netdev_free>) at ../iwd-1.28/ell/queue.c:82
  #6  0x0000aaaab7522050 in netdev_exit () at ../iwd-1.28/src/netdev.c:6653
  #7  0x0000aaaab7579bb0 in iwd_modules_exit () at ../iwd-1.28/src/module.c:181

In this particular case, wiphy module was de-initialized prior to the
netdev module:

Jul 14 18:14:39 localhost iwd[2867]: ../iwd-1.28/src/wiphy.c:wiphy_free() Freeing wiphy phy0[0]
Jul 14 18:14:39 localhost iwd[2867]: ../iwd-1.28/src/netdev.c:netdev_free() Freeing netdev wlan0[45]
---
 src/netdev.c     | 2 ++
 src/offchannel.c | 1 +
 src/rrm.c        | 1 +
 src/scan.c       | 1 +
 src/station.c    | 4 +++-
 5 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/src/netdev.c b/src/netdev.c
index ece2aab39a10..5a6a7b703b51 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -6676,3 +6676,5 @@ void netdev_shutdown(void)
 
 IWD_MODULE(netdev, netdev_init, netdev_exit);
 IWD_MODULE_DEPENDS(netdev, eapol);
+IWD_MODULE_DEPENDS(netdev, frame_xchg);
+IWD_MODULE_DEPENDS(netdev, wiphy);
diff --git a/src/offchannel.c b/src/offchannel.c
index c6fed569b30e..80d4ad5618f0 100644
--- a/src/offchannel.c
+++ b/src/offchannel.c
@@ -322,3 +322,4 @@ static void offchannel_exit(void)
 }
 
 IWD_MODULE(offchannel, offchannel_init, offchannel_exit);
+IWD_MODULE_DEPENDS(offchannel, wiphy);
diff --git a/src/rrm.c b/src/rrm.c
index d32ffbff4237..311e62fbe5d3 100644
--- a/src/rrm.c
+++ b/src/rrm.c
@@ -890,3 +890,4 @@ static void rrm_exit(void)
 
 IWD_MODULE(rrm, rrm_init, rrm_exit);
 IWD_MODULE_DEPENDS(rrm, netdev);
+IWD_MODULE_DEPENDS(rrm, frame_xchg);
diff --git a/src/scan.c b/src/scan.c
index cc6e682c93ee..241fecbb05e6 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -2198,3 +2198,4 @@ static void scan_exit(void)
 }
 
 IWD_MODULE(scan, scan_init, scan_exit)
+IWD_MODULE_DEPENDS(scan, wiphy)
diff --git a/src/station.c b/src/station.c
index e5972269a92f..02f21c764fe4 100644
--- a/src/station.c
+++ b/src/station.c
@@ -4614,4 +4614,6 @@ static void station_exit(void)
 
 IWD_MODULE(station, station_init, station_exit)
 IWD_MODULE_DEPENDS(station, netdev);
-IWD_MODULE_DEPENDS(station, netconfig)
+IWD_MODULE_DEPENDS(station, netconfig);
+IWD_MODULE_DEPENDS(station, frame_xchg);
+IWD_MODULE_DEPENDS(station, wiphy);
-- 
2.35.1

