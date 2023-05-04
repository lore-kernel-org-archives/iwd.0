Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D606C133
	for <iwd@lists.linux.dev>; Thu,  4 May 2023 21:52:53 +0000 (UTC)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-61af33bdf1dso5398466d6.2
        for <iwd@lists.linux.dev>; Thu, 04 May 2023 14:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683237172; x=1685829172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d/Yt7HY6cejcOsUV6ARcKNMru60mwklhN1QVrjN7Khw=;
        b=ZSwjmqLlC19J2fOJsZY60KqyFoRaDVR1qpMyDt7defniuqAQSMUrRRzf13D9JM1lf9
         pINtS5kN5SIKbI9V5QxNsNUPBN4IexMYfVKZUMl3L/Ve/MIr1iwDOl5ZDHmxywLN1vn7
         CmNZiSZIMb6AQmZ3LQiP8LZ0fo8kcT5FF1zZ+J6ZCkqcDGAox/BbFGkpCkotPoxbafZq
         VZ9rBydlqbjurR5lKg8XLlmqy7lST2FgunxvRl1T7sht/cLR5BkvqV0xpozyH0eP4APP
         z7Ckpf+fm2SfH3gfRozbnaVfepPUlb8p/HPkEFIRyh4yPMEGt8aLTcCSpMOKdz6ozaDL
         ycQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683237172; x=1685829172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d/Yt7HY6cejcOsUV6ARcKNMru60mwklhN1QVrjN7Khw=;
        b=TVEB4p94Dh50n0+HK7Dcu95m52VsvdTaL17zI0BO//MO7PBNNjl0LPo0WQgr65gllf
         PGGVXizxxHUugmEyG5X4QdODkgPZr3L2C9TzErc7LKvt1MLGuyJc5EFrujRtZcCqXxrn
         KQiMucgjEjHXm0xxc16TYEKYETA+hZw0g/A5ZqdIN5NwKWctTY/KzF+czWFBV5tOFyJQ
         g3VlFk1dwnQOsjxMMTBdFjj/+xg5Bt8ZzIYXFxD1Ehmsbu/a57emO50nT5YEcgn3K1T3
         2aFSxJUub17i0pJplxm4YQSV4gPUAs2xSJJT8CU9D7a636SyGQEw/oEf7ootz8n4Lv1r
         VVQA==
X-Gm-Message-State: AC+VfDyDz/Hiw9RcBwy6U0PwApbqsB0ALcNVpkbekVjI2u/TXalB1Ag5
	tXprlMfTK7GpMM+gy3LvRJCV+cOaGNg=
X-Google-Smtp-Source: ACHHUZ58huyNJxa5yVDJbt4anlB9j3YmOmFBHKBEgrs3edDYEjNODPQ1sUN0v88YY3xod8d4uBNEag==
X-Received: by 2002:a05:6214:2689:b0:5cc:277c:b5e with SMTP id gm9-20020a056214268900b005cc277c0b5emr17715375qvb.33.1683237171871;
        Thu, 04 May 2023 14:52:51 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id v9-20020a0cdd89000000b0061b5b399d1csm52262qvk.104.2023.05.04.14.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 14:52:51 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/3] hwsim: remove 'optimization' sending to only known MACs
Date: Thu,  4 May 2023 14:52:45 -0700
Message-Id: <20230504215247.581443-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Based on the comment hwsim would only send frames to known MACs
which on its face seems reasonable. But in reality there shouldn't
ever be frames going to unknown MACs, at least not unknown to the
kernel. We can hit this case, though, when using network namespaces.
Each namespace is siloed and hwsim instances only know about radios
in that namespace.

In order to support hwsim and namespaces, this restriction is
being removed.
---
 tools/hwsim.c | 33 ---------------------------------
 1 file changed, 33 deletions(-)

diff --git a/tools/hwsim.c b/tools/hwsim.c
index 47352ad4..10a9db5f 100644
--- a/tools/hwsim.c
+++ b/tools/hwsim.c
@@ -1501,43 +1501,10 @@ static void process_frame(struct hwsim_frame *frame)
 		struct send_frame_info *send_info;
 		bool drop = drop_mcast;
 		uint32_t delay = 0;
-		const struct l_queue_entry *i;
 
 		if (radio == frame->src_radio)
 			continue;
 
-		/*
-		 * The kernel hwsim medium passes multicast frames to all
-		 * radios that are on the same frequency as this frame but
-		 * the netlink medium API only lets userspace pass frames to
-		 * radios by known hardware address.  It does check that the
-		 * receiving radio is on the same frequency though so we can
-		 * send to all known addresses.
-		 *
-		 * If the frame's Receiver Address (RA) is a multicast
-		 * address, then send the frame to every radio that is
-		 * registered.  If it's a unicast address then optimize
-		 * by only forwarding the frame to the radios that have
-		 * at least one interface with this specific address.
-		 */
-		if (!util_is_broadcast_address(frame->dst_ether_addr)) {
-			for (i = l_queue_get_entries(interface_info);
-					i; i = i->next) {
-				struct interface_info_rec *interface = i->data;
-
-				if (interface->radio_rec != radio)
-					continue;
-
-				if (!memcmp(interface->addr,
-						frame->dst_ether_addr,
-						ETH_ALEN))
-					break;
-			}
-
-			if (!i)
-				continue;
-		}
-
 		process_rules(frame->src_radio, radio, frame, false,
 				&drop, &delay);
 
-- 
2.25.1

