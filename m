Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC228471
	for <iwd@lists.linux.dev>; Fri,  4 Nov 2022 16:38:09 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id m6-20020a17090a5a4600b00212f8dffec9so5032530pji.0
        for <iwd@lists.linux.dev>; Fri, 04 Nov 2022 09:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7nNtHXCV96L5t2y4Vr2ClYVoWJyGO4k/Fwg1Qzb3hFI=;
        b=mNs1o1QSgQn1qfbQgJwp0pjxBQYhv6UAHBEPcDF5r7RoxUevlMjLsJPqKhY7DRJglv
         V1EqOR44zcop7I9hlrR1vFDA9dQb7Hwf344ndovCa0id1lBuN2xXxCqfFWs5Uk/iQ5/9
         p602t/HhIGXtnyc/kVU4F+eoEaJg3VD+5QH5X0pSlkabxUQ8aCZRm7j/IsbfM4zU3grz
         WQUKvctHMWVMz8AE11PYpe+TgcZkkYbnJNv9RlEnhSMAL/iVtYxX0xit08gGWzn59FZT
         j6p/mwvy59jEKlZ4xY0ELMYedjTIW5BWHDLhVowF2HXtkqRFkj/2yeeNrj+fj1Z/BeCG
         9FDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7nNtHXCV96L5t2y4Vr2ClYVoWJyGO4k/Fwg1Qzb3hFI=;
        b=lxPU0l8webzCEPtAMOWDyIdOqTzWZM3Vq9qYkUm7D5CQJ7GkUoLY4xiB1OT9vVGq2Q
         i31FYqFSl34GqKThaUgiTnX2V92mvAviJ0ioa07N7Nfr+jx8wLRuq4CCD9v03EteW2eb
         jbSp8dUNhL5lJ3ZhrxF2ggL+u6u1Ik9nJT9EQyr2QmCMQbFltBdgtWVtOzxWrWMMcX+w
         HXAJ8ZWoZ1c7Lyfy6fFQ5Qq8sZoijsAC28Bit/lE2kg7CMg7EYKqn68exEY8hu1vVGl7
         gif1tiKTf8NBgu4l/xKf6Ffc9lNawJzYO436M8e24yP8ED9EfLEq1QHyIR6VZsP2UZHV
         2w1A==
X-Gm-Message-State: ACrzQf0n511H2uLyKPuW0eB1Ckk7siQWQuACdJfHmC0ReZr21qOpvDuK
	3iIPopH0ro2eRaXFvKgYWQGMS2HD5hg=
X-Google-Smtp-Source: AMsMyM6YpGR6xo8MEHc8ERNe+Bj86HC4hA3hy0nhDNd5zKsNITU/Jk7RdKXIRALKIqOJPmFuXuki/A==
X-Received: by 2002:a17:902:ec8e:b0:186:f4ba:a7fc with SMTP id x14-20020a170902ec8e00b00186f4baa7fcmr36249249plg.55.1667579889161;
        Fri, 04 Nov 2022 09:38:09 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id 65-20020a620544000000b0056e15b7138esm2904741pff.157.2022.11.04.09.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 09:38:08 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 4/6] ap: change PairwiseCiphers to string array
Date: Fri,  4 Nov 2022 09:37:58 -0700
Message-Id: <20221104163800.451867-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221104163800.451867-1-prestwoj@gmail.com>
References: <20221104163800.451867-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A comma separated list as a string was ok for pure display purposes
but if any processing needed to be done on these values by external
consumers it really makes more sense to use a DBus array.
---
 src/ap.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index 665c1857..69412174 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -3154,11 +3154,10 @@ static enum ie_rsn_cipher_suite ap_string_to_cipher(const char *str)
 		return 0;
 }
 
-static char *ap_ciphers_to_string(uint16_t ciphers)
+static char **ap_ciphers_to_strv(uint16_t ciphers)
 {
 	uint16_t i;
 	char **list = l_strv_new();
-	char *ret;
 
 	for (i = 0; i < 16; i++) {
 		if (!(ciphers & (1 << i)))
@@ -3168,9 +3167,7 @@ static char *ap_ciphers_to_string(uint16_t ciphers)
 					ie_rsn_cipher_suite_to_string(1 << i));
 	}
 
-	ret = l_strjoinv(list, ',');
-	l_strv_free(list);
-	return ret;
+	return list;
 }
 
 static int ap_load_config(struct ap_state *ap, const struct l_settings *config,
@@ -4096,15 +4093,22 @@ static bool ap_dbus_property_get_pairwise(struct l_dbus *dbus,
 					void *user_data)
 {
 	struct ap_if_data *ap_if = user_data;
-	char *list;
+	char **ciphers;
+	size_t i;
 
 	if (!ap_if->ap || !ap_if->ap->started)
 		return false;
 
-	list = ap_ciphers_to_string(ap_if->ap->ciphers);
+	ciphers = ap_ciphers_to_strv(ap_if->ap->ciphers);
+
+	l_dbus_message_builder_enter_array(builder, "s");
+
+	for (i = 0; ciphers[i]; i++)
+		l_dbus_message_builder_append_basic(builder, 's', ciphers[i]);
+
+	l_dbus_message_builder_leave_array(builder);
 
-	l_dbus_message_builder_append_basic(builder, 's', list);
-	l_free(list);
+	l_strv_free(ciphers);
 
 	return true;
 }
@@ -4115,15 +4119,16 @@ static bool ap_dbus_property_get_group(struct l_dbus *dbus,
 					void *user_data)
 {
 	struct ap_if_data *ap_if = user_data;
-	char *cipher;
+	char **cipher;
 
 	if (!ap_if->ap || !ap_if->ap->started)
 		return false;
 
-	cipher = ap_ciphers_to_string(ap_if->ap->group_cipher);
+	cipher = ap_ciphers_to_strv(ap_if->ap->group_cipher);
 
-	l_dbus_message_builder_append_basic(builder, 's', cipher);
-	l_free(cipher);
+	/* Group cipher will only ever be a single value */
+	l_dbus_message_builder_append_basic(builder, 's', cipher[0]);
+	l_strv_free(cipher);
 
 	return true;
 }
@@ -4149,7 +4154,7 @@ static void ap_setup_interface(struct l_dbus_interface *interface)
 					ap_dbus_property_get_scanning, NULL);
 	l_dbus_interface_property(interface, "Frequency", 0, "u",
 					ap_dbus_property_get_freq, NULL);
-	l_dbus_interface_property(interface, "PairwiseCiphers", 0, "s",
+	l_dbus_interface_property(interface, "PairwiseCiphers", 0, "as",
 					ap_dbus_property_get_pairwise, NULL);
 	l_dbus_interface_property(interface, "GroupCipher", 0, "s",
 					ap_dbus_property_get_group, NULL);
-- 
2.34.3

