Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935371EA11
	for <iwd@lists.linux.dev>; Tue,  1 Nov 2022 20:17:58 +0000 (UTC)
Received: by mail-pf1-f173.google.com with SMTP id v28so14310585pfi.12
        for <iwd@lists.linux.dev>; Tue, 01 Nov 2022 13:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZehA54EXLoFpuihBQqE/s3qSP5Wr2j1HNX08mqpwWi8=;
        b=jyrcetSLIXPrMMhNnTjF6n1+G0Ai5mkpqSeGKdbinCRKDPImTNVTFGKMJSc485avEv
         gfoUhMrjnRRK9Is4V8ny/YW39lP/2EeM67V+rk/Z7tz09cass9OU2um2bsbn+SitQzMW
         DQsO/lShOvXwx9wHhvOMnY+Tv92hgrherR71psIpk5PRDCr4DFObXS0lg98OI9sZRknk
         s0IRqDX8Vxx3e6K9uB0N31xLpiNgFQq5NyunmnB74JmnN1FWI8mnPN5EawljMaBvOeWo
         qaKFlAhPr6bc6RAU1d26EemU8IYnpJPNUgObRC8KX2iSyAln8/zaDXeJCl8edtY66hk/
         ndDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZehA54EXLoFpuihBQqE/s3qSP5Wr2j1HNX08mqpwWi8=;
        b=xa/A24+0ZWLrRPxdQ+u1A2Cf+kj4ylUrES0vgvDPdK78lkGr4ofT9oRXDrvYIbqmZW
         vyuHXQsSRGBDXsAF2GcFlUyECcVVAT7MPJH+Y6GR14unadMdDaAo0GG5/WF5KQjkcbCl
         mQKpqQIOHp76XqD7DjieApw/oFMuULzUk7df0Cv8pRFs5SSbAoX9qtINEmImZ39B2743
         ESkImNCvtls6pxCyC84nE6Rgk13+FlP1hoYqSHJAmMajvWNzEIRNaCFSKeLCTaujM309
         jtfuUgq2XShPNdNDd8ldjyIacyw68VJJJdxoPD4xX+0pUBNIse0aylphr1ZoCG2xeFWQ
         mJew==
X-Gm-Message-State: ACrzQf2MYrlNt0YhZ06kHcVN87goR7n4o6bkPcCoacQH5OLhEiH+caUN
	IPkThqC2zHwOy4bmjIb8UmiFWj916Uc=
X-Google-Smtp-Source: AMsMyM6HUpdHUzczlzYe6DauywLkO+kSA89+08n6aOXQuV6IcZuob69iOGNrlxriXtpkfh2CfO5CfA==
X-Received: by 2002:aa7:8750:0:b0:56c:318a:f811 with SMTP id g16-20020aa78750000000b0056c318af811mr21172640pfo.14.1667333877911;
        Tue, 01 Nov 2022 13:17:57 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id z15-20020a170903018f00b00180a7ff78ccsm6781681plg.126.2022.11.01.13.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 13:17:57 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 06/17] ap: add frequency to AP interface
Date: Tue,  1 Nov 2022 13:17:36 -0700
Message-Id: <20221101201747.143379-6-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221101201747.143379-1-prestwoj@gmail.com>
References: <20221101201747.143379-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/ap.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/src/ap.c b/src/ap.c
index 834fa089..baf90c1b 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -3676,6 +3676,9 @@ static void ap_if_event_func(enum ap_event_type type, const void *event_data,
 		l_dbus_property_changed(dbus_get_bus(),
 					netdev_get_path(ap_if->netdev),
 					IWD_AP_INTERFACE, "Name");
+		l_dbus_property_changed(dbus_get_bus(),
+					netdev_get_path(ap_if->netdev),
+					IWD_AP_INTERFACE, "Frequency");
 
 		l_rtnl_set_linkmode_and_operstate(rtnl,
 					netdev_get_ifindex(ap_if->netdev),
@@ -4026,6 +4029,24 @@ static bool ap_dbus_property_get_scanning(struct l_dbus *dbus,
 	return true;
 }
 
+static bool ap_dbus_property_get_freq(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	struct ap_if_data *ap_if = user_data;
+	uint32_t freq;
+
+	if (!ap_if->ap || !ap_if->ap->started)
+		return false;
+
+	freq = band_channel_to_freq(ap_if->ap->channel, BAND_FREQ_2_4_GHZ);
+
+	l_dbus_message_builder_append_basic(builder, 'u', &freq);
+
+	return true;
+}
+
 static void ap_setup_interface(struct l_dbus_interface *interface)
 {
 	l_dbus_interface_method(interface, "Start", 0, ap_dbus_start, "",
@@ -4045,6 +4066,8 @@ static void ap_setup_interface(struct l_dbus_interface *interface)
 					ap_dbus_property_get_name, NULL);
 	l_dbus_interface_property(interface, "Scanning", 0, "b",
 					ap_dbus_property_get_scanning, NULL);
+	l_dbus_interface_property(interface, "Frequency", 0, "u",
+					ap_dbus_property_get_freq, NULL);
 }
 
 static void ap_destroy_interface(void *user_data)
-- 
2.34.3

